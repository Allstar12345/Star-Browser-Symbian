/**
 * Copyright (c) 2012 Nokia Corporation.
 */

#ifndef FACEBOOKCONNECTION_H
#define FACEBOOKCONNECTION_H

#include <QtCore/QObject>
#include <QtCore/QUrl>
#include <QtCore/QStringList>
#include <QtScript/QScriptValue>
#include "socialconnection.h"

class Facebook;
class FacebookRequest;
class FacebookDataManager;

class FacebookConnection : public SocialConnection
{
    Q_OBJECT
    
    Q_PROPERTY(QString clientId READ clientId WRITE setClientId NOTIFY clientIdChanged)
    Q_PROPERTY(QString accessToken READ accessToken WRITE setAccessToken NOTIFY accessTokenChanged)
    Q_PROPERTY(QStringList permissions READ permissions WRITE setPermissions NOTIFY permissionsChanged)
    Q_ENUMS(HTTPMethod)


    // Internal API call enums
    enum APICall {
        Undefined = -1,
        Authenticate,
        PostMessage,
        RetrieveMessages,
        RetrieveMessageCount,
        GetScreenName,
        CustomRequest
    };

public:

    enum HTTPMethod {
        HTTPGet,
        HTTPPost,
        HTTPDelete
    };

    explicit FacebookConnection(QObject *parent = 0);

public: // Property accessors unique to FacebookConnection.

    QString clientId() const;
    void setClientId(const QString &clientId);
    QString accessToken() const;
    void setAccessToken(const QString &accessToken);
    QStringList permissions() const;
    void setPermissions(const QStringList &permissions);

public: // Reimplementation of SocialConnection base class operations.

    bool authenticate();
    bool deauthenticate();
    bool postMessage(const QVariantMap &message);
    bool retrieveMessageCount();
    bool retrieveMessages(const QString &from, const QString &to, int max);
    void cancel();
    bool storeCredentials();
    bool restoreCredentials();
    bool removeCredentials();

public slots: // Operations unique to FacebookConnection.

    bool request(const QVariant &requestId,
                 const QString &graphPath);

    bool request(const QVariant &requestId,
                 const QString &graphPath,
                 const QVariantMap &parameters);

    bool request(const QVariant &requestId,
                 const QString &graphPath,
                 const HTTPMethod method,
                 const QVariantMap &parameters);
    
signals:

    // Property notifications unique to FacebookConnection.
    void clientIdChanged(const QString &clientId);
    void accessTokenChanged(const QString &accessToken);
    void permissionsChanged(const QStringList &permissions);

    // Completion notification signals unique to FacebookConnection.
    void requestCompleted(bool success, const QVariant &requestId, const QVariant &result);

protected slots:

    void onUrlChanged(const QUrl &url);

private slots:

    void onNameChanged(const QString &name);
    void onRequestCompleted(const QVariant& requestId, const QByteArray &result);
    void onRequestFailed(const QVariant& requestId, const QString &reason);
    void onAuthenticationChanged(const bool authenticated);

private:

    bool doRequest(const QVariant &requestId,
                 const QString &graphPath,
                 const HTTPMethod method,
                 const QVariantMap &parameters);
    void setWebInterfaceActive(const bool active);
    bool sessionValidated();
    void checkAuthenticationUrl(const QUrl &url);
    bool getMessagesOnline(const QString &from,
                           const QString &to,
                           const int max = 25);
    bool getMessageCount();
    bool getScreenName();

    // Member data

    Facebook *m_facebook; // Owned
    FacebookDataManager *m_manager; // Owned
    APICall m_apiCall;
    QStringList m_permissions;
};

#endif // FACEBOOKCONNECTION_H

