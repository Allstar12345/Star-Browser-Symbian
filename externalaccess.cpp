/*Copyright (C) 2020 Allstar Software (Paul Wallace)*/

#include "externalaccess.h"
#include <qmobilityglobal.h>
#include <QValueSpaceSubscriber.h>
#include <QValueSpacePublisher.h>
#include <QUrl>
#include <QDebug>
#include <apgtask.h>
#include <apgcli.h>
#include <qdeclarativewebview.h>
#include <QString>


ExternalAccess::ExternalAccess(QObject *parent):
        QObject(parent)
{
    qDebug() << "Loading.......";
   suc = new QValueSpaceSubscriber ("/Allstar/external/", this);
       QObject::connect(suc, SIGNAL( contentsChanged()),this,
                        SLOT( datachanged()) );
}


void ExternalAccess::datachanged()
{
    //   qDebug() <<"Some Shit..........";

   // QUrl urlrer;
    // urlrer = suc->value("/url").toUrl();
    // qDebug() << urlrer;
   //  m_webview = new QDeclarativeWebView;
   //  m_webview ->setUrl(urlrer);

}





