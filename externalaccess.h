/*Copyright (C) 2020 Allstar Software (Paul Wallace)*/

#ifndef EXTERNALACCESS_H
#define EXTERNALACCESS_H

#include <QObject>
#include <QValueSpaceSubscriber>
#include <QValueSpacePublisher.h>
#include <QUrl>
#include <qdeclarativewebview.h>
QTM_USE_NAMESPACE
class ExternalAccess : public QObject
{
    Q_OBJECT
public:
    explicit ExternalAccess(QObject *parent = 0);

    signals:

        public slots: void datachanged();

private:
      QDeclarativeWebView* m_webview;
    QValueSpaceSubscriber* suc;

};

#endif // EXTERNALACCESS_H
