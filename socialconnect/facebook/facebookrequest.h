/**
 * Copyright (c) 2012 Nokia Corporation.
 */

#ifndef FACEBOOKREQUEST_H
#define FACEBOOKREQUEST_H

#include <QVariantMap>
#include <QPointer>
#include "facebookconnection.h"

class QNetworkReply;
class QNetworkRequest;
class QNetworkAccessManager;
class FacebookReply;

class FacebookRequest : public QObject
{
    Q_OBJECT

public:
    explicit FacebookRequest(const QVariant &requestId,
                             QNetworkAccessManager *networkAccess,
                             const QVariantMap &parameters,
                             const FacebookConnection::HTTPMethod method,
                             const QString &graphPath,
                             QObject *parent = 0);
    virtual ~FacebookRequest();
    
public:
    bool executeRequest();
    void cancelRequest();
    QVariant requestId() const;

signals:

    /*!
       \internal
     */
    void requestFinished(FacebookRequest *request, FacebookReply *reply);
    
public slots:
    void onFinished(QNetworkReply *reply);

private: // Member data

    // Reference to network access manager. Owned by FacebookConnection.
    QNetworkAccessManager *m_networkAccess;
    QPointer<QNetworkReply> m_ongoingRequest; // Not owned

    QVariant m_requestId;
    QVariantMap m_parameters;
    FacebookConnection::HTTPMethod m_method;
    QString m_graphPath;
};

#endif // FACEBOOKREQUEST_H
