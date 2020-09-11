/*Copyright (C) 2020 Allstar Software (Paul Wallace)*/

#ifndef NETWORKACCESSMANAGERINTERACTOR_H
#define NETWORKACCESSMANAGERINTERACTOR_H

#include <QObject>
#include <QDeclarativeEngine>
#include <QtNetwork/QNetworkAccessManager>
#include <QtNetwork/QNetworkCookieJar>
#include <QDebug>
#include <QSslError>
#include <QNetworkReply>

class NetworkAccessManagerInteractor : public QObject
{
    Q_OBJECT
public:

    explicit NetworkAccessManagerInteractor(QDeclarativeEngine *declarativeEngine, QObject *parent = 0);
public slots:
    Q_INVOKABLE void clearCookies();

private:
    QDeclarativeEngine* m_declarativeEngine;

};

#endif // NETWORKACCESSMANAGERINTERACTOR_H
