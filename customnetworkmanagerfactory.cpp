/*Copyright (C) 2020 Allstar Software (Paul Wallace)*/

#include "customnetworkmanagerfactory.h"
CustomNetworkManagerFactory::CustomNetworkManagerFactory(QObject *parent) :
  QObject(parent)
{
}

class PersistentCookieJar : public QNetworkCookieJar {
public:

    PersistentCookieJar(QObject *parent) : QNetworkCookieJar(parent) { load(); }
    ~PersistentCookieJar() { save(); }

    virtual QList<QNetworkCookie> cookiesForUrl(const QUrl &url) const
    {
        QMutexLocker lock(&mutex);
        return QNetworkCookieJar::cookiesForUrl(url);
    }

    virtual bool setCookiesFromUrl(const QList<QNetworkCookie> &cookieList, const QUrl &url)
    {
        QMutexLocker lock(&mutex);
        return QNetworkCookieJar::setCookiesFromUrl(cookieList, url);
    }
private:

    void save()
    {
        Setting* set = new Setting;
        if(set->getSystemSetting("browsingCookies", "true") == "true"){
        QMutexLocker lock(&mutex);
        QList<QNetworkCookie> list = allCookies();
        QByteArray data;
        foreach (QNetworkCookie cookie, list) {
            if (!cookie.isSessionCookie()) {
                data.append(cookie.toRawForm());
                data.append("\n");
            }
        }
        if(QFile::exists("e:/")){
         QSettings settings("E:/AllStarSoftware/StarBrowser/CookieData/cookies.conf", QSettings::NativeFormat);
          settings.setValue("CookiesSB",data);
        }
        else{
            QSettings settings("C:/AllStarSoftware/StarBrowser/CookieData/cookies.conf", QSettings::NativeFormat);
             settings.setValue("CookiesSB",data);
        }
        }
    }
    void load()
    {

        Setting* set = new Setting;
        if(set->getSystemSetting("browsingCookies", "true") == "true"){
        QMutexLocker lock(&mutex);
        if(QFile::exists("e:/")){
            QSettings settings("E:/AllStarSoftware/StarBrowser/CookieData/cookies.conf", QSettings::NativeFormat);
            QByteArray data = settings.value("CookiesSB").toByteArray();
            setAllCookies(QNetworkCookie::parseCookies(data));
        }
        else{ QSettings settings("C:/AllStarSoftware/StarBrowser/CookieData/cookies.conf", QSettings::NativeFormat);
            QByteArray data = settings.value("CookiesSB").toByteArray();
            setAllCookies(QNetworkCookie::parseCookies(data));
        }
    }
    }
    mutable QMutex mutex;

};


class NetworkAccessManagerFactory : public QDeclarativeNetworkAccessManagerFactory
{


public:

    NetworkAccessManagerFactory() {}
    ~NetworkAccessManagerFactory() {}
    static PersistentCookieJar *cookieJar;
    QMutex mutex;
};
PersistentCookieJar *NetworkAccessManagerFactory::cookieJar = 0;
static void cleanup_cookieJar()
{
    delete NetworkAccessManagerFactory::cookieJar;
    NetworkAccessManagerFactory::cookieJar = 0;
}


QNetworkAccessManager* CustomNetworkManagerFactory::create(QObject *parent)
{
    Setting* set = new Setting;
    QMutexLocker lock(&mutex);
    m_networkManager = new QNetworkAccessManager(this);
  if (!NetworkAccessManagerFactory::cookieJar) {
      qAddPostRoutine(cleanup_cookieJar);
      NetworkAccessManagerFactory::cookieJar = new PersistentCookieJar(0);
  }
  m_networkManager->setCookieJar(NetworkAccessManagerFactory::cookieJar);
  NetworkAccessManagerFactory::cookieJar->setParent(0);
  if(set->getSystemSetting("diskCache", "true") == "true"){
  QNetworkDiskCache *cache = new QNetworkDiskCache;
  if(QFile::exists("e:/")){cache->setCacheDirectory(("e:/AllStarSoftware/StarBrowser/qml-webview-network-cache-starbrowser"));}
  else{cache->setCacheDirectory(("c:/AllStarSoftware/StarBrowser/qml-webview-network-cache-starbrowser"));}
  cache->setMaximumCacheSize(500000000);
  m_networkManager->setCache(cache);}
  qDebug() << "created new network access manager for" << parent;
  connect(m_networkManager,SIGNAL(sslErrors(QNetworkReply*,QList<QSslError>)),this,SLOT(onIgnoreSSLErrors(QNetworkReply*,QList<QSslError>)));
  return m_networkManager;
}

void CustomNetworkManagerFactory::onIgnoreSSLErrors(QNetworkReply *reply, QList<QSslError> error)
{
    qDebug() << error;
  reply->ignoreSslErrors(error);
}
