/*
    Copyright (C) 2009 Nokia Corporation and/or its subsidiary(-ies)
	Copyright (C) 2020 Allstar Software (Paul Wallace)


    This library is free software; you can redistribute it and/or
    modify it under the terms of the GNU Library General Public
    License as published by the Free Software Foundation; either
    version 2 of the License, or (at your option) any later version.

    This library is distributed in the hope that it will be useful,
    but WITHOUT ANY WARRANTY; without even the implied warranty of
    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
    Library General Public License for more details.

    You should have received a copy of the GNU Library General Public License
    along with this library; see the file COPYING.LIB.  If not, write to
    the Free Software Foundation, Inc., 51 Franklin Street, Fifth Floor,
    Boston, MA 02110-1301, USA.
*/

#include "qdeclarativewebview.h"
#include <QtCore/QDebug>
#include <QtCore/QEvent>
#include <QtCore/QFile>
#include <QtDeclarative/QDeclarativeContext>
#include <QtDeclarative/QDeclarativeEngine>
#include <QtDeclarative/qdeclarative.h>
#include <QtGui/QApplication>
#include <QtGui/QGraphicsSceneMouseEvent>
#include <QtGui/QKeyEvent>
#include <QtGui/QMouseEvent>
#include <QtGui/QPen>
#include <QtWebKit/QWebElement>
#include <QtWebKit/QWebFrame>
#include <QtWebKit/QWebPage>
#include <QtWebKit/QWebSettings>
#include <CAknFileSelectionDialog.h>
#include <AknCommonDialogs.h>
#include <QmessageBox>
#include <akndiscreetpopup.h>
#include <AknGlobalNote.h>
#include <AknCommonDialogs.h>
#include <AknCommonDialogsDynMem.h>
#include <avkon.mbg>
#include <aknnotewrappers.h>
#include <aknglobalnote.h>
#include <QFileDialog>
#include <QtGui/QDesktopServices>
#include <QtNetwork/QNetworkRequest>
#include <QtNetwork/QNetworkAccessManager>
#include <QtDeclarative/QDeclarativeNetworkAccessManagerFactory>
#include <QtDeclarative/QDeclarativeEngine>
#include <QInputDialog>
#include <QDateTime>
#include <QSettings>
#include <aknmessagequerydialog.h>
#include <QtNetwork/QNetworkAccessManager>
#include <QtNetwork/QNetworkCookieJar>
#include <QtNetwork/QNetworkDiskCache>
#include <QNetworkReply>
#include <qmobilityglobal.h>
#include <QValueSpaceSubscriber.h>
#include <QTimer>
#include "settings.h"
#include <QMenu>
#include <aknglobalmsgquery.h>
#include <e32svr.h>
#include <eikmenup.h>
#include <coemain.h>
#include <QWebInspector>
#include "qmlutils.h"
bool loadingStopped;
QUrl incomingUrl;
static const TUid mngr = { 0xE0324327 };

QT_BEGIN_NAMESPACE

class QDeclarativeWebViewPrivate {
public:
    QDeclarativeWebViewPrivate(QDeclarativeWebView* qq)
      : q(qq)
      , preferredwidth(0)
      , preferredheight(0)
      , progress(1.0)
      , status(QDeclarativeWebView::Null)
      , pending(PendingNone)
      , newWindowComponent(0)
      , newWindowParent(0)
      , rendering(true)
    {
    }

    QDeclarativeWebView* q;


    QUrl url; // page url might be different if it has not loaded yet
    GraphicsWebView* view ;
    int preferredwidth, preferredheight;
    qreal progress;
    QDeclarativeWebView::Status status;
    QString statusText;
    enum { PendingNone, PendingUrl, PendingHtml, PendingContent } pending;
    QUrl pendingUrl;
    QString pendingString;
    QByteArray pendingData;
    mutable QDeclarativeWebSettings settings;
    QDeclarativeComponent* newWindowComponent;
    QDeclarativeItem* newWindowParent;


    static void windowObjectsAppend(QDeclarativeListProperty<QObject>* prop, QObject* o)
    {
        static_cast<QDeclarativeWebViewPrivate*>(prop->data)->windowObjects.append(o);
        static_cast<QDeclarativeWebViewPrivate*>(prop->data)->updateWindowObjects();
    }

    void updateWindowObjects();
    QObjectList windowObjects;

    bool rendering;

};

GraphicsWebView::GraphicsWebView(QDeclarativeWebView* parent)
    : QGraphicsWebView(parent)
    , parent(parent)
    , pressTime(500)
{

}

void GraphicsWebView::mousePressEvent(QGraphicsSceneMouseEvent* event)
{
    setFocus();
    pressPoint = event->pos();
    if (pressTime) {
        pressTimer.start(pressTime, this);
        parent->setKeepMouseGrab(false);
    } else {
        grabMouse();
        parent->setKeepMouseGrab(true);
    }
    QGraphicsWebView::mousePressEvent(event);
}

void GraphicsWebView::mouseReleaseEvent(QGraphicsSceneMouseEvent* event)
{
    QGraphicsWebView::mouseReleaseEvent(event);
    pressTimer.stop();
    parent->setKeepMouseGrab(false);
    ungrabMouse();
}

void GraphicsWebView::mouseDoubleClickEvent(QGraphicsSceneMouseEvent* event)
{
    QMouseEvent* me = new QMouseEvent(QEvent::MouseButtonDblClick, (event->pos() / parent->contentsScale()).toPoint(), event->button(), event->buttons(), 0);
    emit doubleClick(event->pos().x(), event->pos().y());
    delete me;
}

void GraphicsWebView::timerEvent(QTimerEvent* event)
{
    if (event->timerId() == pressTimer.timerId()) {
        pressTimer.stop();
        grabMouse();
        parent->setKeepMouseGrab(true);
    }
}



void GraphicsWebView::mouseMoveEvent(QGraphicsSceneMouseEvent* event)
{
    if (pressTimer.isActive()) {
        if ((event->pos() - pressPoint).manhattanLength() > QApplication::startDragDistance())
            pressTimer.stop();
    }
    if (parent->keepMouseGrab())
        QGraphicsWebView::mouseMoveEvent(event);
}


QDeclarativeWebView::QDeclarativeWebView(QDeclarativeItem *parent) : QDeclarativeItem(parent)
{
    init();
   // qDebug() << "Loading.......";
QValueSpaceSubscriber* suc;
suc= new QValueSpaceSubscriber ("/Allstar/external/", this);
QObject::connect(suc, SIGNAL( contentsChanged()),this, SLOT(datachanged()) );
// qDebug() << suc->value("/url").toString();
 incomingUrl= suc->value("/url").toString();
}


void QDeclarativeWebView::datachanged() {
    QValueSpaceSubscriber *suc = new QValueSpaceSubscriber("/Allstar/external/", this);
 Setting * set = new Setting();
 if(set->getSystemSetting("externalaccessbool", "true")  == "true") {
     if(set->getSetting()== false){incomingUrl=suc->value("/url").toString();
         setUrl(incomingUrl);}
     else{
         QString title= "External URL Request";
         QString urle= "An External App is wants to open a link, Allow?\n" + suc->value("/url").toString();
         CAknGlobalMsgQuery* pDlg = CAknGlobalMsgQuery::NewL();
          CleanupStack::PushL(pDlg);
           TRequestStatus iStatus;
         pDlg->ShowMsgQueryL(iStatus, convertToSymbianString(urle), R_AVKON_SOFTKEYS_YES_NO, convertToSymbianString(title), KNullDesC,0,-1,CAknQueryDialog::ENoTone);

         User::WaitForRequest(iStatus);

         CleanupStack::PopAndDestroy(pDlg);
         if (iStatus.Int() == EAknSoftkeyYes)
          {setUrl(incomingUrl);}
          else if(iStatus.Int() == EAknSoftkeyNo)
          { TRAP_IGNORE(CAknDiscreetPopup::ShowGlobalPopupL((_L("Star Browser")), (_L("Request Rejected")),KAknsIIDNone, KNullDesC));}
         }
         delete suc;
         delete set;

}
}

QDeclarativeWebView::~QDeclarativeWebView()
{
    delete d;
}

void QDeclarativeWebView::init()
{

    d = new QDeclarativeWebViewPrivate(this);
    QWebSettings::enablePersistentStorage();
    setAcceptedMouseButtons(Qt::LeftButton);
    setFlag(QGraphicsItem::ItemHasNoContents, true);
    setClip(true);
    d->view = new GraphicsWebView(this);
    d->view->setResizesToContents(true);
    QWebPage* wp = new QDeclarativeWebPage(this);
    setPage(wp);
    connect(d->view, SIGNAL(geometryChanged()), this, SLOT(updateDeclarativeWebViewSize()));
    connect(d->view, SIGNAL(doubleClick(int, int)), this, SIGNAL(doubleClick(int, int)));
    connect(d->view, SIGNAL(scaleChanged()), this, SIGNAL(contentsScaleChanged()));

}

void QDeclarativeWebView::componentComplete()
{
    QDeclarativeItem::componentComplete();
    page()->setNetworkAccessManager(qmlEngine(this)->networkAccessManager());

    switch (d->pending) {
    case QDeclarativeWebViewPrivate::PendingUrl:
        setUrl(d->pendingUrl);
        break;
    case QDeclarativeWebViewPrivate::PendingHtml:
        setHtml(d->pendingString, d->pendingUrl);
        break;
    case QDeclarativeWebViewPrivate::PendingContent:
        setContent(d->pendingData, d->pendingString, d->pendingUrl);
        break;
    default:
        break;
    }
    d->pending = QDeclarativeWebViewPrivate::PendingNone;
    d->updateWindowObjects();
}

QDeclarativeWebView::Status QDeclarativeWebView::status() const
{
    return d->status;
}

qreal QDeclarativeWebView::progress() const
{
    return d->progress;
}

void QDeclarativeWebView::doLoadStarted()
{
    if (!d->url.isEmpty()) {
        d->status = Loading;
        emit statusChanged(d->status);
    }
    if(Setting::getSystemSetting("safeBrowsing", "")==""){
    if(QMLUtils::isWebsiteSafe(d->url.toString())){}
    else{emit pageBlocked();}
    }
    emit loadStarted();

}

void QDeclarativeWebView::doLoadProgress(int p)
{
    if (d->progress == p / 100.0)
        return;
    d->progress = p / 100.0;
    emit progressChanged();
   // qDebug() << d->progress;
}

void QDeclarativeWebView::pageUrlChanged()
{

    updateContentsSize();

    QString urler;
   urler=d->url.toString();
   if(urler.contains( (".jpg")) || urler.contains(".png") || urler.contains((".gif"))){QUrl data;
       data=d->url;
        emit imageRequested(data);}


   if(urler.endsWith(".jpg")|| urler.endsWith(".png") || urler.endsWith(".gif")){QUrl data;
     data=d->url;
      emit imageRequested(data);}

    if ((d->url.isEmpty() && page()->mainFrame()->url() != QUrl(QLatin1String("about:blank")))
        || (d->url != page()->mainFrame()->url() && !page()->mainFrame()->url().isEmpty()))
    {
        d->url = page()->mainFrame()->url();
        if (d->url == QUrl(QLatin1String("about:blank")))
            d->url = QUrl();
        emit urlChanged();

    }

}

void QDeclarativeWebView::doLoadFinished(bool ok)
{

   qDebug() <<page()->totalBytes();
   quint64 bytes = page()->totalBytes();
   emit dataUsed(bytes);
   qDebug() << bytes;

    if (ok) {
        d->status = d->url.isEmpty() ? Null : Ready;
        d->url.isEmpty() ? qDebug("Null URL"): emit loadFinished();



    } else {
        if(d->progress == 1){qDebug("No Connection or invaild url");loadingStopped=false;}
        if(loadingStopped=true){ emit loadFailed();qDebug("Loading Stopped by user");}

    emit statusChanged(d->status);

}
}
QUrl QDeclarativeWebView::url() const
{
    return d->url;
}

void QDeclarativeWebView::setUrl(const QUrl& url)
{
    if (url == d->url)
        return;

    if (isComponentComplete()) {
        d->url = url;
        updateContentsSize();
        QUrl seturl = url;
        if (seturl.isEmpty())
            seturl = QUrl(QLatin1String("about:blank"));

        Q_ASSERT(!seturl.isEmpty());

      page()->mainFrame()->load(seturl);
            emit urlChanged();
    }
    else {
       d->pending = d->PendingUrl;
       d->pendingUrl = url;
   }
}

int QDeclarativeWebView::preferredWidth() const
{
    return d->preferredwidth;
}

void QDeclarativeWebView::setPreferredWidth(int width)
{
    if (d->preferredwidth == width)
        return;
    d->preferredwidth = width;
    updateContentsSize();
    emit preferredWidthChanged();
}

int QDeclarativeWebView::preferredHeight() const
{
    return d->preferredheight;
}

void QDeclarativeWebView::setPreferredHeight(int height)
{
    if (d->preferredheight == height)
        return;
    d->preferredheight = height;
    updateContentsSize();
    emit preferredHeightChanged();
}

QVariant QDeclarativeWebView::evaluateJavaScript(const QString& scriptSource)
{
    return this->page()->mainFrame()->evaluateJavaScript(scriptSource);
}

void QDeclarativeWebView::updateDeclarativeWebViewSize()
{
    QSizeF size = d->view->geometry().size() * contentsScale();
    setImplicitWidth(size.width());
    setImplicitHeight(size.height());
}

void QDeclarativeWebView::initialLayout()
{
    // nothing useful to do at this point
}

void QDeclarativeWebView::updateContentsSize()
{
    if (page()) {
        page()->setPreferredContentsSize(QSize(
            d->preferredwidth>0 ? d->preferredwidth : width(),
            d->preferredheight>0 ? d->preferredheight : height()));

    }
}

void QDeclarativeWebView::geometryChanged(const QRectF& newGeometry, const QRectF& oldGeometry)
{
    QWebPage* webPage = page();
    if (newGeometry.size() != oldGeometry.size() && webPage) {
        QSize contentSize = webPage->preferredContentsSize();
        if (widthValid())
            contentSize.setWidth(width());
        if (heightValid())
            contentSize.setHeight(height());
        if (contentSize != webPage->preferredContentsSize())
            webPage->setPreferredContentsSize(contentSize);
    }
    QDeclarativeItem::geometryChanged(newGeometry, oldGeometry);
}

QDeclarativeListProperty<QObject> QDeclarativeWebView::javaScriptWindowObjects()
{
    return QDeclarativeListProperty<QObject>(this, d, &QDeclarativeWebViewPrivate::windowObjectsAppend);
}

QDeclarativeWebViewAttached* QDeclarativeWebView::qmlAttachedProperties(QObject* o)
{
    return new QDeclarativeWebViewAttached(o);
}

void QDeclarativeWebViewPrivate::updateWindowObjects()
{
    if (!q->isComponentCompletePublic() || !q->page())
        return;

    for (int i = 0; i < windowObjects.count(); ++i) {
        QObject* object = windowObjects.at(i);
        QDeclarativeWebViewAttached* attached = static_cast<QDeclarativeWebViewAttached *>(qmlAttachedPropertiesObject<QDeclarativeWebView>(object));
        if (attached && !attached->windowObjectName().isEmpty())
            q->page()->mainFrame()->addToJavaScriptWindowObject(attached->windowObjectName(), object);
    }
}

bool QDeclarativeWebView::renderingEnabled() const
{
    return d->rendering;
}

void QDeclarativeWebView::setRenderingEnabled(bool enabled)
{
    if (d->rendering == enabled)
        return;
    d->rendering = enabled;
    emit renderingEnabledChanged();
    d->view->setTiledBackingStoreFrozen(!enabled);
}

bool QDeclarativeWebView::heuristicZoom(int clickX, int clickY, qreal maxZoom)
{
    if (contentsScale() >= maxZoom / scale())
        return false;
    qreal ozf = contentsScale();
    QRect showArea = elementAreaAt(clickX, clickY, d->preferredwidth / maxZoom, d->preferredheight / maxZoom);
    qreal z = qMin(qreal(d->preferredwidth) / showArea.width(), qreal(d->preferredheight) / showArea.height());
    if (z > maxZoom / scale())
        z = maxZoom / scale();
    if (z / ozf > 1.2) {
        QRectF r(showArea.left() * z, showArea.top() * z, showArea.width() * z, showArea.height() * z);
        emit zoomTo(z, r.x() + r.width() / 2, r.y() + r.height() / 2);
        return true;
    }
    return false;
}

int QDeclarativeWebView::pressGrabTime() const
{
    return d->view->pressTime;
}

void QDeclarativeWebView::setPressGrabTime(int millis)
{
    if (d->view->pressTime == millis)
        return;
    d->view->pressTime = millis;
    emit pressGrabTimeChanged();
}



QAction* QDeclarativeWebView::selectAll() const{
  return page()->action(QWebPage::SelectAll);
}
QAction* QDeclarativeWebView::reloadActionNoCache() const{
    return page()->action(QWebPage::ReloadAndBypassCache);
}
#ifndef QT_NO_ACTION

QAction* QDeclarativeWebView::backAction() const
{
    return page()->action(QWebPage::Back);
}
QAction* QDeclarativeWebView::forwardAction() const
{
    return page()->action(QWebPage::Forward);
}

QAction* QDeclarativeWebView::reloadAction() const
{
    return page()->action(QWebPage::Reload);
}
QAction* QDeclarativeWebView::stopAction() const
{
    return page()->action(QWebPage::Stop);
    loadingStopped=true;
}


#endif // QT_NO_ACTION


void QDeclarativeWebView::findtxt(const QString bob)  {

   page()->findText(bob, QWebPage::HighlightAllOccurrences);
   qDebug() << bob;
}
QString QDeclarativeWebView::title() const
{
    return page()->mainFrame()->title();
}

QPixmap QDeclarativeWebView::icon() const
{
    return page()->mainFrame()->icon().pixmap(QSize(256, 256));
}

void QDeclarativeWebView::setStatusText(const QString& text)
{
    d->statusText = text;
    emit statusTextChanged();
}

void QDeclarativeWebView::windowObjectCleared()
{
    d->updateWindowObjects();
}

QString QDeclarativeWebView::statusText() const
{
    return d->statusText;
}

QString QDeclarativeWebView::httpsState() const{

}

QWebPage* QDeclarativeWebView::page() const
{
    return d->view->page();
}


QDeclarativeWebSettings* QDeclarativeWebView::settingsObject() const
{
    d->settings.s = page()->settings();
    return &d->settings;
}


void QDeclarativeWebView::setPage(QWebPage* page)
{
    if (d->view->page() == page)
        return;

    d->view->setPage(page);
    updateContentsSize();
/*  QPalette darkPalette;
        darkPalette.setColor(QPalette::Window,          Qt::black);
        darkPalette.setColor(QPalette::WindowText,      Qt::white);
        darkPalette.setColor(QPalette::Base,            QColor(25,25,25));
        darkPalette.setColor(QPalette::AlternateBase,   QColor(88,88,88));
        darkPalette.setColor(QPalette::ToolTipBase,     Qt::white);
        darkPalette.setColor(QPalette::ToolTipText,     Qt::white);
        darkPalette.setColor(QPalette::Text,            Qt::white);
        darkPalette.setColor(QPalette::Button,          QColor(53,53,53));
        darkPalette.setColor(QPalette::ButtonText,      Qt::white);
        darkPalette.setColor(QPalette::BrightText,      Qt::red);
        darkPalette.setColor(QPalette::Link,            QColor(42, 130, 218));
        darkPalette.setColor(QPalette::Highlight,       QColor(150, 200, 255));
        darkPalette.setColor(QPalette::HighlightedText, Qt::black);

    page->setPalette(darkPalette);
*/

    page->mainFrame()->setScrollBarPolicy(Qt::Horizontal, Qt::ScrollBarAlwaysOff);
    page->mainFrame()->setScrollBarPolicy(Qt::Vertical, Qt::ScrollBarAlwaysOff);
    page->setLinkDelegationPolicy(QWebPage::DelegateAllLinks);


   // connect(page, SIGNAL (databaseQuotaExceeded(QWebFrame* frame, QString databaseName)), this, SLOT (dataBaseQuotaExceeded(QWebFrame * frame, QString databaseName)));
    connect(page, SIGNAL(linkClicked(QUrl)), this, SLOT(linkclicked(QUrl)));
    connect(page->mainFrame(), SIGNAL(urlChanged(QUrl)), this, SLOT(pageUrlChanged()));
    connect(page->mainFrame(), SIGNAL(titleChanged(QString)), this, SIGNAL(titleChanged(QString)));
    connect(page->mainFrame(), SIGNAL(titleChanged(QString)), this, SIGNAL(iconChanged()));
    connect(page->mainFrame(), SIGNAL(iconChanged()), this, SIGNAL(iconChanged()));
    connect(page->mainFrame(), SIGNAL(initialLayoutCompleted()), this, SLOT(initialLayout()));
    connect(page->mainFrame(), SIGNAL(contentsSizeChanged(QSize)), this, SIGNAL(contentsSizeChanged(QSize)));
    connect(page, SIGNAL(loadStarted()), this, SLOT(doLoadStarted()));
    connect(page, SIGNAL(loadProgress(int)), this, SLOT(doLoadProgress(int)));
    connect(page, SIGNAL(loadFinished(bool)), this, SLOT(doLoadFinished(bool)));
    connect(page, SIGNAL(statusBarMessage(QString)), this, SLOT(setStatusText(QString)));
    connect(page, SIGNAL(downloadRequested(QNetworkRequest)), this, SLOT(doDownload(QNetworkRequest)));

    page->setForwardUnsupportedContent(true);
    connect(page, SIGNAL (windowCloseRequested()), this, SIGNAL (windowCloseRequestedPage()));
    connect(page, SIGNAL(unsupportedContent(QNetworkReply*)), this, SLOT(unsupportedContent(QNetworkReply*)));
    connect(page, SIGNAL(featurePermissionRequested(QWebFrame*, QWebPage::Feature)), SLOT(featurePermRequested(QWebFrame*, QWebPage::Feature)));
    connect(page->mainFrame(), SIGNAL(javaScriptWindowObjectCleared()), this, SLOT(windowObjectCleared()));
    page->settings()->setAttribute(QWebSettings::TiledBackingStoreEnabled, true);
    page->settings()->setAttribute(QWebSettings::AcceleratedCompositingEnabled, true);
    page->settings()->setAttribute(QWebSettings::DnsPrefetchEnabled, true);
    page->settings()->setAttribute(QWebSettings::FrameFlatteningEnabled, true);
    page->settings()->setAttribute(QWebSettings::DeveloperExtrasEnabled, false);
    page->settings()->setAttribute(QWebSettings::PluginsEnabled, true);
    if(QFile::exists("e:/")){ page->settings()->setLocalStoragePath("E:/AllstarSoftware/StarBrowser/LocalStorage/");
        page->settings()->setIconDatabasePath("E:/AllstarSoftware/StarBrowser/IconDatabase/");
        page->settings()->setOfflineStoragePath("E:/AllstarSoftware/StarBrowser/OfflineStorage/");
        page->settings()->setOfflineWebApplicationCachePath("E:/AllstarSoftware/StarBrowser/WebApplicationCache/");}
    else{
        page->settings()->setLocalStoragePath("C:/AllstarSoftware/StarBrowser/LocalStorage/");
                page->settings()->setIconDatabasePath("C:/AllstarSoftware/StarBrowser/IconDatabase/");
                page->settings()->setOfflineStoragePath("C:/AllstarSoftware/StarBrowser/OfflineStorage/");
                page->settings()->setOfflineWebApplicationCachePath("C:/AllstarSoftware/StarBrowser/WebApplicationCache/");
    }

    page->settings()->setOfflineStorageDefaultQuota(500000000);

}



bool QWebPage::shouldInterruptJavaScript () {
    Setting* set= new Setting;
    if(set->getSystemSetting("interruptJS", "") =="false"){
          return false;
    }
    else{return true;}
    delete set;

}

TPtrC16 QDeclarativeWebView::convertToSymbianString(QString string) {
return reinterpret_cast<const TUint16*>(string.utf16());
}
 void QDeclarativeWebView::featurePermRequested(QWebFrame* frame, QWebPage::Feature feature)
{
     if(feature==QWebPage::Geolocation) {
       Setting * set= new Setting();
        if(set->getSystemSetting("geoLocation", "")==""){
         qDebug() << "FEATURE REQUESTED";
         qDebug()<< feature;
         qDebug() << frame;
         QString urle;
         QString title ="Device Location";
         urle="Allow website to use your location?\n" + d->url.toString();
         CAknGlobalMsgQuery* pDlg = CAknGlobalMsgQuery::NewL();
          CleanupStack::PushL(pDlg);
           TRequestStatus iStatus;
         pDlg->ShowMsgQueryL(iStatus, convertToSymbianString(urle), R_AVKON_SOFTKEYS_YES_NO, convertToSymbianString(title), KNullDesC,0,-1,CAknQueryDialog::ENoTone);

         User::WaitForRequest(iStatus);

         CleanupStack::PopAndDestroy(pDlg);
         if (iStatus.Int() == EAknSoftkeyYes)
          {page()->setFeaturePermission(frame,feature,QWebPage::PermissionGrantedByUser);emit geoLocationPermissionAccepted();}
          else if(iStatus.Int() == EAknSoftkeyNo)
          {page()->setFeaturePermission(frame,feature,QWebPage::PermissionDeniedByUser);emit geoLocationPermissionDenied();}
         }

        else{page()->setFeaturePermission(frame,feature,QWebPage::PermissionDeniedByUser);}
     }

     else if(feature==QWebPage::Notifications){
         TRAP_IGNORE(CAknDiscreetPopup::ShowGlobalPopupL((_L("Sorry,")), (_L("Web Notifications Unsupported")),KAknsIIDNone, KNullDesC));
     }
}

 void QDeclarativeWebView::accept(QWebFrame* frame, QWebPage::Feature feature){

 }



void QDeclarativeWebView::linkclicked(const QUrl &url) {
   // qDebug()<< url;
    setUrl(url);
   // page()->set
}


void QDeclarativeWebView::load(const QNetworkRequest& request, QNetworkAccessManager::Operation operation, const QByteArray& body)
{
    page()->mainFrame()->load(request, operation, body);

}

QString QDeclarativeWebView::html() const
{
    return page()->mainFrame()->toHtml();
}

void QDeclarativeWebView::setHtml(const QString& html, const QUrl& baseUrl)
{
    updateContentsSize();
    if (isComponentComplete())
        page()->mainFrame()->setHtml(html, baseUrl);
    else {
        d->pending = d->PendingHtml;
        d->pendingUrl = baseUrl;
        d->pendingString = html;
    }
    emit htmlChanged();
}

void QDeclarativeWebView::setContent(const QByteArray& data, const QString& mimeType, const QUrl& baseUrl)
{
    updateContentsSize();

    if (isComponentComplete())
        page()->mainFrame()->setContent(data, mimeType, qmlContext(this)->resolvedUrl(baseUrl));
    else {
        d->pending = d->PendingContent;
        d->pendingUrl = baseUrl;
        d->pendingString = mimeType;
        d->pendingData = data;

    }
}

QWebHistory* QDeclarativeWebView::history() const
{
    return page()->history();
}

QWebSettings* QDeclarativeWebView::settings() const
{
    return page()->settings();
}


QDeclarativeWebView* QDeclarativeWebView::createWindow(QWebPage::WebWindowType type)
{
    TRAP_IGNORE(CAknDiscreetPopup::ShowGlobalPopupL((_L("Sorry,")), (_L("Direct Opening Unsupported")),KAknsIIDNone, KNullDesC));
    return 0;
}


// to download a file/link


void QDeclarativeWebView::doDownload(const QNetworkRequest &request)
{
    QString msg= "Would you like to download this file?\n" + request.url().toString();
    QString title="Download File?";
    CAknGlobalMsgQuery* pDlg = CAknGlobalMsgQuery::NewL();
     CleanupStack::PushL(pDlg);
      TRequestStatus iStatus;
    pDlg->ShowMsgQueryL(iStatus, convertToSymbianString(msg), R_AVKON_SOFTKEYS_YES_NO, convertToSymbianString(title), KNullDesC,0,-1,CAknQueryDialog::ENoTone);

    User::WaitForRequest(iStatus);

    CleanupStack::PopAndDestroy(pDlg);
    if (iStatus.Int() == EAknSoftkeyYes)
     {QString defaultFileName = QFileInfo(request.url().toString()).fileName();
        QString fileName = QFileDialog::getSaveFileName(0, tr("Save File"), defaultFileName);

        if (fileName.isEmpty()) return;
        emit(downloadRequested(request.url(), fileName));
    }
     else if(iStatus.Int() == EAknSoftkeyNo)
     {}


}
void QDeclarativeWebView::unsupportedContent( QNetworkReply *reply)
{
    if (reply->error() == QNetworkReply::NoError)
    {

    QString urler;
   urler=d->url.toString();

   if(urler.endsWith(".mp3") || urler.endsWith(".MP3") || urler.endsWith(".wma") || urler.endsWith(".WMA")||urler.endsWith(".m3u")|| urler.endsWith(".M3U") || urler.endsWith(".m4a") || urler.endsWith(".M4A") || urler.endsWith(".wav") || urler.endsWith(".WAV")){QUrl data;
     data=d->url;
      emit audioRequested(data);}

   else if (urler.endsWith(".mp4")||urler.contains(".mp4")){

       if(urler.startsWith("https://mbasic.facebook.com", 0)){
           QString msg = "Due to the way Facebook handles Video downloads Star Browser Cannot play or download them.";
           CAknInformationNote* msger = new (ELeave) CAknInformationNote(ETrue);
            msger->SetTone(CAknNoteDialog::ENoTone);
            msger->SetTimeout(CAknNoteDialog::ELongTimeout);
            msger->ExecuteLD(TPtrC16(reinterpret_cast<const TText*>(QString(msg).constData())));
            CleanupStack::PopAndDestroy(&msger);
       }

       else{

       QUrl data;
        data=d->url;
       QString dater;
       dater=data.toString();

      QStringList splitData= dater.split("?");
        QString newUrl= "";
        for (int i=0; i<splitData.size(); i++){
            if(splitData.at(i).contains(".mp4") || (".MP4")){
                newUrl=splitData.at(i);

                if(!newUrl.startsWith("http")){
                    int position = newUrl.indexOf("http",0);
                    if(position !=-1){
                        newUrl= newUrl.mid(position, -newUrl.length()-position);
                    }
                    else
                        newUrl="";
                }
                break;
            }
        }
      emit videoRequested(data);

        }
   }

   else{
           QString urle;
           QString title ="Download File";
           urle="Would you like to download this file?\n" + reply->url().toString();
           CAknGlobalMsgQuery* pDlg = CAknGlobalMsgQuery::NewL();
            CleanupStack::PushL(pDlg);
             TRequestStatus iStatus;
           pDlg->ShowMsgQueryL(iStatus, convertToSymbianString(urle), R_AVKON_SOFTKEYS_YES_NO, convertToSymbianString(title), KNullDesC,0,-1,CAknQueryDialog::ENoTone);
           User::WaitForRequest(iStatus);
           CleanupStack::PopAndDestroy(pDlg);
           if (iStatus.Int() == EAknSoftkeyYes)
            {
               QString defaultFileName = QFileInfo(reply->url().toString()).fileName();
                          QString fileName = QFileDialog::getSaveFileName(0, tr("Save File"), defaultFileName);

                         if (fileName.isEmpty()) return;
                         emit(downloadRequested(reply->url(), fileName));


           }
            else if(iStatus.Int() == EAknSoftkeyNo)
            {}

   }


   }

   else{TRAP_IGNORE(CAknDiscreetPopup::ShowGlobalPopupL((_L("Error Handling Content")), (_L("")),KAknsIIDNone, KNullDesC));
  }

}


QDeclarativeComponent* QDeclarativeWebView::newWindowComponent() const
{
    return d->newWindowComponent;
}

void QDeclarativeWebView::setNewWindowComponent(QDeclarativeComponent* newWindow)
{

    if (newWindow == d->newWindowComponent)
        return;
    d->newWindowComponent = newWindow;
    emit newWindowComponentChanged();

}

QDeclarativeItem* QDeclarativeWebView::newWindowParent() const
{
    return d->newWindowParent;
}


void QDeclarativeWebView::setNewWindowParent(QDeclarativeItem* parent)
{
    //qDebug() << d->url;
    if (parent == d->newWindowParent)
        return;
    if (d->newWindowParent && parent) {
        QList<QGraphicsItem *> children = d->newWindowParent->childItems();
        for (int i = 0; i < children.count(); ++i)
            children.at(i)->setParentItem(parent);
    }
    d->newWindowParent = parent;
    emit newWindowParentChanged();
}

QSize QDeclarativeWebView::contentsSize() const
{
    return page()->mainFrame()->contentsSize() * contentsScale();
}

qreal QDeclarativeWebView::contentsScale() const
{
    return d->view->scale();
}

void QDeclarativeWebView::setContentsScale(qreal scale)
{
    if (scale == d->view->scale())
        return;
    d->view->setScale(scale);
    updateDeclarativeWebViewSize();
    emit contentsScaleChanged();
}

QRect QDeclarativeWebView::elementAreaAt(int x, int y, int maxWidth, int maxHeight) const
{
    QWebHitTestResult hit = page()->mainFrame()->hitTestContent(QPoint(x, y));
    QRect hitRect = hit.boundingRect();
    QWebElement element = hit.enclosingBlockElement();
    if (maxWidth <= 0)
        maxWidth = INT_MAX;
    if (maxHeight <= 0)
        maxHeight = INT_MAX;
    while (!element.parent().isNull() && element.geometry().width() <= maxWidth && element.geometry().height() <= maxHeight) {
        hitRect = element.geometry();
        element = element.parent();
    }
    return hitRect;
}

QDeclarativeWebPage::QDeclarativeWebPage(QDeclarativeWebView* parent) :
    QWebPage(parent)
{
}

QDeclarativeWebPage::~QDeclarativeWebPage()
{
}


QString QDeclarativeWebPage::chooseFile(QWebFrame* originatingFrame, const QString& oldFile)
{    Q_UNUSED(originatingFrame)
    QString newFilename = QFileDialog::getOpenFileName();
    return newFilename.isNull() ? oldFile : newFilename;
}

void QDeclarativeWebPage::javaScriptAlert(QWebFrame* originatingFrame, const QString& msg)
{
   CAknInformationNote* msger = new (ELeave) CAknInformationNote(ETrue);
    msger->SetTone(CAknNoteDialog::ENoTone);
   msger->ExecuteLD(TPtrC16(reinterpret_cast<const TText*>(QString(msg).constData())));

}


bool QDeclarativeWebPage::javaScriptConfirm(QWebFrame* originatingFrame, const QString& msg)
{
    Q_UNUSED(originatingFrame)
   QMessageBox::StandardButton result = QMessageBox::question(0, tr("Confirm"), msg, QMessageBox::Ok|QMessageBox::Cancel);
  return result == QMessageBox::Ok;
   CleanupStack::PopAndDestroy(&result);

}

bool QDeclarativeWebPage::javaScriptPrompt(QWebFrame* originatingFrame, const QString& msg, const QString& defaultValue, QString* result)
{
   TBuf<256> test;
   test.Copy(TPtrC16(reinterpret_cast<const TText*>(msg.constData())));
   CAknTextQueryDialog* dlg = CAknTextQueryDialog::NewL(test);
   dlg->SetPromptL(TPtrC16(reinterpret_cast<const TText*>(QString(defaultValue).constData())));
   dlg->ExecuteLD(R_AVKON_DIALOG_QUERY_VALUE_TEXT);
   *result = QString ((QChar*)test.Ptr(),test.Length());
           return !result->isEmpty();

}



void QDeclarativeWebPage::javaScriptConsoleMessage(const QString &msg, int lineNumber, const QString &sourceID)
{
    Setting * set = new Setting();
    QString logEntry = "Date: "+ QDateTime::currentDateTime().toString("d-M-yy_h-m-s")+  "\n" + msg+ "\n" + "on line:"+ QString::number(lineNumber) + "\n" +" Source:"+ sourceID ;
    //    qDebug()<<logEntry;

    if(set->getJSSetting() == true){
            if(QFile::exists("e:/")){
        QFile file("E:\\AllstarSoftware\\StarBrowser\\debug.txt");
          if (!file.open(QIODevice::WriteOnly | QIODevice::Append | QIODevice::Text))
              return;
          QTextStream out(&file);
          out <<  logEntry  << endl;
          file.close();
          file.deleteLater();
            }
            else{
                QFile file("C:\\AllstarSoftware\\StarBrowser\\debug.txt");
                  if (!file.open(QIODevice::WriteOnly | QIODevice::Append | QIODevice::Text))
                      return;
                  QTextStream out(&file);
                  out <<  logEntry  << endl;
                  file.close();
                  file.deleteLater();
            }
    }

       delete set;
}

QDeclarativeWebView* QDeclarativeWebPage::viewItem()
{
    return static_cast<QDeclarativeWebView*>(parent());
}

QWebPage* QDeclarativeWebPage::createWindow(WebWindowType type)
{

    QDeclarativeWebView* newView = viewItem()->createWindow(type);
    if (newView)
        return newView->page();
    return 0;
}



QT_END_NAMESPACE
