/*Copyright (C) 2020 Allstar Software (Paul Wallace)*/

#include "qsymbianapplication.h"
#include <coemain.h>    // for CCoeEnv, LIBS += -lcone
#include <w32std.h>
#include <QDebug>
#include <Qfile>
#include <QKeyEvent>
#include <aknmessagequerydialog.h>
#include <aknglobalmsgquery.h>
#include <e32svr.h>
#include <eikmenup.h>
#include <coemain.h>
#include <AknGlobalNote.h>
#include <AknCommonDialogs.h>
#include <AknCommonDialogsDynMem.h>
#include <avkon.mbg>
#include <aknnotewrappers.h>
#include <aknglobalnote.h>




QSymbianApplication::QSymbianApplication(int argc, char** argv) :
    QApplication(argc, argv), iForeground(false)
{
    m_vkbstate = new QValueSpaceSubscriber( "/vkb/state", this );
    QObject::connect( m_vkbstate, SIGNAL( contentsChanged() ), this, SLOT( stateChanged() ) );
    installEventFilter(this);
}



bool QSymbianApplication::foreground()
{
    return iForeground;
}

void QSymbianApplication::stateChanged()
{
    bool ok = false;
    int val = m_vkbstate->value().toInt( &ok );

    // ignore state changes if we're not the foreground application
#ifdef Q_OS_SYMBIAN
    if ( ok && CCoeEnv::Static() )
        if ( CCoeEnv::Static()->RootWin().OrdinalPosition() != 0 )
            return;
#endif

    if ( ok ) {
        qDebug()<< val;
        emit keyboardEventChanged(val);
    }
}

bool QSymbianApplication::symbianEventFilter(const QSymbianEvent *event)
{
    if (event->type() == QSymbianEvent::WindowServerEvent) {
        switch (event->windowServerEvent()->Type()) {
        case KAknUidValueEndKeyCloseEvent: {
                  emit redPressed();
            return true;

        }

        case EEventFocusGained: {
            iForeground = true;
            emit foregroundChanged(iForeground);
            emit inFocus();
        }
            break;


        case EEventFocusLost: {
            iForeground = false;
            emit foregroundChanged(iForeground);
            emit inBackground();
        }
            break;

           case EEventErrorMessage:{
               qDebug() << EEventErrorMessage;
               QFile file("E:\\AllstarSoftware\\StarBrowser\\errdebug.txt");
                 if (!file.open(QIODevice::WriteOnly | QIODevice::Append | QIODevice::Text))
                     return;
                 QTextStream out(&file);
                 out <<   EEventErrorMessage  << endl;

           }
               break;

        }
    }
    else if (event->type() == QSymbianEvent::CommandEvent) {
        if (event->command() == EEikCmdExit) {
                 qDebug() << "Closed from TaskSwitcher!";
                 emit redPressed();
            return true;

        }
    }

    return QApplication::symbianEventFilter(event);

}

bool QSymbianApplication::eventFilter(QObject *obj, QEvent *eventer)
{
    if(eventer->type() == QEvent::KeyPress)
    {
        QKeyEvent *key = static_cast<QKeyEvent *>(eventer);

          if((key->key() == Qt::Key_F5))
        {
            emit reloadKey();

        }

          else if((key->key() == Qt::Key_F3))
        {
              emit f3Key();

        }
          else if((key->key() == Qt::Key_F4))
        {
              emit f4Key();

        }
          else if((key->key() == Qt::Key_F6))
        {
              emit f6Key();

        }
          else if((key->key() == Qt::Key_Home))
        {
              emit homeKey();

        }
          else if((key->key() == Qt::Key_End))
        {
              emit endKey();

        }

        else
        {
            return QObject::eventFilter(obj, eventer);
        }
        return true;
    }
    else
    {
        return QObject::eventFilter(obj, eventer);
    }

    return false;
}




TPtrC16 convertToSymbianString(QString string) {
return reinterpret_cast<const TUint16*>(string.utf16());
}
void QSymbianApplication::downloadCloseDialog(){

    QString msg= "You have a Download in progress, close Star Browser anyway?";
    QString title="Close";
    CAknGlobalMsgQuery* pDlg = CAknGlobalMsgQuery::NewL();
     CleanupStack::PushL(pDlg);
      TRequestStatus iStatus;
      pDlg->ShowMsgQueryL(iStatus, convertToSymbianString(msg), R_AVKON_SOFTKEYS_YES_NO, convertToSymbianString(title), KNullDesC,0,-1,CAknQueryDialog::ENoTone);

    User::WaitForRequest(iStatus);
    CleanupStack::PopAndDestroy(pDlg);
    if (iStatus.Int() == EAknSoftkeyYes)
    {emit closeWithoutDialog();

    }
     else if(iStatus.Int() == EAknSoftkeyNo)
    {}
}


