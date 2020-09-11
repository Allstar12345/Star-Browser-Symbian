/**
 * Copyright (c) 2012 Nokia Corporation.
 * All rights reserved.
 *
 * For the applicable distribution terms see the license text file included in
 * the distribution.
 */

#include "twitterconnection.h"

#include <QDebug>
#include <QMap>
#include <QNetworkReply>
#include <QSettings>
#include <QStringList>
#include <QScriptEngine>
#include <QScriptValue>
#include <QScriptValueIterator>
#include <QUrl>

#include "twitterconstants.h"
#include "twitterrequest.h"
#include "webinterface.h"

/*!
    \class TwitterConnection

    TwitterConnection is an interface to Twitter.
 */

/*!
    \property TwitterConnection::consumerKey

    This \c {mandatory} property specifies Twitter application id that is used
    with the Twitter connection.

    See \l {https://dev.twitter.com/docs/}
    {Twitter documentation} for futher details.
 */

/*!
    \property TwitterConnection::consumerSecret

    This \c {mandatory} property specifies Twitter application secret that is
    used with the Twitter connection.

    See \l {https://dev.twitter.com/docs/}
    {Twitter documentation} for futher details.
 */

/*!
    \property TwitterConnection::callbackUrl

    This \c {mandatory} property specifies Twitter callback URL that is being
    used to redirect the client after successful authentication.

    See \l {https://dev.twitter.com/docs/auth/implementing-sign-twitter/}
    {Twitter authentication documentation} for further details.
 */

/*!
    \property TwitterConnection::accessToken

    This property holds an access token for creating Twitter requests.
    With access token user is granted to create requests to Twitter data
    that is not publically available.

    See \l {https://dev.twitter.com/docs/auth/implementing-sign-twitter}
    {Twitter authentication documentation} for further details.
 */

/*!
    \property TwitterConnection::accessTokenSecret

    This property holds an access token secret for creating Twitter requests.
    With access token secret user can sign the requests (in conjunction with
    the consumer secret) that use the accessToken.

    See \l {https://dev.twitter.com/docs/auth/implementing-sign-twitter}
    {Twitter authentication documentation} for further details.
 */

TwitterConnection::TwitterConnection(QObject *parent) :
    SocialConnection(parent),
    m_twitterRequest(new TwitterRequest(this)),
    m_ongoingRequest(0),
    m_state(NotLogged)
{

}

QString TwitterConnection::consumerKey() const
{
    return m_consumerKey;
}

void TwitterConnection::setConsumerKey(const QString &consumerKey)
{
    if (m_consumerKey != consumerKey) {
        m_consumerKey = consumerKey;
        m_twitterRequest->setConsumerKey(consumerKey);
        emit consumerKeyChanged(m_consumerKey);
    }
}

QString TwitterConnection::consumerSecret() const
{
    return m_consumerSecret;
}

void TwitterConnection::setConsumerSecret(const QString &consumerSecret)
{
    if (m_consumerSecret != consumerSecret) {
        m_consumerSecret = consumerSecret;
        m_twitterRequest->setConsumerSecret(consumerSecret);
        emit consumerSecretChanged(m_consumerSecret);
    }
}

QString TwitterConnection::accessToken() const
{
    return m_accessToken;
}

void TwitterConnection::setAccessToken (const QString &accessToken)
{
    if (m_accessToken != accessToken) {
        m_accessToken = accessToken;
        m_twitterRequest->setAccessToken(accessToken);
        emit accessTokenChanged(m_accessToken);
    }
}

QString TwitterConnection::accessTokenSecret() const
{
    return m_accessTokenSecret;
}

void TwitterConnection::setAccessTokenSecret(const QString &accessTokenSecret)
{
    if (m_accessTokenSecret != accessTokenSecret) {
        m_accessTokenSecret = accessTokenSecret;
        m_twitterRequest->setAccessTokenSecret(accessTokenSecret);
        emit accessTokenSecretChanged(m_accessTokenSecret);
    }
}

QString TwitterConnection::callbackUrl() const
{
    return m_callbackUrl;
}

void TwitterConnection::setCallbackUrl(const QString &callbackUrl)
{
    if (m_callbackUrl != callbackUrl) {
        m_callbackUrl = callbackUrl;
        emit callbackUrlChanged(m_callbackUrl);
    }
}

TwitterConnection::State TwitterConnection::state() const
{
    return m_state;
}

void TwitterConnection::setState(State state)
{
    if (m_state != state) {
        m_state = state;
    }
}

bool TwitterConnection::authenticate()
{
    bool ret = false;

    if (authenticated() || state() != NotLogged || busy()) {
        ret = authenticated();
        qWarning() << "State already logged / busy. Skipping. Authenticated:" << ret;
    }
    else  {
        setState(AcquiringRequestToken);
        setBusy(true);
        setTransmitting(true);

        QNetworkRequest req = m_twitterRequest->createRequestTokenRequest(m_callbackUrl);
        m_ongoingRequest = m_networkManager.post(req, QByteArray());
        connect(m_ongoingRequest, SIGNAL(finished()),
                this, SLOT(onRequestTokenReply()));

        ret = true;
    }

    return ret;
}

bool TwitterConnection::deauthenticate()
{
    clearAllMembers();
    setState(NotLogged);
    setName("");
    setAuthenticated(false);

    QMetaObject::invokeMethod(this, "deauthenticateCompleted",
                              Qt::QueuedConnection, Q_ARG(bool, true));

    return true;
}

void TwitterConnection::onRequestTokenReply()
{
    bool success = false;
    const int requestError = m_ongoingRequest->error();

    if (requestError == QNetworkReply::NoError) {
        QByteArray data = m_ongoingRequest->readAll();
        QList<QByteArray> fields = data.split('&');
        foreach (QByteArray field, fields) {
            QString key;
            QString value;
            QList<QByteArray> keyValuePair = field.split('=');
            if (keyValuePair.size() >= 2) {
                key = keyValuePair.at(0);
                value = keyValuePair.at(1);
            }

            if (key == OAUTH_TOKEN) {
                m_requestToken = value;
                m_twitterRequest->setAccessToken(value);
            }
            else if (key == OAUTH_TOKEN_SECRET) {
                m_requestTokenSecret = value;
                m_twitterRequest->setAccessTokenSecret(value);
            }
            else if (key == OAUTH_CALLBACK_CONFIRMED) {
                if (value == "true") {
                    success = true;
                }
            }
        }
    }
    deleteReply();

    if (!m_requestToken.isEmpty() && !m_requestTokenSecret.isEmpty() && success) {
        QUrl url(AUTHENTICATE_URL);
        url.addEncodedQueryItem(OAUTH_TOKEN, m_requestToken.toUtf8());
        setState(Authorizing);
        setTransmitting(false);     // Not anymore transmitting, but still "Busy"!
        setAuthenticated(false);    // TODO: Is this in the right place??
        WebInterface *webInterface = qobject_cast<WebInterface*>(SocialConnection::webInterface());
        webInterface->setActive(true);
        webInterface->setUrl(url);
    }
    else {
        authenticationFailed("Authorization not possible, network reply error:", requestError);
    }
}

void TwitterConnection::acquireAccessToken()
{
    setState(AcquiringAccessToken);
    setBusy(true);
    setTransmitting(true);

    QNetworkRequest req = m_twitterRequest->createAccessTokenRequest(m_verifier);
    m_ongoingRequest = m_networkManager.post(req, QByteArray());
    connect(m_ongoingRequest, SIGNAL(finished()),
            this, SLOT(onAccessTokenReply()));
}

void TwitterConnection::onAccessTokenReply()
{
    m_accessToken.clear();
    m_accessTokenSecret.clear();
    const int requestError = m_ongoingRequest->error();
    QString errorStr = m_ongoingRequest->errorString();

    if (requestError == QNetworkReply::NoError) {
        QByteArray data = m_ongoingRequest->readAll();
        QList<QByteArray> fields = data.split('&');

        foreach (QByteArray field, fields) {
            QString key;
            QString value;
            QList<QByteArray> keyValuePair = field.split('=');

            if (keyValuePair.size() >= 2) {
                key = keyValuePair.at(0);
                value = keyValuePair.at(1);
            }

            if (key == OAUTH_TOKEN) {
                setAccessToken(value);
            }
            else if (key == OAUTH_TOKEN_SECRET) {
                setAccessTokenSecret(value);
            }
            else if (key == TWITTER_USER_ID) {
                qDebug() << "Received user_id: " << value;
            }
            else if (key == TWITTER_SCREEN_NAME) {
                setName(value);
            }
        }
    }
    deleteReply();

    if (m_accessToken.isEmpty() || m_accessTokenSecret.isEmpty()) {
        authenticationFailed("No access token received, nwReplyError:" + errorStr,
                             requestError);
    }
    else {
        authenticationSucceeded();
    }
}

void TwitterConnection::onUrlChanged(const QUrl &url)
{
    SocialConnection::onUrlChanged(url);

    qDebug() << url;

    if (busy() && !url.isEmpty() && url.toString().contains("theweekendcoder.blogspot")) {
        m_verifier = url.queryItemValue(OAUTH_VERIFIER);
        qDebug() << m_verifier;
        WebInterface *webInterface = qobject_cast<WebInterface*>(SocialConnection::webInterface());
        webInterface->setActive(false);

        if (!m_verifier.isEmpty() && m_state == Authorizing) {
            qDebug() << "acquire function called with " << m_verifier;
            acquireAccessToken();
        }
        else {
            // No access token gotten, but still redirected => user wanted to
            // return to the application without signing in.
            authenticationFailed("Incorrect redirection. Authentication cancelled.");
        }
    }
}

/*!
    \fn bool TwitterConnection::postMessage(const QVariantMap &message)

    Posts \a message to Twitter. Possible message posting types are a simple
    tweet and uploading a picture.

    Returns true if the operation was successfully started and there will be a
    postMessageCompleted() signal emitted later; otherwise returns false.

    Keys and values for creating a simple tweet:
    \list
        \li "text" (mandatory) : "Your tweet message."
        \li "url" (n/a)
        \li "description" (n/a)
    \endlist

    Keys and values for uploading a picture:
    \list
        \li "text" (mandatory) : "Your tweet message."
        \li "url" (mandatory) : "file:///path/to/your/picture.png"
        \li "description" (n/a)
    \endlist
 */
bool TwitterConnection::postMessage(const QVariantMap &message)
{
    bool ret = false;

    if (!authenticated() || state() != Logged || busy() ) {
        qWarning() << "Cannot send message while not authenticated/logged";
    }
    else {
        QString messageStatus = message.value("text").toString();
        QUrl fileUrl = message.value("url").toString();

        if (!messageStatus.isEmpty()) {
            ret = true;
            setBusy(true);
            setTransmitting(true);

            QByteArray content;
            QNetworkRequest req = m_twitterRequest->createPostMessageRequest
                    (messageStatus, fileUrl, &content);
            m_ongoingRequest = m_networkManager.post(req, content);
            connect(m_ongoingRequest, SIGNAL(finished()),
                    this, SLOT(onPostMessageReply()));
        }
        else {
            qWarning() << "Status message missing. It is ALWAYS required!";
        }
    }

    return ret;
}

void TwitterConnection::onPostMessageReply()
{
    const int requestError = checkReplyErrors();
    deleteReply();
    emit postMessageCompleted(requestError == QNetworkReply::NoError);
}

bool TwitterConnection::retrieveMessageCount()
{
    bool ret = false;

    if (!authenticated() || state() != Logged || busy() ) {
        qWarning() << "Cannot retrieve message count not authenticated/logged";
    }
    else {
        ret = true;
        setBusy(true);
        setTransmitting(true);

        QNetworkRequest req = m_twitterRequest->createRetrieveMessageCountRequest();
        m_ongoingRequest = m_networkManager.get(req);
        connect(m_ongoingRequest, SIGNAL(finished()),
                this, SLOT(onRetrieveMessageCountReply()));
    }

    return ret;
}

void TwitterConnection::onRetrieveMessageCountReply()
{
    const int requestError = checkReplyErrors();

    QByteArray result = m_ongoingRequest->readAll();
    QScriptEngine engine;
    QScriptValue scValue = engine.evaluate("(" + QString(result) + ")");

    deleteReply();
    emit retrieveMessageCountCompleted(requestError == QNetworkReply::NoError,
                scValue.property(MESSAGE_COUNT).toInteger());
}

bool TwitterConnection::retrieveMessages(const QString &from, const QString &to, int max)
{
    bool ret = false;

    if (!authenticated() || state() != Logged || busy() ) {
        qWarning() << "Cannot retrieve messages while not authenticated/logged";
    }
    else {
        ret = true;
        setBusy(true);
        setTransmitting(true);

        QNetworkRequest req = m_twitterRequest->createRetrieveMessagesRequest(
                    name(), from, to, max);
        m_ongoingRequest = m_networkManager.get(req);
        connect(m_ongoingRequest, SIGNAL(finished()),
                this, SLOT(onRetrieveMessagesReply()));
    }

    return ret;
}

void TwitterConnection::onRetrieveMessagesReply()
{
    const int requestError = checkReplyErrors();
    QByteArray result = m_ongoingRequest->readAll();
    deleteReply();

    emit retrieveMessagesCompleted(requestError == QNetworkReply::NoError,
                                   parseRetrievedMessages(result));
}

QVariantList TwitterConnection::parseRetrievedMessages(const QByteArray &result)
{
    QVariantList list;
    QScriptEngine engine;
    QScriptValue scValue = engine.evaluate("(" + QString(result) + ")");
    QScriptValueIterator it(scValue);

    while (it.hasNext()) {
        it.next();

        QString messageId = it.value().property(MESSAGE_ID).toString();
        QString messageText = it.value().property(MESSAGE_TEXT).toString();

        if (!messageId.isEmpty() && !messageText.isEmpty()) {
            QVariantMap message;
            message.insert(MESSAGE_ID, messageId);
            message.insert(MESSAGE_TEXT, messageText);
            list.append(message);
        }
    }

    return list;
}

void TwitterConnection::cancel()
{
    if (m_ongoingRequest != 0 && m_ongoingRequest->isRunning()) {
        qWarning() << "Request ongoing, aborting!";
        m_ongoingRequest->abort();
    }
    // Not busy or transmitting anymore
    setTransmitting(false);
    setBusy(false);

    // If we were in the middle of authentication process, reset the state
    if (state() != Logged && state() != NotLogged) {
        clearAllMembers();
        setState(NotLogged);
        WebInterface *webInterface = qobject_cast<WebInterface*>(SocialConnection::webInterface());
        webInterface->setActive(false);
        emit authenticateCompleted(false);
    }
}

bool TwitterConnection::storeCredentials()
{
    QSettings settings("Nokia", consumerKey());
    settings.setValue(SETTINGS_ACCESS_TOKEN, accessToken());
    settings.setValue(SETTINGS_ACCESS_TOKEN_SECRET, accessTokenSecret());
    settings.setValue(SETTINGS_SCREEN_NAME, name());

    return settings.status() == QSettings::NoError;
}

bool TwitterConnection::restoreCredentials()
{
    QSettings settings("Nokia", consumerKey());
    setAccessToken(settings.value(SETTINGS_ACCESS_TOKEN).toString());
    setAccessTokenSecret(settings.value(SETTINGS_ACCESS_TOKEN_SECRET).toString());
    setName(settings.value(SETTINGS_SCREEN_NAME).toString());

    // If the access token & secret exist, the app should be authenticated
    if (!m_accessToken.isEmpty() && !m_accessTokenSecret.isEmpty()) {
        authenticationSucceeded();
    }

    return settings.status() == QSettings::NoError;
}

bool TwitterConnection::removeCredentials()
{
    QSettings settings("Nokia", consumerKey());
    settings.remove(SETTINGS_ACCESS_TOKEN);
    settings.remove(SETTINGS_ACCESS_TOKEN_SECRET);
    settings.remove(SETTINGS_SCREEN_NAME);

    return settings.status() == QSettings::NoError;
}

void TwitterConnection::authenticationFailed(const QString &errorMsg, const int errorCode)
{
    qWarning() << errorMsg << (errorCode ? QString::number(errorCode) : QString(""));

    clearAllMembers();
    setTransmitting(false);
    setBusy(false);
    setState(NotLogged);
    emit authenticateCompleted(false);
}

void TwitterConnection::authenticationSucceeded()
{
    m_verifier.clear();
    m_requestToken.clear();
    m_requestTokenSecret.clear();
    setTransmitting(false);
    setBusy(false);
    setState(Logged);
    setAuthenticated(true);
    emit authenticateCompleted(true);
}

int TwitterConnection::checkReplyErrors()
{
    setTransmitting(false);
    setBusy(false);
    const int requestError = m_ongoingRequest->error();
    qDebug()<< "Error no:: " << requestError;

    if (requestError == QNetworkReply::AuthenticationRequiredError) {
        setState(NotLogged);
        setAuthenticated(false);
    }

    return requestError;
}

void TwitterConnection::clearAllMembers()
{
    m_verifier.clear();
    m_accessToken.clear();
    m_accessTokenSecret.clear();
    m_requestToken.clear();
    m_requestTokenSecret.clear();
    m_twitterRequest->setAccessToken("");
    m_twitterRequest->setAccessTokenSecret("");
}

void TwitterConnection::deleteReply()
{
    m_ongoingRequest->close();
    m_ongoingRequest->deleteLater();
    m_ongoingRequest = 0;
}
