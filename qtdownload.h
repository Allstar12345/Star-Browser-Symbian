/*Copyright (C) 2020 Allstar Software (Paul Wallace)*/

#include <QObject>
#include <QString>
#include <QtNetwork/QNetworkAccessManager>
#include <QtNetwork/QNetworkReply>


class QtDownload : public QObject {
    Q_OBJECT
public:
 explicit QtDownload();
    Q_INVOKABLE void set(const QUrl& src, const QString &tar);
    Q_INVOKABLE void cancel();

private:
    QNetworkAccessManager* manager;
    QNetworkReply *pNetworkReply;
    QString target;
    QUrl source;
Q_SIGNALS:
    void showPopup();
signals:
    Q_INVOKABLE void done();
    Q_INVOKABLE void downloadStatus(float currentStatus);


public slots:
    Q_INVOKABLE void download();
    void downloadFinished(QNetworkReply* data);
    void downloadProgress(qint64 recieved, qint64 total);
};
