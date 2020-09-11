/*Copyright (C) 2020 Allstar Software (Paul Wallace)*/

#include <QtGui/QApplication>
#include <QDeclarativeProperty>
#include <QWebSettings>
#include <QMainWindow>
#include <QtGui/QSplashScreen>
#include <QtGui/QPixmap>
#include "qmlutils.h"
#include <QSettings>
#include <QDir>
#include <QWebView>
#include <QDebug>
#include <QObject>
#include <QtDeclarative/QDeclarativeContext>
#include <QtDeclarative/QDeclarativeEngine>
#include <QtDeclarative/qdeclarative.h>
#include <QtDeclarative/qdeclarativeextensionplugin.h>
#include <QMutex>
#include <QMutexLocker>
#include <QWidget>
#include "networkaccessmanagerinteractor.h"
#include <QCoreApplication>
#include <QNetworkProxy>
#include "networkmonitor.h"
#include <QObject>
#include "useragent.h"
#include "mediakeysobserver.h"
#include "qdeclarativewebview.h"
#include "qsymbianapplication.h"
#include "settings.h"
#include "downloadbackend.h"
#include "downloadmanager.h"
#include "downloadmanager2.h"
#include "customnetworkmanagerfactory.h"


Setting* set = new Setting;
int main(int argc, char **argv)

{

   if(set->getSystemSetting("proxyEnabled", "false")== "true"){
    QNetworkProxy proxy;
    proxy.setType(QNetworkProxy::HttpProxy);
    proxy.setHostName(set->getSystemSetting("proxyHostName", ""));
    proxy.setPort(set->getnetworkProxyPort());
    proxy.setUser(set->getSystemSetting("proxyUser", ""));
    proxy.setPassword(set->getSystemSetting("proxyPassword", "null"));
    QNetworkProxy::setApplicationProxy(proxy);
    delete set;
   }
    QScopedPointer<QSymbianApplication> app(new QSymbianApplication(argc, argv));
    QSplashScreen *splash = new QSplashScreen(QPixmap(":/splash/splash.png"));
    splash->showMessage(QSplashScreen::tr("Allstar Software \nStar Browser v1.75"), Qt::AlignHCenter | Qt::AlignBottom, Qt::white);
    splash->show();

    QCoreApplication::setAttribute(Qt::AA_S60DisablePartialScreenInputMode, false);
    app->setApplicationName("Mozilla/5.0 (iPhone; CPU iPhone OS 13_0 like Mac OS X) AppleWebKit/602.1.38 (KHTML, like Gecko) Version/10.0 Mobile/14A41DS1497c Safari/602.1");
    app->setApplicationVersion(QString("1.75"));
    app->setOrganizationName("Allstar Software");
    QDeclarativeView view;
    qmlRegisterType<QDeclarativeWebSettings>();
    qmlRegisterType<QDeclarativeWebView>("WebViewCustom", 1, 0, "WebViewCustom");
    qmlRegisterType<MediaKeysObserver>("MediaKeysObserver", 1, 0, "MediaKeysObserver");
    qmlRegisterType<Setting> ("AppSettings", 1, 0, "AppSettings");
    qmlRegisterType<DownloadBackend> ("DownloadBackend", 1, 0, "DownloadBackend");
    qmlRegisterType<DownloadManager> ("DownloadManager", 1, 0, "DownloadManager");
    qmlRegisterType<DownloadManager2> ("DownloadManager", 1, 1, "DownloadManager2");
    CustomNetworkManagerFactory* myNetworkAccessManagerFactory = new CustomNetworkManagerFactory(app->instance());
    view.engine()->setNetworkAccessManagerFactory(myNetworkAccessManagerFactory);
    UserAgent userAgent;
    view.rootContext()->setContextProperty("UserAgent", &userAgent);
    NetworkAccessManagerInteractor* nami = new NetworkAccessManagerInteractor(view.engine(), &view);
       view.rootContext()->setContextProperty("nami", nami);
    NetworkMonitor networkMonitor;
    view.rootContext()->setContextProperty("networkMonitor", &networkMonitor);
    QMLUtils qmlUtils(&view);
    view.rootContext()->setContextProperty("QMLUtils", &qmlUtils);
    view.rootContext()->setContextProperty("QApp", app->instance());
    view.setSource(QUrl("qrc:/qml/StarBrowser/main.qml"));
    view.setProperty("orientationMethod", 1);
    view.setAttribute(Qt::WA_OpaquePaintEvent);
    view.setAttribute(Qt::WA_NoSystemBackground);
    view.viewport()->setAttribute(Qt::WA_NoBackground);
    view.viewport()->setAttribute(Qt::WA_InputMethodEnabled);
    view.setViewportUpdateMode(QGraphicsView::FullViewportUpdate);
    view.window()->show();
    splash->finish(&view);
    splash->deleteLater();
    return app->exec();
}
