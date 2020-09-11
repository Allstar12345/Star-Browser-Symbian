/*Copyright (C) 2020 Allstar Software (Paul Wallace)*/

#ifndef DOWNLOADBACKEND_H
#define DOWNLOADBACKEND_H

#include <QObject>
#include <QValueSpaceSubscriber>
#include <QValueSpacePublisher.h>
#include <QUrl>
QTM_USE_NAMESPACE
class DownloadBackend : public QObject
{
    Q_OBJECT
public:
    explicit DownloadBackend(QObject *parent = 0);
    
signals:
    
    public slots:
 Q_INVOKABLE void add(QUrl src, QString target);
 Q_INVOKABLE void addFromQML(QUrl src, QString defaultFileName);

private:

    QValueSpacePublisher* data;
    QValueSpaceSubscriber* dataer;
    
};

#endif // DOWNLOADBACKEND_H
