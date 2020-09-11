/*Copyright (C) 2020 Allstar Software (Paul Wallace)*/

#include "downloadmanager2.h"
#include <QFileInfo>
#include <QDebug>


DownloadManager2::DownloadManager2(QObject *parent) :
    QObject(parent),mCurrentReply(0),mFile(0),mDownloadSizeAtPause(0)
{
    mManager = new QNetworkAccessManager( this );
}



void DownloadManager2::cancel(){
    mCurrentReply->disconnect();
mCurrentReply->abort();

  emit downloadCancelled();
}

void DownloadManager2::download( QUrl url, QString fileName)
{

        qDebug() << "download: URL=" <<url.toString();
         mDownloadSizeAtPause =0;
         mCurrentRequest = QNetworkRequest(url);
            if (fileName.isEmpty()) return;
         mFile = new QFile(fileName);
         qDebug() << fileName;
         mFile->open(QIODevice::ReadWrite);
         downloadURL=url.toString();
         emit downloadURLChanged(downloadURL);
         download(mCurrentRequest);
         inUse=true;

}


void DownloadManager2::pause()
{
    qDebug() << "pause()";
    if( mCurrentReply == 0 ) {
        return;
    }
    disconnect(mCurrentReply,SIGNAL(finished()),this,SLOT(finished()));
    disconnect(mCurrentReply,SIGNAL(downloadProgress(qint64,qint64)),this,SLOT(downloadProgress(qint64,qint64)));
   // disconnect(mCurrentReply,SIGNAL(error(QNetworkReply::NetworkError)),this,SLOT(error(QNetworkReply::NetworkError)));
    mCurrentReply->disconnect();
    mCurrentReply->abort();
    mFile->write( mCurrentReply->readAll());
    mCurrentReply = 0;
    emit downloadPaused();

}

void DownloadManager2::resume()
{
    qDebug() << "resume()";

    mDownloadSizeAtPause = mFile->size();
    QByteArray rangeHeaderValue = "bytes=" + QByteArray::number(mDownloadSizeAtPause) + "-";
    mCurrentRequest.setRawHeader("Range",rangeHeaderValue);

    download(mCurrentRequest);
    emit downloadResumed();
}

void DownloadManager2::download( QNetworkRequest& request )
{
    mCurrentReply = mManager->get(request);

    connect(mCurrentReply,SIGNAL(finished()),this,SLOT(finished()));
    connect(mCurrentReply,SIGNAL(downloadProgress(qint64,qint64)),this,SLOT(downloadProgress(qint64,qint64)));
   // connect(mCurrentReply,SIGNAL(error(QNetworkReply::NetworkError)),this,SLOT(error(QNetworkReply::NetworkError)));
    emit downloadStarted();
}

void DownloadManager2::finished()
{
    qDebug() << "finished";
    mFile->close();
    mFile = 0;
    mCurrentReply = 0;
    emit downloadComplete();
   inUse=false;

}

void DownloadManager2::downloadProgress ( qint64 bytesReceived, qint64 bytesTotal )
{
    qDebug() << "Download Progress: Received=" << mDownloadSizeAtPause+bytesReceived <<": Total=" << mDownloadSizeAtPause+bytesTotal;

    mFile->write( mCurrentReply->readAll() );
    int percentage = ((mDownloadSizeAtPause+bytesReceived) * 100 )/ (mDownloadSizeAtPause+bytesTotal);

   // int percentage =(float)bytesReceived/(float)bytesTotal;
    qDebug() << "Percentage: " << percentage;

    emit progressPercentage(percentage);
     emit downloadStatus((float)bytesReceived/(float)bytesTotal);
     emit downloadedBytes (bytesReceived);

}

void DownloadManager2::error(QNetworkReply::NetworkError code)
{
    mFile->close();
        mFile = 0;
        mCurrentReply = 0;
    qDebug() << "Error:"<<code;

}
