/*Copyright (C) 2020 Allstar Software (Paul Wallace)*/
/*Copyright (c) 2014 Maciej Janiszewski */
/*This file is part of Lightbulb.*/

#include "updatesystem.h"
#include <QObject>
#include <QNetworkAccessManager>
#include <QNetworkReply>
#include <QDateTime>
#include <QStringList>
#include <QUrl>
#include <QDebug>


UpdateSystem::UpdateSystem(QObject *parent) :
QObject(parent)
{
httpStuff = new QNetworkAccessManager;
connect(httpStuff,SIGNAL(finished(QNetworkReply*)),this,SLOT(dataReceived(QNetworkReply*)));
updateAvailable = false;
}

// URL goes here if you want to add your own update checker
void UpdateSystem::checkForUpdate() {
replyer =httpStuff->get(QNetworkRequest(QUrl("")));
QObject::connect(replyer, SIGNAL(downloadProgress(qint64,qint64)), this, SLOT(downloadProgress(qint64,qint64)));
}
QString UpdateSystem::getLatestVersion() { return replyData.split(";")[0]; }
QDateTime UpdateSystem::getUpdateDate() { return QDateTime::fromString(replyData.split(";")[1],"dd-MM-yyyy"); }
QString UpdateSystem::getUpdateUrl() { return replyData.split(";")[2]; }

QString UpdateSystem::getUpdateLog(){return replyData.split(";").count() < 3 ? QString("") : replyData.split(";")[3];}
void UpdateSystem::dataReceived(QNetworkReply *reply) {
if (reply->error() == QNetworkReply::NoError) {
replyData = reply->readAll();
this->compareVersions();
} else {
// throw an error
emit errorOccured(reply->errorString());
}
}
void UpdateSystem::compareVersions() {
// get versions to compare
    QStringList clientVersion = QString("1.74").split('.');
QStringList latestVersion = getLatestVersion().split('.');
QString releaseDate = getUpdateDate().toString("dd-MM-yy");
// iterate through version number
for (int i=0; i < clientVersion.count(); i++) {
// check if version is lower than current one
if (clientVersion[i].toInt() < latestVersion[i].toInt())
updateAvailable = true;
// version on the server is older, return
if (clientVersion[i].toInt() > latestVersion[i].toInt())
return;
}
// compare release date (remember to update this every build)
if (getUpdateDate() > QDateTime::fromString("15/09/15","dd-MM-yyyy"))
updateAvailable = true;
// emit signal
if (updateAvailable == true)
emit updateFound(getLatestVersion(),releaseDate);
else
emit versionUpToDate();
}

void UpdateSystem::downloadProgress(qint64 recieved, qint64 total) {
   //qDebug() << (float)recieved/(float)total;
    emit downloadStatus((float)recieved/(float)total);
 //  qDebug() << (double(recieved)/total) * 100 << "%";

}

