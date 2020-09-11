#include <QtCore/QDebug>

#include "../webinterface.h"
#include "smokeconnection.h"

#define URL_AUTHENTICATION_FORMAT \
    "https://m.facebook.com/dialog/oauth?" \
    "client_id=%1" \
    "&redirect_uri=https://www.facebook.com/connect/login_success.html" \
    "&response_type=token"

SmokeConnection::SmokeConnection(QObject *parent) :
    SocialConnection(parent)
{
}
    
SmokeConnection::~SmokeConnection()
{
}

// property accessors

QString SmokeConnection::clientId() const
{
    return m_clientId;
}
    
void SmokeConnection::setClientId(const QString &clientId)
{
    m_clientId = clientId;
    
    emit clientIdChanged(clientId);
}

QString SmokeConnection::accessToken() const
{
    return m_accessToken;
}
    
void SmokeConnection::setAccessToken(const QString &accessToken)
{
    m_accessToken = accessToken;
    
    emit accessTokenChanged(accessToken);
}

// common network operations

bool SmokeConnection::authenticate()
{
    bool ret = false;
    
    if (!busy()) {
        WebInterface *webInterface = qobject_cast<WebInterface*>(SocialConnection::webInterface());
        
        if (webInterface && !webInterface->active()) {
            setBusy(true);
            setAccessToken("");
            setAuthenticated(false);
            
            webInterface->setActive(true);
            webInterface->setUrl(QString(URL_AUTHENTICATION_FORMAT).arg(clientId()));
            
            ret = true;
        }
    }
    
    return ret;
}

bool SmokeConnection::retrieveMessages(const QString &before, const QString &after, int max) {
    QVariantMap object;
    object.insert("text", "Hello, world!");

    QVariantList array;

    for (int i = 0; i < max; i++) {
        array.append(object);
    }

    QMetaObject::invokeMethod(this, "retrieveMessagesCompleted", Qt::QueuedConnection,
                              Q_ARG(bool, true), Q_ARG(QVariantList, array));

    return true;
}

// common local operations

// slots

void SmokeConnection::onUrlChanged(const QUrl &url)
{
    SocialConnection::onUrlChanged(url);
            
    // very naive url handling & token extraction!
    
    if (busy() && url.hasFragment()) {
        setBusy(false);

        WebInterface *webInterface = qobject_cast<WebInterface*>(SocialConnection::webInterface());
        Q_ASSERT(webInterface);
        webInterface->setActive(false);

        QString fragment = url.fragment();
        
        if (fragment.contains("access_token=")) {
            fragment.replace("access_token=", "");
            fragment.truncate(fragment.indexOf("&"));
            
            setAccessToken(fragment);
            setAuthenticated(true);
            
            emit authenticateCompleted(true);
        } else {
            emit authenticateCompleted(false);
        }
    }
}

