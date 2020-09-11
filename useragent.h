/*Copyright (C) 2020 Allstar Software (Paul Wallace)*/

#ifndef USERAGENT_H
#define USERAGENT_H

#include <QObject>

class UserAgent : public QObject
{
    Q_OBJECT
public:
    explicit UserAgent(QObject *parent = 0);
    Q_INVOKABLE void update();
    
public slots:
    
};

#endif // USERAGENT_H
