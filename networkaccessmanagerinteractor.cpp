/*Copyright (C) 2020 Allstar Software (Paul Wallace)*/

#include "networkaccessmanagerinteractor.h"

NetworkAccessManagerInteractor::NetworkAccessManagerInteractor(QDeclarativeEngine *declarativeEngine, QObject *parent) :
    QObject(parent),
    m_declarativeEngine(declarativeEngine)
{
}

void NetworkAccessManagerInteractor::clearCookies()
{
    QNetworkAccessManager * nam = m_declarativeEngine->networkAccessManager();
    if (nam) {
        QNetworkCookieJar * emptyCookieJar = new QNetworkCookieJar();
        nam->setCookieJar(emptyCookieJar);
        qDebug() << "Replaced cookie jar";
    } else {
        qDebug() << "Unable to retrieve Network Access Manager from declarative engine";
    }
}

