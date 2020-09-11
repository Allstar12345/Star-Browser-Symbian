/**
 * Copyright (c) 2012 Nokia Corporation.
 * All rights reserved.
 *
 * For the applicable distribution terms see the license text file included in
 * the distribution.
 */
 
#ifndef TWITTERREQUEST_H
#define TWITTERREQUEST_H

#include <QObject>
#include <QNetworkRequest>
#include <QMap>
#include <QVariantMap>
#include <QCryptographicHash>

class TwitterRequest : public QObject
{
    Q_OBJECT

public:
    explicit TwitterRequest(QObject *parent = 0);
    
public:
    void setConsumerKey(const QString &consumerKey);
    void setConsumerSecret(const QString &consumerSecret);
    void setAccessToken (const QString &accessToken);
    void setAccessTokenSecret(const QString &accessTokenSecret);

    QNetworkRequest createRequestTokenRequest(const QString &callbackUrl);
    QNetworkRequest createAccessTokenRequest(const QString &verifier);
    QNetworkRequest createRetrieveMessageCountRequest();
    QNetworkRequest createRetrieveMessagesRequest(
            const QString &name, const QString &from, const QString &to, int count);
    QNetworkRequest createPostMessageRequest(const QString &text,
                                             const QUrl &fileUrl,
                                             QByteArray *retContent);

private: // Members
    QNetworkRequest createRequest(const QUrl& requestUrl, const QString httpMethod,
                                  QVariantMap params = QVariantMap());

    QByteArray handleFile(const QString &filePath);
    QString generateAuthHeader(const QMap<QString, QString> &requestHeaders);
    QString createSignatureBaseString(QString url,
                                      QMap<QString, QString> requestTokens,
                                      const QString httpMethod) const;
    QString signRequest(QString signatureBaseString, QString secret) const;
    QByteArray hmac(QByteArray secret, QByteArray data,
                    QCryptographicHash::Algorithm algorithm) const;
    QByteArray currentTime() const;
    QByteArray generateNonce() const;

private: // Data
    QString m_consumerKey;
    QString m_consumerSecret;
    QString m_accessToken;
    QString m_accessTokenSecret;
};

#endif // TWITTERREQUEST_H
