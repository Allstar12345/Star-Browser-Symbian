/**
 * Copyright (c) 2012 Nokia Corporation.
 */

#include <QtCore/QDebug>
#include <QDateTime>
#include <QtScript/QScriptEngine>
#include <QtScript/QScriptValueIterator>
#include "facebook.h"
#include "facebookconnection.h"
#include "facebookdatamanager.h"
#include "facebookrequest.h"
#include "webinterface.h"
#include <AknCommonDialogs.h>
#include <akndiscreetpopup.h>

/*!
    \class FacebookConnection

    FacebookConnection is an interface to Facebook.
 */

/*!
    \property FacebookConnection::clientId

    This \c {mandatory} property specifies Facebook application id that is used with the
    Facebook connection.

    See \l {https://developers.facebook.com/docs/guides/canvas/}
    {Facebook application guide} for futher details.
*/

/*!
    \property FacebookConnection::accessToken

    This property holds an access token for creating Facebook requests.
    With access token user is granted to create requests to Facebook data
    that is not publically available. Access token is not mandatory, since
    publically available data can be requested without access token.

    See \l {https://developers.facebook.com/docs/authentication/}
    {Facebook authentication documentation} for further details.
*/

/*!
    \property FacebookConnection::permissions

    This property holds permission list for authentication process.
    With permissions user is granted to make requests limited to scopes.
    For example user is limited to only read feed, not publishing a one.

    See \l {https://developers.facebook.com/docs/reference/api/permissions/}
    {Facebook permissions documentation} for further details.
*/

/*!
    \fn void FacebookConnection::requestCompleted(bool success, const QVariant &requestId,
    const QVariant &result)

    Custom Facebook request operation by given \a requestId has been completed.
    Success of the operation is indicated by \a success. If the operation was
    completed successfully, \a result contains response data retrieved from Facebook.
    Otherwise \a result is empty.

    If operation failed because of bad authentication credentials,
    \c authenticated has been set to false but other possibly exposed
    credential properties in derived implementations have been kept intact.
 */

/*!
    \enum FacebookConnection::HTTPMethod

    This enum specifies an HTTP method used with FacebookConnection::request() methods.

    \value HTTPGet
           HTTP GET method.
    \value HTTPPost
           HTTP POST method.
    \value HTTPDelete
           HTTP DELETE method.
 */


// Constants
namespace {
    const char *UrlAuthenticationFormat =
        "%1?client_id=%2&redirect_uri=%3&response_type=token";
    const char *OAuthUrlStr = "https://facebook.com/dialog/oauth";
    const char *SuccessUrlStr = "https://www.facebook.com/connect/login_success.html";
    const char *AccessTokenStr = "access_token";
    const char *ExpiresInStr = "expires_in";
    const char *ErrorStr = "error";
} // Constants

/*!
    Constructor
 */
FacebookConnection::FacebookConnection(QObject *parent) :
    SocialConnection(parent),
    m_facebook(new Facebook(this)),
    m_manager(new FacebookDataManager(this)),
    m_apiCall(Undefined)
{
    connect(m_facebook, SIGNAL(requestCompleted(QVariant,QByteArray)),
            this, SLOT(onRequestCompleted(QVariant,QByteArray)));
    connect(m_facebook, SIGNAL(requestFailed(QVariant,QString)),
            this, SLOT(onRequestFailed(QVariant,QString)));
    connect(m_facebook, SIGNAL(clientIdChanged(QString)),
            this, SIGNAL(clientIdChanged(QString)));
    connect(m_facebook, SIGNAL(accessTokenChanged(QString)),
            this, SIGNAL(accessTokenChanged(QString)));
    connect(m_facebook, SIGNAL(authorizedChanged(bool)),
            this, SLOT(onAuthenticationChanged(bool)));
    connect(m_facebook, SIGNAL(screenNameChanged(QString)),
            this, SLOT(onNameChanged(QString)));
}

// Property accessors

QString FacebookConnection::clientId() const
{
    return m_facebook->clientId();
}

void FacebookConnection::setClientId(const QString &clientId)
{
    m_facebook->setClientId(clientId);
}

QString FacebookConnection::accessToken() const
{
    return m_facebook->accessToken();
}

void FacebookConnection::setAccessToken(const QString &accessToken)
{
    m_facebook->setAccessToken(accessToken);
}

QStringList FacebookConnection::permissions() const
{
    return m_permissions;
}

void FacebookConnection::setPermissions(const QStringList &permissions)
{
    if (m_permissions != permissions) {
        m_permissions = permissions;
        emit permissionsChanged(permissions);
    }
}

// Common operations

/*!
    \fn bool FacebookConnection::authenticate()

    Authenticates user with Facebook. User is authenticated if Facebook
    \l {FacebookConnection::accessToken}{access token} is valid. User can
    also make requests to publically available Facebook data without
    authentication.

    Returns true if the operation was successfully started and there will be a
    authenticateCompleted() signal emitted later; otherwise returns false.
*/
bool FacebookConnection::authenticate()
{
    bool ret = m_facebook->isAuthorized();

    if (!busy() && !ret) {
        m_apiCall = Authenticate;

        WebInterface *webInterface = qobject_cast<WebInterface*>(SocialConnection::webInterface());

        if (webInterface) {
            webInterface->setActive(true);
            setBusy(true);
            setAccessToken("");
            setAuthenticated(false);
           // TRAP_IGNORE(CAknDiscreetPopup::ShowGlobalPopupL((_L("System Busy..")), (_L("")),KAknsIIDNone, KNullDesC));


            QString url = QString(UrlAuthenticationFormat).arg(OAuthUrlStr)
                    .arg(clientId()).arg(SuccessUrlStr);

            // Add permissions to the authorization URL
            if (m_permissions.count() > 0) {
                url += "&scope=";
                url += m_permissions.join(",");
            }

            webInterface->setUrl(url);

            ret = true;
        }
    }
    else if (ret){
        setAuthenticated(true);
        QMetaObject::invokeMethod(this, "authenticateCompleted", Qt::QueuedConnection, Q_ARG(bool, true));
    }

    return ret;
}

/*!
    \fn bool FacebookConnection::deauthenticate()

    Deauthenticates user with Facebook.

    Returns true if the operation was successfully started and there will be a
    deauthenticateCompleted() signal emitted later; otherwise returns false.
*/
bool FacebookConnection::deauthenticate()
{
    setAuthenticated(false);
    QMetaObject::invokeMethod(this, "deauthenticateCompleted", Qt::QueuedConnection, Q_ARG(bool, true));

    return true;
}

/*!
    \fn bool FacebookConnection::postMessage(const QVariantMap &message)

    Posts \a message to Facebook. Possible message posting types are status update,
    posting a link, and uploading a picture.

    Returns true if the operation was successfully started and there will be a
    postMessageCompleted() signal emitted later; otherwise returns false.

    Keys and values for creating a status update:
    \list
        \li "text" (mandatory) : "Your status update message."
        \li "url" (n/a)
        \li "description" (n/a)
    \endlist

    Keys and values for creating posting a link:
    \list
        \li "text" (mandatory) : "Your status message for the link."
        \li "url" (mandatory) : "http://url.to.your.link"
        \li "description" (optional) : "Description for your link."
    \endlist

    Keys and values for uploading a picture:
    \list
        \li "text" (mandatory) : "Text for your uploaded picture."
        \li "url" (mandatory) : "file:///path/to/your/picture.png"
        \li "description" (n/a)
    \endlist
*/
bool FacebookConnection::postMessage(const QVariantMap &message)
{    
    QString graphPath;
    QVariantMap parameters;

    if (message.contains("text")) {
        parameters.insert("message", message.value("text").toString());
        graphPath = "me/feed";
    }
    if (message.contains("url") &&
        message.value("url").toUrl().scheme().compare("file") == 0) {
        parameters.insert("picture", message.value("url").toUrl());
        graphPath = "me/photos";
    }
    else if (message.contains("url") &&
             message.value("url").toUrl().scheme().compare("http") == 0) {
        parameters.insert("link", message.value("url").toUrl());
        graphPath = "me/feed";
    }
    if (message.contains("description")) {
        parameters.insert("description", message.value("description").toString());
    }

    // The message is invalid if graph path not defined.
    if (graphPath.isEmpty()) {
        qWarning() << "Error. Invalid message.";
        return false;
    }

    m_apiCall = PostMessage;

    return doRequest("", graphPath, HTTPPost, parameters);
}

/*!
    \fn bool FacebookConnection::retrieveMessageCount()

    Retrieves the amount of retrievable messages from Facebook. Message count is
    limited to 2000 messages at maximum.

    Returns true if the operation was successfully started and there will be a
    retrieveMessageCountCompleted() signal emitted later; otherwise returns false.
*/
bool FacebookConnection::retrieveMessageCount()
{
    if (!sessionValidated()) {
        return false;
    }

    m_apiCall = RetrieveMessageCount;

    return getMessageCount();
}

/*!
    \fn bool FacebookConnection::retrieveMessages(const QString &from, const QString &to, int max)

    Retrieves \a max (or less of not enough available) messages from Facebook
    in the range between \a from and \a to. Range is in Unix time format.

    Empty \a from is interpreted as a minimum and \a to as a maximum in the
    sense that the range is maximized.

    Returns true if the operation was successfully started and there will be a
    retrieveMessagesCompleted() signal emitted later; otherwise returns false.
*/
bool FacebookConnection::retrieveMessages(const QString &from, const QString &to, int max)
{
    if (!sessionValidated()) {
        return false;
    }

    m_apiCall = RetrieveMessages;

    return getMessagesOnline(from, to, max);
}

/*!
    \fn void FacebookConnection::cancel()

    Attempts to cancel the currently active request. The result of the operation
    success, failure (one reason of which may be the cancellation) is available
    in the completion signal of the operation in question.
*/
void FacebookConnection::cancel()
{
    if (m_apiCall == Authenticate) {
        QMetaObject::invokeMethod(this, "authenticateCompleted", Qt::QueuedConnection, Q_ARG(bool, false));
        setBusy(false);
        setTransmitting(false);
        setWebInterfaceActive(false);
        m_apiCall = Undefined;
    }
    else {
        m_facebook->cancelRequests();
    }
}

/*!
    \fn bool FacebookConnection::storeCredentials()

    Stores authentication credentials to persistent storage. Returns true if the
    credentials were successfully stored; otherwise returns false.
*/
bool FacebookConnection::storeCredentials()
{
    if (!authenticated()) {
        qWarning() << "Error. Cannot store credentials while not authenticated.";
        return false;
    }

    return m_facebook->storeCredentials();
}

/*!
    \fn bool FacebookConnection::restoreCredentials()

    Restores authentication credentials from persistent storage and sets
    \c authenticated to the assumed authentication status. Returns true if
    the credentials were successfully restored; otherwise returns false.
*/
bool FacebookConnection::restoreCredentials()
{
    bool succeed = m_facebook->restoreCredentials();

    // Check is Facebook authenticated.
    if (m_facebook->isAuthorized() && !authenticated()) {
        setAuthenticated(true);
        QMetaObject::invokeMethod(this, "authenticateCompleted", Qt::QueuedConnection, Q_ARG(bool, true));
    }

    return succeed;
}

/*!
    \fn bool FacebookConnection::removeCredentials()

    Removes stored authentication credentials from persistent storage but does
    not affect current state of \c authenticated. Returns true if the
    credentials were successfully removed; otherwise returns false.
*/
bool FacebookConnection::removeCredentials()
{
    return m_facebook->removeCredentials();
}

/*!
    \fn FacebookConnection::request(const QVariant &requestId, const QString &graphPath)

    Convenience method for FacebookConnection::request(const QVariant &requestId,
    const QString &graphPath, const QVariantMap &parameters)

    Returns true if the request was successfully sended; otherwise returns false.
*/
bool FacebookConnection::request(const QVariant &requestId,
                                 const QString &graphPath)
{
    return request(requestId, graphPath, QVariantMap());
}

/*!
    \fn FacebookConnection::request(const QVariant &requestId, const QString &graphPath,
    const QVariantMap &parameters)

    Convenience method for FacebookConnection::request(const QVariant &requestId,
    const QString &graphPath, const QVariantMap &parameters)

    Returns true if the request was successfully sent; otherwise returns false.
*/
bool FacebookConnection::request(const QVariant &requestId,
                                 const QString &graphPath,
                                 const QVariantMap &parameters)
{
    return request(requestId, graphPath, HTTPGet, parameters);
}

/*!
    \fn FacebookConnection::request(const QVariant &requestId, const QString &graphPath,
    const HTTPMethod method, const QVariantMap &parameters)

    Sends a custom request to Facebook using \a graphPath as a Facebook Graph API path.
    Requests can be identified with \a requestId for further processing when response
    arrives. Optional \a parameters can be added to the request. HTTP \a method
    can be defined depending on the request type.

    See \l {https://developers.facebook.com/docs/reference/api/} {Facebook Graph API
    documentation} for further details.

    Returns true if the request was successfully sent; otherwise returns false.
*/
bool FacebookConnection::request(const QVariant &requestId,
                                 const QString &graphPath,
                                 const HTTPMethod method,
                                 const QVariantMap &parameters)
{
    m_apiCall = CustomRequest;

    return doRequest(requestId, graphPath, method, parameters);
}

// Internal implementation methods

void FacebookConnection::onUrlChanged(const QUrl &url)
{
    SocialConnection::onUrlChanged(url);

    if (m_apiCall == Authenticate) {
        // TODO: check that active, transimmiting and busy properties are true through
        // the whole authentication - getscreenname process.

        // Check if we get the access token or an error.
        checkAuthenticationUrl(url);
    }
}

void FacebookConnection::onNameChanged(const QString &name)
{
    m_facebook->setScreenName(name);
    SocialConnection::setName(name);
}

void FacebookConnection::onRequestCompleted(const QVariant &requestId, const QByteArray &result)
{
    Q_UNUSED(requestId)

    setBusy(false);
    setTransmitting(false);

    APICall c = m_apiCall;
    m_apiCall = Undefined;

    switch (c) {
    case PostMessage:
        emit postMessageCompleted(true);
        break;
    case RetrieveMessages:
        m_manager->handleRetrievedMessages(result);
        emit retrieveMessagesCompleted(true, m_manager->posts());
        break;
    case RetrieveMessageCount:
        m_manager->handleRetrieveMessageCount(result);
        emit retrieveMessageCountCompleted(true, m_manager->postCount());
        break;
    case GetScreenName:
        // At this point web interface is not needed anymore.
        setWebInterfaceActive(false);
        // After getting the screen name authentication is completed.
        m_facebook->setScreenName(m_manager->handleScreenName(result));
        setAuthenticated(true);
        emit authenticateCompleted(true);
        break;
    case CustomRequest:
        emit requestCompleted(true, requestId, result);
        break;
    default:
        break;
    }
}

void FacebookConnection::onRequestFailed(const QVariant &requestId, const QString &reason)
{
    Q_UNUSED(requestId)

    setBusy(false);
    setTransmitting(false);

    APICall c = m_apiCall;
    m_apiCall = Undefined;

    switch (c) {
    case PostMessage:
        emit postMessageCompleted(false);
        break;
    case RetrieveMessages:
        emit retrieveMessagesCompleted(false, QVariantList());
        break;
    case RetrieveMessageCount:
        emit retrieveMessageCountCompleted(false, 0);
        break;
    case GetScreenName:
        // At this point web interface is not needed anymore.
        setWebInterfaceActive(false);
        // Authentication is completed even the screen name fetching fails.
        setName("");
        setAuthenticated(true);
        emit authenticateCompleted(true);
        break;
    case CustomRequest:
        emit requestCompleted(false, requestId, QByteArray());
        break;
    default:
        break;
    }

    qDebug() << "FacebookConnection::requestFailed - Reason:" << reason;
}

void FacebookConnection::onAuthenticationChanged(const bool authenticated)
{
    setAuthenticated(authenticated);
}

bool FacebookConnection::doRequest(const QVariant &requestId,
                                   const QString &graphPath,
                                   const HTTPMethod method,
                                   const QVariantMap &parameters)
{
    if (busy() && m_apiCall != GetScreenName) {
        qWarning() << "FacebookConnection busy.";
        return false;
    }

    setBusy(true);
    setTransmitting(true);

    return m_facebook->request(requestId, graphPath, method, parameters);
}

void FacebookConnection::setWebInterfaceActive(const bool active)
{
    WebInterface *webInterface = qobject_cast<WebInterface*>(SocialConnection::webInterface());
    if (webInterface) {
        webInterface->setActive(active);
    }
}

bool FacebookConnection::sessionValidated()
{
    if (!m_facebook->isAuthorized() || !authenticated()) {
        qWarning() << "Error. FacebookConnection not authenticated.";
        return false;
    }

    if (busy()) {
        qWarning() << "Facebook Connection busy.";
       // TRAP_IGNORE(CAknDiscreetPopup::ShowGlobalPopupL((_L("System Busy..")), (_L("")),KAknsIIDNone, KNullDesC));

        return false;
    }

    return true;
}

void FacebookConnection::checkAuthenticationUrl(const QUrl &url)
{
    // Ignore all but URLs starting with Facebook successful URL.
    if (!url.toString().startsWith(SuccessUrlStr)) {
        return;
    }

    if (url.toString().contains(AccessTokenStr) &&
        url.toString().contains(ExpiresInStr)) {

        // Little trick for converting fragment to query items.

        QString authUrl = url.toString();
        authUrl.replace("#", "?");
        const QUrl newUrl(authUrl);

        // Authorize Facebook with access token and expiration time.
        m_facebook->authorize(newUrl.queryItemValue(AccessTokenStr),
                              newUrl.queryItemValue(ExpiresInStr).toInt());

        // At this point web interface is not needed anymore.
        setWebInterfaceActive(false);

        // Get an user screen name after getting the access token.
        getScreenName();
    }
    // TODO: Error handling to be improved later if we will to pass error
    // strings to the user in the future.
    else if (url.toString().contains(ErrorStr)) {

        // At this point web interface is not needed anymore.
        setWebInterfaceActive(false);

        m_apiCall = Undefined;
        setBusy(false);
        setTransmitting(false);
        emit authenticateCompleted(false);
    }
}

bool FacebookConnection::getMessagesOnline(const QString &from, const QString &to, const int max)
{
    QVariantMap parameters;
    // TODO: check queries, get other than own messages as well.
    QString query = QString("SELECT post_id, created_time, message, attachment FROM stream "
                            "WHERE source_id = me()");

    if (!from.isEmpty()) {
        query += " AND created_time >= " + from;
    }
    if (!to.isEmpty()) {
        query += " AND created_time <= " + to;
    }

    query += " LIMIT " + QString::number(max);

    // Send FQL query request.
    parameters.insert("q", query);

    return doRequest("", "fql", HTTPGet, parameters);
}

bool FacebookConnection::getMessageCount()
{
    QVariantMap parameters;
    // TODO: check queries, get other than own messages as well.
    QString query = QString("SELECT post_id FROM stream WHERE source_id = me() LIMIT 2000");

    // Send FQL query request.
    parameters.insert("q", query);
    setBusy(true);
    setTransmitting(true);

    return doRequest("", "fql", HTTPGet, parameters);
}

bool FacebookConnection::getScreenName()
{
    m_apiCall = GetScreenName;
    qDebug() << "Getting screen name.";

    return doRequest("", "me", HTTPGet, QVariantMap());
}
