/**
 * Copyright (c) 2012 Nokia Corporation.
 */

#ifndef SOCIALCONNECTION_H
#define SOCIALCONNECTION_H

#include <QtCore/QObject>
#include <QtCore/QUrl>
#include <QtCore/QVariantList>
#include <QtCore/QVariantMap>

class WebInterface;

class SocialConnection : public QObject
{
    Q_OBJECT

    Q_PROPERTY(QObject* webInterface READ webInterface WRITE setWebInterface NOTIFY webInterfaceChanged)
    Q_PROPERTY(bool authenticated READ authenticated NOTIFY authenticatedChanged)
    Q_PROPERTY(bool busy READ busy NOTIFY busyChanged)
    Q_PROPERTY(bool transmitting READ transmitting NOTIFY transmittingChanged)
    Q_PROPERTY(QString name READ name NOTIFY nameChanged)

public:

    explicit SocialConnection(QObject *parent = 0);
    ~SocialConnection();

public: // property access

    void setWebInterface(QObject *webInterface);
    QObject* webInterface() const;

    bool authenticated() const;
    bool busy() const;
    bool transmitting() const;
    QString name() const;

public slots: // common network operations

    virtual bool authenticate() = 0;
    virtual bool deauthenticate() = 0;
    virtual bool postMessage(const QVariantMap &message) = 0;
    virtual bool retrieveMessageCount() = 0;
    virtual bool retrieveMessages(const QString &from, const QString &to, int max) = 0;
    virtual void cancel() = 0;

public slots: // common local operations

    virtual bool storeCredentials() = 0;
    virtual bool restoreCredentials() = 0;
    virtual bool removeCredentials() = 0;

protected:

    void setAuthenticated(bool authenticated);
    void setBusy(bool busy);
    void setTransmitting(bool transmitting);
    void setName(const QString &name);

protected slots:

    virtual void onUrlChanged(const QUrl &url);

signals: // property notifications

    void webInterfaceChanged(QObject *webInterface);
    void busyChanged(bool busy);
    void transmittingChanged(bool transmitting);
    void authenticatedChanged(bool authenticated);
    void nameChanged(const QString &name);

signals: // operation notifications

    void authenticateCompleted(bool success);
    void deauthenticateCompleted(bool success);
    void postMessageCompleted(bool success);
    void retrieveMessageCountCompleted(bool success, int count);
    void retrieveMessagesCompleted(bool success, const QVariantList &messages);
    
private:

    Q_DISABLE_COPY(SocialConnection)

    WebInterface *m_webInterface; // not own
    bool m_busy;
    bool m_transmitting;
    bool m_authenticated;
    QString m_name;
};

#endif // SOCIALCONNECTION_H
