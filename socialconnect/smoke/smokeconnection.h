#ifndef SMOKECONNECTION_H
#define SMOKECONNECTION_H

#include <QtCore/QObject>

#include "socialconnection.h"

class SmokeConnection : public SocialConnection
{
    Q_OBJECT
    
    Q_PROPERTY(QString clientId READ clientId WRITE setClientId NOTIFY clientIdChanged)
    Q_PROPERTY(QString accessToken READ accessToken WRITE setAccessToken NOTIFY accessTokenChanged)

public:
    
    explicit SmokeConnection(QObject *parent = 0);
    
    ~SmokeConnection();

public:

    QString clientId() const;
    void setClientId(const QString &clientId);

    QString accessToken() const;
    void setAccessToken(const QString &accessToken);

public:

    bool authenticate();
    bool deauthenticate() { return false; }
    bool postMessage(const QVariantMap &message) { return false; }
    bool retrieveMessageCount() { return false; }
    bool retrieveMessages(const QString &from, const QString &to, int max);
    void cancel() { }

public:

    bool storeCredentials() { return false; }
    bool restoreCredentials() { return false; }
    bool removeCredentials() { return false; }

protected slots:

    void onUrlChanged(const QUrl &url);

signals:

    void clientIdChanged(const QString &clientId);
    void accessTokenChanged(const QString &accessToken);

private:
    
    QString m_clientId;
    QString m_accessToken;
};

#endif // SMOKECONNECTION_H

