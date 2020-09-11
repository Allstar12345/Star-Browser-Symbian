/**
 * Copyright (c) 2012 Nokia Corporation.
 * All rights reserved.
 *
 * For the applicable distribution terms see the license text file included in
 * the distribution.
 */

#ifndef TWITTERCONNECTION_H
#define TWITTERCONNECTION_H

#include <QNetworkAccessManager>
#include <QString>
#include <QVariantMap>

#include "socialconnection.h"

class TwitterRequest;


class TwitterConnection : public SocialConnection
{
    Q_OBJECT

    Q_PROPERTY(QString consumerKey READ consumerKey WRITE setConsumerKey NOTIFY consumerKeyChanged)
    Q_PROPERTY(QString consumerSecret READ consumerSecret WRITE setConsumerSecret NOTIFY consumerSecretChanged)
    Q_PROPERTY(QString accessToken READ accessToken WRITE setAccessToken NOTIFY accessTokenChanged)
    Q_PROPERTY(QString accessTokenSecret READ accessTokenSecret WRITE setAccessTokenSecret NOTIFY accessTokenSecretChanged)
    Q_PROPERTY(QString callbackUrl READ callbackUrl WRITE setCallbackUrl NOTIFY callbackUrlChanged)

public:
    explicit TwitterConnection(QObject *parent = 0);

public:
    QString consumerKey() const;
    void setConsumerKey(const QString &consumerKey);

    QString consumerSecret() const;
    void setConsumerSecret(const QString &consumerSecret);

    QString accessToken() const;
    void setAccessToken (const QString &accessToken);

    QString accessTokenSecret() const;
    void setAccessTokenSecret(const QString &accessTokenSecret);

    QString callbackUrl() const;
    void setCallbackUrl(const QString &callbackUrl);

    // Virtual method implementations from the SocialConnect base class.
    bool authenticate();
    bool deauthenticate();
    bool postMessage(const QVariantMap &message);
    bool retrieveMessageCount();
    bool retrieveMessages(const QString &from, const QString &to, int max);
    void cancel();

    bool storeCredentials();
    bool restoreCredentials();
    bool removeCredentials();

signals:
    void consumerKeyChanged(QString consumerKey);
    void consumerSecretChanged(QString consumerSecret);
    void accessTokenChanged(QString accessToken);
    void accessTokenSecretChanged(QString accessTokenSecret);
    void callbackUrlChanged(QString callbackUrl);

protected slots:
    void onUrlChanged(const QUrl &url);

private slots:
    void onRequestTokenReply();
    void onAccessTokenReply();
    void onPostMessageReply();
    void onRetrieveMessagesReply();
    void onRetrieveMessageCountReply();

private:    // Members

    // Twitter login internal state tracking and setters & getters for it.
    enum State {
        NotLogged = 0,
        AcquiringRequestToken,
        Authorizing,
        AcquiringAccessToken,
        Logged
    };
    State state() const;
    void setState(State state);

    // Continues the authentication process after user has entered his
    // credentials to the Twitter login webview.
    void acquireAccessToken();

    // Methods for emitting signals and setting the State & Busy status correctly
    // after successful / failed authentication attempt.
    void authenticationSucceeded();
    void authenticationFailed(const QString &errorMsg, const int errorCode = 0);

    // Check if the reply had some errors. Currently only reacts to
    // "401 Unauthorized" by setting the state to NotLogged & unauthenticated.
    int checkReplyErrors();

    // Closes the QNetworkReply & nullifies the pointer. Should be called
    // always after each request completed signal handler.
    void deleteReply();

    // Traverses the retrieveMessages reply and creates a messagelist in the
    // specified format. See socialconnection.h for details.
    QVariantList parseRetrievedMessages(const QByteArray &result);

    // A helper method for clearing the XXXToken etc. QString members.
    void clearAllMembers();

private:    // Data

    TwitterRequest *m_twitterRequest;

    QNetworkReply *m_ongoingRequest;
    QNetworkAccessManager m_networkManager;

    QString m_consumerKey;
    QString m_consumerSecret;
    QString m_callbackUrl;

    QString m_requestToken;
    QString m_requestTokenSecret;
    QString m_accessToken;
    QString m_accessTokenSecret;
    QString m_verifier;

    State m_state;
};

#endif // TWITTERCONNECTION_H
