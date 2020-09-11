/*Copyright (C) 2020 Allstar Software (Paul Wallace)*/

#ifndef QSYMBIANAPPLICATION_H
#define QSYMBIANAPPLICATION_H

#include <QObject>
#include <QtGui/QApplication>
#include <QSymbianEvent>
#include <w32std.h>
#include <eikenv.h>
#include <aknappui.h>
#include <QDebug>
#include <QValueSpaceSubscriber>
#include <QDeclarativeView>


QTM_USE_NAMESPACE

class QSymbianApplication : public QApplication
{
    Q_OBJECT
public:
    QSymbianApplication(int argc, char** argv);
    Q_INVOKABLE bool foreground();
    Q_INVOKABLE void downloadCloseDialog();


signals:
    void foregroundChanged(bool status);
    void redPressed();
    void keyboardEventChanged(int val);
    void inFocus();
    void inBackground();
    void reloadKey();
    void f3Key();
    void f4Key();
    void f6Key();
    void homeKey();
    void endKey();
    Q_INVOKABLE void closeWithoutDialog();
    Q_INVOKABLE void closeApp();


protected:
    bool eventFilter(QObject *obj, QEvent *eventer);
    bool symbianEventFilter(const QSymbianEvent* event);

    public slots:
  void stateChanged();
private:
    bool iForeground;
     QValueSpaceSubscriber* m_vkbstate;
     QDeclarativeView* currentView;
    
};



#endif // QSYMBIANAPPLICATION_H
