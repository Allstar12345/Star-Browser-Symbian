/*Copyright (C) 2020 Allstar Software (Paul Wallace)*/

#ifndef MEDIAKEYSOBSERVER_H
 #define MEDIAKEYSOBSERVER_H

 #include <QObject>

#include <remconcoreapitargetobserver.h>    // link against RemConCoreApi.lib
#include <remconcoreapitarget.h>            // and
#include <remconinterfaceselector.h>        // RemConInterfaceBase.lib+

 class MediaKeysObserver : public QObject, public MRemConCoreApiTargetObserver

 {
     Q_OBJECT
     Q_ENUMS(MediaKey)

 public:
     enum MediaKey {
         EVolIncKey,
         EVolDecKey,
         EUpKey
     };

     MediaKeysObserver(QObject *parent = 0);
     virtual ~MediaKeysObserver();

 protected:
     void MrccatoCommand(TRemConCoreApiOperationId aOperationId, TRemConCoreApiButtonAction aButtonAct);

 signals:
     void mediaKeyClicked(int key);
     void mediaKeyPressed(int key);
     void mediaKeyReleased(int key);

 private:
     CRemConInterfaceSelector *interfaceSelector;
     CRemConCoreApiTarget *coreTarget;
 };

 #endif // MEDIAKEYSOBSERVER_H
