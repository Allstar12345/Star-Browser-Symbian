/*Copyright (C) 2020 Allstar Software (Paul Wallace)*/

#include "downloadbackend.h"
#include <qmobilityglobal.h>
#include <QValueSpaceSubscriber.h>
#include <QValueSpacePublisher.h>
#include <QUrl>
#include <QDebug>
#include <QFileDialog>
#include <apgcli.h>
#include <apgtask.h>
#include <akndiscreetpopup.h>
#include <AknGlobalNote.h>
#include <AknCommonDialogs.h>
#include <AknCommonDialogsDynMem.h>
#include <avkon.mbg>
#include <aknnotewrappers.h>
#include <aknglobalnote.h>
static const TUid mngr = { 0xE0324327 };

DownloadBackend::DownloadBackend(QObject *parent) :
    QObject(parent)

{
    data = new QValueSpacePublisher( "/StarBrowser/downloadManager", this );
    dataer = new QValueSpaceSubscriber ("/StarBrowser/downloadManager", this);
}

void DownloadBackend::add (QUrl src, QString target)
{
    TUid handlerUID;
    if (handlerUID.iUid == 0 || handlerUID.iUid == -1)
        handlerUID = mngr;
    TApaTaskList taskList(CEikonEnv::Static()->WsSession());
    TApaTask task = taskList.FindApp(handlerUID);
    if (task.Exists()) {
        task.BringToForeground();
        TRAP_IGNORE(CAknDiscreetPopup::ShowGlobalPopupL((_L("Download Manager Busy")), (_L("")),KAknsIIDNone, KNullDesC));

    } else {
        QString t;
      QString f;
      data->setValue("/src", src);
      data->setValue("/target", target);
      qDebug() << src;
      qDebug() << target;
      f = dataer->value("/src").toString();
      t = dataer->value("/target").toString();

      qDebug() << "Source " + f;
       qDebug() << "Target " + t;
        RProcess proc;
       User::LeaveIfError(proc.Create(_L("StarBrowserDownloadManager.exe"),KNullDesC));
       proc.Resume();
       proc.Close();
       return 0;
    }

}
void DownloadBackend::addFromQML(QUrl src,QString defaultFileName){

    QString fileName = QFileDialog::getSaveFileName(0, tr("Save File"), defaultFileName);
      QString t;
      QString f;
      if (fileName.isEmpty()) return;

      data->setValue("/src", src);
      data->setValue("/target", fileName);
      qDebug() << src;
      qDebug() << fileName;
      f = dataer->value("/src").toString();
      t = dataer->value("/target").toString();

      qDebug() << "Source " + f;
       qDebug() << "Target " + t;
       RProcess proc;
      User::LeaveIfError(proc.Create(_L("StarBrowserDownloadManager.exe"),KNullDesC));
      proc.Resume();
      proc.Close();
}
