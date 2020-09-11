/*Copyright (C) 2020 Allstar Software (Paul Wallace)*/
/*Copyright (c) 2014 Maciej Janiszewski */
/*This file is part of Lightbulb.*/

#ifndef UPDATESYSTEM_H
#define UPDATESYSTEM_H
#include <QObject>
#include <QNetworkAccessManager>
#include <QNetworkReply>
#include <QDateTime>
#include <QStringList>
#include <QUrl>
class UpdateSystem : public QObject
{
Q_OBJECT
Q_PROPERTY(bool isUpdateAvailable READ getUpdateAvailability NOTIFY updateFound)
Q_PROPERTY(QString latestVersion READ getLatestVersion NOTIFY updateFound)
Q_PROPERTY(QString updateUrl READ getUpdateUrl NOTIFY updateFound)
Q_PROPERTY(QString updateLog READ getUpdateLog NOTIFY updateFound)
public:
explicit UpdateSystem(QObject *parent = 0);
Q_INVOKABLE void checkForUpdate();
signals:
void updateFound(QString version, QString date);
void versionUpToDate();
void errorOccured(QString errorString);
void downloadStatus(float currentStatus);
private slots:
void dataReceived(QNetworkReply *reply);
 void downloadProgress(qint64 recieved, qint64 total);
private:
QNetworkAccessManager *httpStuff;
QNetworkReply * replyer;
bool updateAvailable;
bool getUpdateAvailability() { return updateAvailable; }
QDateTime getUpdateDate();
QString getLatestVersion();
QString getUpdateUrl();
QString getUpdateLog();
QString replyData;
void compareVersions();
};
#endif // UPDATESYSTEM_H
