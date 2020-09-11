/*Copyright (C) 2020 Allstar Software (Paul Wallace)*/

#ifndef DOWNLOADMANAGER2_H
#define DOWNLOADMANAGER2_H

#include <QObject>
#include <QtNetwork/QNetworkAccessManager>
#include <QtNetwork/QNetworkRequest>
#include <QtNetwork/QNetworkReply>
#include <QFile>


class DownloadManager2 : public QObject
{
    Q_OBJECT
public:
    explicit DownloadManager2(QObject *parent = 0);
    Q_INVOKABLE QString downloadURL;
    bool inUse;

signals:
   Q_INVOKABLE void downloadComplete();

   Q_INVOKABLE  void  progressPercentage( int percentage);
    Q_INVOKABLE void downloadStatus(float currentStatus);
    Q_INVOKABLE void downloadStarted();
    Q_INVOKABLE void downloadPaused();
    Q_INVOKABLE void downloadResumed();
    Q_INVOKABLE void downloadedBytes(qint64 bytesReceived);
    Q_INVOKABLE void  downloadCancelled();
    Q_INVOKABLE void downloadURLChanged(QString downloadURL);


public slots:
     Q_INVOKABLE void cancel();
     Q_INVOKABLE void download(QUrl url, QString fileName);
     Q_INVOKABLE  void pause();
     Q_INVOKABLE  void resume();

private slots:

   void download( QNetworkRequest& request );
    Q_INVOKABLE   void finished();
    Q_INVOKABLE   void downloadProgress ( qint64 bytesReceived, qint64 bytesTotal );
     Q_INVOKABLE  void error ( QNetworkReply::NetworkError code );

private:

    QNetworkAccessManager* mManager;
    QNetworkRequest mCurrentRequest;
    QNetworkReply* mCurrentReply;
    QFile* mFile;
    int mDownloadSizeAtPause;
    QString defaultFileName;
    QString fileName;

};

#endif // DOWNLOADMANAGER2_H
