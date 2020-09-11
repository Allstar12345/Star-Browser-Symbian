/*Copyright (C) 2020 Allstar Software (Paul Wallace)*/

#include "qmlutils.h"
#include <QtCore/QDateTime>
#include <QtGui/QApplication>
#include <QApplication>
#include <QtGui/QClipboard>
#include <QtGui/QImage>
#include <QtGui/QStyleOptionGraphicsItem>
#include <QtGui/QPainter>
#include <QtGui/QDesktopServices>
#include <QDesktopServices>
#include <QtDeclarative/QDeclarativeItem>
#include <QtDeclarative/QDeclarativeView>
#include <QtDeclarative/QDeclarativeEngine>
#include <QDeclarativeProperty>
#include <QProcess>
#include <QUrl>
#include <QDir>
#include <QFile>
#include <CAknFileSelectionDialog.h>
#include <AknCommonDialogs.h>
#include <akndiscreetpopup.h>
#include <AknCommonDialogsDynMem.h>
#include <avkon.mbg>
#include <aknnotewrappers.h>
#include <aknglobalnote.h>
#include <eikenv.h>
#include <eikappui.h>
#include <aknenv.h>
#include <aknappui.h>
#include <QMessageBox>
#include <QInputDialog>
#include <QTextEdit>
#include <QDialog>
#include <QDialogButtonBox>
#include <aknnotewrappers.h>
#include <apgcli.h> // RApaLsSession
#include <apgtask.h>
#include <QFileDialog>
#include "settings.h"

_LIT(KBrowserPrefix, "4 " );
static const TUid KUidBrowser = { 0x10008D39 };
static const TUid lightbulb = { 0xe22ac278 };

QMLUtils::QMLUtils(QDeclarativeView *view, QObject *parent) :

    QObject(parent), m_view(view), clipboard(QApplication::clipboard())
{
    Setting* set= new Setting;
    if(set->getSystemSetting("killContext", "false") == "true") {m_view->setContextMenuPolicy(Qt::NoContextMenu);}
}

// Removed some code here for open source, to ensure integrity 
bool QMLUtils::isWebsiteSafe(QString url){
   
  /*  QString address;
    qDebug() << url;
    if(QFile::exists("e:/")) {
        dirCheckOrCreate("e:/AllstarSoftware/StarBrowser/SafeBrowsing/");
        address= "e:/AllstarSoftware/StarBrowser/SafeBrowsing/list.txt";}
    else{dirCheckOrCreate("c:/AllstarSoftware/StarBrowser/SafeBrowsing/");
        address= "c:/AllstarSoftware/StarBrowser/SafeBrowsing/list.txt";}


    QFile inputFile(address);
           if (inputFile.open(QIODevice::ReadOnly)) {
               QTextStream in(&inputFile);
               while (!in.atEnd()) {
                   QString line = in.readLine();
                   qDebug() << "Output: " << line;
                   if (line.contains(url, Qt::CaseInsensitive)) {
                       if(line.contains(url, Qt::CaseInsensitive)== "DShield.org" || "http://creativecommons.org"){}
                       else{return false;}}
               }
                        inputFile.close();
                       qDebug() << "Finished";
                       return true;
           }*/

}


void QMLUtils::dirCheckOrCreate(QString path)
{
    QDir dir(path);
    if (!dir.exists()) {
        dir.mkpath(path);
    }
}

QString QMLUtils::jsLog(){
    if(QFile::exists("e:/AllstarSoftware/StarBrowser/debug.txt")){
        QFile file("e:/AllstarSoftware/StarBrowser/debug.txt");
               file.open(QIODevice::ReadOnly);
               QTextStream stream(&file);
               QString content = stream.readAll();
               file.close();
              return content;
    }
    else{
        QFile file("c:/AllstarSoftware/StarBrowser/debug.txt");
               file.open(QIODevice::ReadOnly);
               QTextStream stream(&file);
               QString content = stream.readAll();
               file.close();
              return content;
    }
}


void QMLUtils::copyToClipboard(const QString &text)
{
#ifdef Q_WS_SIMULATOR
    qDebug("Text copied to clipboard: %s", qPrintable(text));
#endif
    clipboard->setText(text, QClipboard::Clipboard);
    clipboard->setText(text, QClipboard::Selection);
}

void QMLUtils::minimizeApp() const
{
    m_view->lower();
}
void QMLUtils::restart() const
{
    QProcess::startDetached (QApplication::applicationFilePath());
    exit(12);
}

void QMLUtils::opennotes() const
{
    QProcess::startDetached ("notepad.exe");
}


void QMLUtils::purgecookies()const{
    if(QFile::exists("e:/")){
        QFile* file= new QFile;
        file->remove("e:/AllstarSoftware/StarBrowser/CookieData/cookies.conf");
        delete file;
    }
    else{
        QFile* file= new QFile;
        file->remove("c:/AllstarSoftware/StarBrowser/CookieData/cookies.conf");
        delete file;}
}

void QMLUtils::purgeTemp() const{
    if(QFile::exists("e:/")){
        QFile* file= new QFile;
        file->remove("e:/AllstarSoftware/StarBrowser/LocalStorage");
        file->remove("e:/AllstarSoftware/StarBrowser/OfflineStorage");
        file->remove("e:/AllstarSoftware/StarBrowser/WebApplicationCache");
        file->remove("e:/AllStarSoftware/StarBrowser/qml-webview-network-cache-starbrowser");
        delete file;
    }
    else{
        QFile* file= new QFile;
        file->remove("c:/AllstarSoftware/StarBrowser/LocalStorage");
        file->remove("c:/AllstarSoftware/StarBrowser/OfflineStorage");
        file->remove("c:/AllstarSoftware/StarBrowser/WebApplicationCache");
         file->remove("c:/AllStarSoftware/StarBrowser/qml-webview-network-cache-starbrowser");
        delete file;}

}

QString QMLUtils::openFileSelectionDlg()
{
    TBuf16<255> filename;
    if (!AknCommonDialogs::RunSelectDlgLD(filename, 0))
            return NULL;
    QString qString = QString::fromUtf16(filename.Ptr(), filename.Length());
    return "file:///"+ qString;
}

void QMLUtils::showPopup(QString title, QString message) {
    TPtrC16 sTitle(reinterpret_cast<const TUint16*>(title.utf16()));
    TPtrC16 sMessage(reinterpret_cast<const TUint16*>(message.utf16()));
    TRAP_IGNORE(CAknDiscreetPopup::ShowGlobalPopupL(sTitle, sMessage, KAknsIIDNone, KNullDesC, 0, 0, 180, 0, NULL,  {0x20070763}));
}


void QMLUtils::hideFromSight() const{
    CAknAppUi* appUi = dynamic_cast<CAknAppUi*> (CEikonEnv::Static()->AppUi());
        TRAPD(error,
        if (appUi) {appUi->HideApplicationFromFSW(ETrue);
        }
        )
}
void QMLUtils::showToTask() const{
    CAknAppUi* appUi = dynamic_cast<CAknAppUi*> (CEikonEnv::Static()->AppUi());
        TRAPD(error,
        if (appUi) {appUi->HideApplicationFromFSW(EFalse);
        }
        )
}


void QMLUtils::exportSource(QString text, QString title) const{

    QFile file("E:/" + title + ".html");
    file.open(QIODevice::WriteOnly | QIODevice::Text);
    QTextStream out(&file);
    out << text  << endl;
    file.close();

}
void QMLUtils::openBrowser(const QUrl &url) const{
      QString encUrl(QString::fromUtf8(url.toEncoded()));
      TPtrC tUrl(TPtrC16(static_cast<const TUint16*>(encUrl.utf16()), encUrl.length()));
      RApaLsSession appArcSession;
      User::LeaveIfError(appArcSession.Connect());
      CleanupClosePushL<RApaLsSession>(appArcSession);
      TDataType mimeDatatype(_L8("application/x-web-browse"));
      TUid handlerUID;
      appArcSession.AppForDataType(mimeDatatype, handlerUID);
      if (handlerUID.iUid == 0 || handlerUID.iUid == -1)
          handlerUID = KUidBrowser;

      HBufC* buf16 = HBufC::NewLC(tUrl.Length() + KBrowserPrefix.iTypeLength);
      buf16->Des().Copy(KBrowserPrefix); // Prefix used to launch correct browser view
      buf16->Des().Append(tUrl);

      TApaTaskList taskList(CEikonEnv::Static()->WsSession());
      TApaTask task = taskList.FindApp(handlerUID);
      if (task.Exists()) {
          task.BringToForeground();
          HBufC8* param8 = HBufC8::NewLC(buf16->Length());
          param8->Des().Append(buf16->Des());
          task.SendMessage(TUid::Uid( 0 ), *param8); // Uid is not used
          CleanupStack::PopAndDestroy(param8);
      } else {
          TThreadId id;
          appArcSession.StartDocument(*buf16, handlerUID, id);
      }

      CleanupStack::PopAndDestroy(buf16);
      CleanupStack::PopAndDestroy(&appArcSession);}


void QMLUtils::snapWebPage(int window){
    if(QFile::exists("e:/")){
        QDir* dir = new QDir;
        if(dir->exists("E:/AllstarSoftware/StarBrowser/TabImagesCache")){
        QPixmap::grabWidget(m_view,0 ,0, 250, 360).save("E:/AllstarSoftware/StarBrowser/TabImagesCache/" + QString::number(window)+ ".png");
         delete dir;
        }
        else{
            dir->mkdir("E:/AllstarSoftware/StarBrowser/TabImagesCache");
            QPixmap::grabWidget(m_view, 0 ,0, 250, 360).save("E:/AllstarSoftware/StarBrowser/TabImagesCache/" + QString::number(window)+ ".png");
 delete dir;
        }
    }
    else{
        QDir* dir = new QDir;
        if(dir->exists("C:/AllstarSoftware/StarBrowser/TabImagesCache")){
        QPixmap::grabWidget(m_view, 0 ,0, 250, 360).save("C:/AllstarSoftware/StarBrowser/TabImagesCache/" + QString::number(window)+".png");
        delete dir;
    }
        else{
            QPixmap::grabWidget(m_view, 0 ,0, 250, 360).save("C:/AllstarSoftware/StarBrowser/TabImagesCache/"+ QString::number(window)+".png");
            delete dir;

        }
    }
}

void QMLUtils::snapScreen(){

QPixmap::grabWidget(m_view).save("E:/Images/" + QDateTime::currentDateTime().toString("yy-M-dd_h-m-s") + ".png");
qDebug("Screen Captured");}

void QMLUtils::exportBookmark(QString url, QString title) {
    QString fileName = QFileDialog::getSaveFileName(0, tr("Export Bookmark"), title) + ".txt";
    QFile file(fileName);
    file.open(QIODevice::WriteOnly | QIODevice::Text);
    QTextStream out(&file);
    out << url;
}
void QMLUtils::removeJSLog(){
    if(QFile::exists("e:/")){
        QFile* file= new QFile;
        file->remove("e:/AllstarSoftware/StarBrowser/debug.txt");
        delete file;
    }
    else{ QFile* file= new QFile;
        file->remove("c:/AllstarSoftware/StarBrowser/debug.txt");
        delete file;}
}

void QMLUtils::openJSLog(){

    if(QFile::exists("e:/AllstarSoftware/StarBrowser/debug.txt")){
        QUrl target;
        target= "file:///E:/AllstarSoftware/StarBrowser/debug.txt";
        QDesktopServices* opener = new QDesktopServices;
        opener->openUrl(target);
        delete opener;
    }
    else if(QFile::exists("file:///c:/AllstarSoftware/StarBrowser/debug.txt")){
        QUrl target;
        target= "file:///C:/AllstarSoftware/StarBrowser/debug.txt";
        QDesktopServices* opener = new QDesktopServices;
        opener->openUrl(target);
        delete opener;
}
}

void QMLUtils::openExternal(QString url){
    RApaLsSession
    apaLsSession;
    CleanupClosePushL
            (apaLsSession);
    User::LeaveIfError(apaLsSession.Connect());
    TThreadId threadId;
    apaLsSession.StartDocument(TPtrC16(reinterpret_cast<const TText*> (url.constData())), threadId);
    CleanupStack::PopAndDestroy(&apaLsSession);
}


bool QMLUtils::checkJSLog(){
    if(QFile::exists("e:/AllstarSoftware/StarBrowser/debug.txt")){
        return true;}
    else if(QFile::exists("c:/AllstarSoftware/StarBrowser/debug.txt")){
        return true;}
    else{ return false;}
}

void QMLUtils::purgeWindowImages(){
    QDir*dir = new QDir;
    if(QFile::exists("e:/")){

          if(dir->exists("E:/AllstarSoftware/StarBrowser/TabImagesCache")){
              QFile::remove("E:/AllstarSoftware/StarBrowser/TabImagesCache/0.png");
              QFile::remove("E:/AllstarSoftware/StarBrowser/TabImagesCache/1.png");
              QFile::remove("E:/AllstarSoftware/StarBrowser/TabImagesCache/2.png");
              QFile::remove("E:/AllstarSoftware/StarBrowser/TabImagesCache/3.png");
              QFile::remove("E:/AllstarSoftware/StarBrowser/TabImagesCache/4.png");
              QFile::remove("E:/AllstarSoftware/StarBrowser/TabImagesCache/5.png");
              QFile::remove("E:/AllstarSoftware/StarBrowser/TabImagesCache/6.png");
          }
        }
        else{
        if(dir->exists("C:/AllstarSoftware/StarBrowser/TabImagesCache")){
            QFile::remove("C:/AllstarSoftware/StarBrowser/TabImagesCache/0.png");
            QFile::remove("C:/AllstarSoftware/StarBrowser/TabImagesCache/1.png");
            QFile::remove("C:/AllstarSoftware/StarBrowser/TabImagesCache/2.png");
            QFile::remove("C:/AllstarSoftware/StarBrowser/TabImagesCache/3.png");
            QFile::remove("C:/AllstarSoftware/StarBrowser/TabImagesCache/4.png");
            QFile::remove("C:/AllstarSoftware/StarBrowser/TabImagesCache/5.png");
            QFile::remove("C:/AllstarSoftware/StarBrowser/TabImagesCache/6.png");
}

        }
    }
bool QMLUtils::checkImagesource(){

    if(QFile::exists("e:/")){
        return true;
    }
    else{
        return false;
    }
}


