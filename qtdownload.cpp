/*Copyright (C) 2020 Allstar Software (Paul Wallace)*/

#include "qtdownload.h"
#include <QCoreApplication>
#include <QUrl>
#include <QNetworkRequest>
#include <QFile>
#include <QDebug>
#include <QFileInfo>
#include <akndiscreetpopup.h>
#include <AknGlobalNote.h>
#include <QtGui/QDesktopServices>


QtDownload::QtDownload(){
}
bool cancelled;
void QtDownload::set(const QUrl &src, const QString &tar) {
    this->source = src;
    this->target = tar;
}

void QtDownload::cancel()
{
    pNetworkReply->abort();
}
void QtDownload::downloadFinished(QNetworkReply *data) {
    qDebug() << "finished";
    QFile localFile(QFileInfo(target).absoluteFilePath());
    if (!localFile.open(QIODevice::WriteOnly))
        return;
    const QByteArray sdata = data->readAll();
    localFile.write(sdata);
    qDebug() << sdata;
    qDebug() << "bla";
    qDebug() << target;
    localFile.close();
    emit done();
    TRAP_IGNORE(CAknDiscreetPopup::ShowGlobalPopupL((_L("Download Completed")), ((TPtrC16(reinterpret_cast<const TText*>(QString(target).constData())))) ,KAknsIIDNone, KNullDesC));

}
void QtDownload::download() {
    pNetworkReply = 0;
    manager = 0;
    QUrl url(source);
    QNetworkRequest request(url);
    manager = new QNetworkAccessManager(this);
    pNetworkReply = manager->get(request);
    QObject::connect(pNetworkReply, SIGNAL(downloadProgress(qint64,qint64)), this, SLOT(downloadProgress(qint64,qint64)));
    QObject::connect(manager, SIGNAL(finished(QNetworkReply*)), this, SLOT(downloadFinished(QNetworkReply*)));
    qDebug() << "Download Started";
    qDebug() << url;
    TRAP_IGNORE(CAknDiscreetPopup::ShowGlobalPopupL((_L("Download Started")), (_L("")),KAknsIIDNone, KNullDesC));
}



void QtDownload::downloadProgress(qint64 recieved, qint64 total) {
    qDebug() << (float)recieved/(float)total;
    emit downloadStatus((float)recieved/(float)total);
}
