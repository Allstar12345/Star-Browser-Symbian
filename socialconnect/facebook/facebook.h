/**
 * Copyright (c) 2012 Nokia Corporation.
 * All rights reserved.
 *
 * For the applicable distribution terms see the license text file included in
 * the distribution.
 */

#ifndef FACEBOOK_H
#define FACEBOOK_H

#include <QVariantMap>
#include <QDateTime>
#include <QSettings>
#include <QStringList>
#include "facebookconnection.h"

// Forward declarations
class FacebookRequest;
class FacebookReply;
class QNetworkReply;
class QNetworkAccessManager;

class Facebook : public QObject
{
    Q_OBJECT

public:

    explicit Facebook(QObject *parent = 0);
    virtual ~Facebook();

public:

    // Property setters and getters

    QString clientId() const;
    void setClientId(const QString &clientId);

    QString screenName() const;
    void setScreenName(const QString &screenName);

    QString accessToken() const;
    void setAccessToken(const QString &accessToken);

    bool isAuthorized();

public:

    void authorize(const QString &accessToken, const int expirationTime);

    bool request(const QVariant &requestId,
                 const QString &graphPath,
                 const FacebookConnection::HTTPMethod method,
                 const QVariantMap &parameters);

    bool removeCredentials();

    bool storeCredentials();

    bool restoreCredentials();

    void cancelRequests();

private slots:

    void onRequestFinished(FacebookRequest *request, FacebookReply *reply);

signals:

    /*!
       \internal
     */
    void clientIdChanged(const QString &clientId);

    /*!
       \internal
     */
    void screenNameChanged(const QString &screenName);

    /*!
       \internal
     */
    void accessTokenChanged(const QString &accessToken);

    /*!
       \internal
     */
    void authorizedChanged(const bool authorized);

    /*!
       \internal
     */
    void requestCompleted(const QVariant &requestId, const QByteArray &result);

    /*!
       \internal
     */
    void requestFailed(const QVariant &requestId, const QString &reason);

    /*!
       \internal
     */
    void requestLoading(const QVariant &requestId);


private: // Data
    QString m_clientId;
    QString m_screenName;
    QString m_accessToken;
    QNetworkAccessManager *m_networkAccess; // Not owned.
    QDateTime m_expirationDateTime;
    QList<FacebookRequest *> m_activeRequests;
};

#endif // FACEBOOK_H

