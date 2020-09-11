/**
 * Copyright (c) 2012 Nokia Corporation.
 */

#ifndef WEBINTERFACE_H
#define WEBINTERFACE_H

#include <QtCore/QObject>
#include <QtCore/QUrl>

class WebInterface : public QObject
{
    Q_OBJECT

    Q_PROPERTY(bool active READ active NOTIFY activeChanged)
    Q_PROPERTY(QUrl url READ url WRITE setUrl NOTIFY urlChanged)

public:

    explicit WebInterface(QObject *parent = 0);
    ~WebInterface();

public:
    
    void setActive(bool active);
    bool active() const;

    void setUrl(const QUrl &url);
    QUrl url() const;

signals:

    void urlChanged(const QUrl &url);
    void activeChanged(bool active);

private:

    Q_DISABLE_COPY(WebInterface)

    bool m_active;
    QUrl m_url;
};

#endif // WEBINTERFACE_H
