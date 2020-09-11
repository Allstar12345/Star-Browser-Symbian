#ifndef FACEBOOKREPLY_H
#define FACEBOOKREPLY_H

#include <QObject>
#include <QVariant>
#include <QtScript/QScriptValue>
#include <QNetworkReply>

class FacebookReply : public QObject
{
    Q_OBJECT

public:

    enum OAuthError {
        OAuthNoError = 0,
        OAuthGeneralError,
        OAuthAuthError = 2500
    };

public:
    explicit FacebookReply(const QByteArray &responseData,
                           const bool error,
                           const OAuthError errorCode,
                           const QString &errorString,
                           QObject *parent = 0);

public:
    QByteArray responseData() const;
    bool error() const;
    OAuthError errorCode() const;
    QString errorString() const;

private: // Data
    QByteArray m_responseData;
    bool m_error;
    OAuthError m_errorCode;
    QString m_errorString;
};

#endif // FACEBOOKREPLY_H
