/**
 * Copyright (c) 2012 Nokia Corporation.
 * All rights reserved.
 *
 * For the applicable distribution terms see the license text file included in
 * the distribution.
 */

#include "facebook.h"
#include "facebookrequest.h"
#include "facebookreply.h"
#include <QDebug>
#include <QCoreApplication>
#include <QNetworkAccessManager>
#include <QNetworkReply>
#include <AknCommonDialogs.h>
#include <akndiscreetpopup.h>
// Constants
namespace {
    const char *AccessTokenQueryString = "access_token";
    const char *AccessTokenString = "facebook_access_token";
    const char *ExpirationDateTimeString = "facebook_token_expiration";
    const char *ScreenNameString = "screen_name";
}

/*!
  \class Facebook
  \brief The Facebook class is the internal implementation for communicating
         with Facebook.
*/

/*!
  \internal

  Constructor.
*/
Facebook::Facebook(QObject *parent)
    : QObject(parent),
      m_networkAccess(new QNetworkAccessManager(this))
{
}

/*!
  \internal

  Destructor.
*/
Facebook::~Facebook()
{
    qDeleteAll(m_activeRequests);
}

/*!
  \internal

  Returns application id of the session.
*/
QString Facebook::clientId() const
{
    return m_clientId;
}

/*!
  \internal

  Sets a client application id for the session.
*/
void Facebook::setClientId(const QString &clientId)
{
    if (m_clientId != clientId) {
        m_clientId = clientId;
        emit clientIdChanged(m_clientId);
    }
}

/*!
  \internal

  Returns screen name of the user.
*/
QString Facebook::screenName() const
{
    return m_screenName;
}

/*!
  \internal

  Sets a screen name for the user.
*/
void Facebook::setScreenName(const QString &screenName)
{
    if (m_screenName != screenName) {
        m_screenName = screenName;
        emit screenNameChanged(m_screenName);
    }
}

/*!
  \internal

  Returns access token.
*/
QString Facebook::accessToken() const
{
    return m_accessToken;
}

/*!
  \internal

  Sets access token, and saves it to settings.
*/
void Facebook::setAccessToken(const QString &accessToken)
{
    if (m_accessToken != accessToken) {
        m_accessToken = accessToken;
        emit accessTokenChanged(m_accessToken);
    }
}

/*!
  \internal

  Authorize Facebook with access token and expiration time
  and convert expiration time to real time and date.
*/
void Facebook::authorize(const QString &accessToken, const int expirationTime)
{
    const QDateTime timeNow = QDateTime::currentDateTime();
    m_expirationDateTime = timeNow.addSecs(expirationTime);
    setAccessToken(accessToken);

    qDebug() << "Facebook::authorize - authorized with access token:"
             << accessToken << "and expiration time:" << m_expirationDateTime;
}

/*!
  \internal

  Makes a request with graph path, parameters and HTTP method defined.
*/
bool Facebook::request(const QVariant &requestId,
                       const QString &graphPath,
                       const FacebookConnection::HTTPMethod method,
                       const QVariantMap &parameters)
{
    qDebug() << "Facebook::request - Params: " << parameters;
    QVariantMap tempParams(parameters);

    // Access token is only an optional parameter. Requests can be done also
    // without an access token.
    if (!m_accessToken.isEmpty()) {
        tempParams.insert(AccessTokenQueryString, m_accessToken);
    }

    FacebookRequest *newRequest = new FacebookRequest(requestId,
                                                      m_networkAccess,
                                                      tempParams,
                                                      method,
                                                      graphPath);
    m_activeRequests.append(newRequest);
    QObject::connect(newRequest, 
					 SIGNAL(requestFinished(FacebookRequest*, FacebookReply*)),
					 this, 
                     SLOT(onRequestFinished(FacebookRequest*, FacebookReply*)));

    bool ret = newRequest->executeRequest();

    if (ret) {
        emit requestLoading(requestId);
    }

    return ret;
}

/*!
  \internal

  This slot handles FacebookRequest reply.
*/
void Facebook::onRequestFinished(FacebookRequest *request, FacebookReply *reply)
{
    if (reply->error()) {
        if (reply->errorCode() == FacebookReply::OAuthAuthError) {
            TRAP_IGNORE(CAknDiscreetPopup::ShowGlobalPopupL((_L("Warning,")), (_L("Authentication needed")),KAknsIIDNone, KNullDesC));
            qDebug() << "Error. Authentication needed.";
            emit authorizedChanged(false);
        }

        emit requestFailed(request->requestId(), reply->errorString());

        TPtrC16 sMessage(reinterpret_cast<const TUint16*>(reply->errorString().utf16()));
        TRAP_IGNORE(CAknDiscreetPopup::ShowGlobalPopupL((_L("Error,")), sMessage, KAknsIIDNone, KNullDesC, 0, 0, 180, 0, NULL,  {0x20070763}));

    }
    else {
        emit requestCompleted(request->requestId(), reply->responseData());
    }

    for (int i = 0; i < m_activeRequests.count(); i++) {
        if (m_activeRequests.at(i) == request) {
            m_activeRequests.removeAt(i);
            break;
        }
    }

    request->deleteLater();
    reply->deleteLater();
}

/*!
  \internal

  Checks if access to Facebook is valid and has not been expired.
  Returns false if access isn't valid.
*/
bool Facebook::isAuthorized()
{
    bool ret = true;

    if (m_accessToken.isEmpty() || m_clientId.isEmpty()) {
        ret = false;
    }

    const QDateTime dateNow(QDateTime::currentDateTime());

    if (dateNow > m_expirationDateTime) {
        ret = false;
    }

    // Emit signal if access token has been expired during the session.
    if (!ret) {
        emit authorizedChanged(false);
    }

    return ret;
}

/*!
  \internal

  Removes access token from settings. Returns false if removing access
  token from settings fails.
*/
bool Facebook::removeCredentials()
{
    m_accessToken.clear();
    m_expirationDateTime = QDateTime::currentDateTime();

    QSettings settings;
    settings.remove(AccessTokenString);
    settings.remove(ExpirationDateTimeString);
    settings.remove(ScreenNameString);

    return settings.status() == QSettings::NoError;
}

/*!
  \internal

  Stores access token into settings. Returns false if writing settings fails.
*/
bool Facebook::storeCredentials()
{
    QSettings settings;
    settings.setValue(AccessTokenString, m_accessToken);
    settings.setValue(ExpirationDateTimeString, m_expirationDateTime);
    settings.setValue(ScreenNameString, m_screenName);

    qDebug() << "Store: Access token:" << m_accessToken << "Expiration:" 
			 << m_expirationDateTime;

    return settings.status() == QSettings::NoError;

}

/*!
  \internal

  Restores access token from settings. Returns false if reading settings fails.
*/
bool Facebook::restoreCredentials()
{
    QSettings settings;
    setAccessToken(settings.value(AccessTokenString).toString());
    setScreenName(settings.value(ScreenNameString).toString());
    m_expirationDateTime = settings.value(ExpirationDateTimeString).toDateTime();

    qDebug() << "Restore: Access token for user"
             << m_screenName << ":"
             << m_accessToken
             << "Expiration:" << m_expirationDateTime;

    if (settings.value(AccessTokenString)== "") {
        TRAP_IGNORE(CAknDiscreetPopup::ShowGlobalPopupL((_L("Error,")), (_L("Empty Access Token")), KAknsIIDNone, KNullDesC, 0, 0, 180, 0, NULL,  {0x20070763}));

    }

    return settings.status() == QSettings::NoError;
}

/*!
  \internal

  Cancels all ongoing Facebook requests.
*/
void Facebook::cancelRequests()
{
    foreach (FacebookRequest *request, m_activeRequests) {
        request->cancelRequest();
    }
}

