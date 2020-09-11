/*Copyright (C) 2020 Allstar Software (Paul Wallace)*/

 #include <QObject>
 #include <QNetworkAccessManager>
 #include <QNetworkReply>
 #include <QSslError>
 #include <QDeclarativeNetworkAccessManagerFactory>
#include <QDebug>
#include <QtNetwork/QNetworkCookieJar>
#include <QtNetwork/QNetworkDiskCache>
#include <QMutexLocker>
#include "settings.h"
#include <QSettings>
#include <QFile>
 class CustomNetworkManagerFactory : public QObject, public QDeclarativeNetworkAccessManagerFactory
 {
   Q_OBJECT
 public:
   explicit CustomNetworkManagerFactory(QObject *parent = 0);
   virtual QNetworkAccessManager *create(QObject *parent);
     QMutex mutex;
 public slots:
   void onIgnoreSSLErrors(QNetworkReply* reply,QList<QSslError> error);
 private:
   QNetworkAccessManager* m_networkManager;
 };
