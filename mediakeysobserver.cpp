/*Copyright (C) 2020 Allstar Software (Paul Wallace)*/

#include "mediakeysobserver.h"

MediaKeysObserver::MediaKeysObserver(QObject *parent) : QObject(parent)
{
    interfaceSelector = CRemConInterfaceSelector::NewL();
    coreTarget = CRemConCoreApiTarget::NewL(*interfaceSelector, *this);
    interfaceSelector->OpenTargetL();
}

MediaKeysObserver::~MediaKeysObserver()
{
    delete interfaceSelector;
}

void MediaKeysObserver::MrccatoCommand(TRemConCoreApiOperationId operationId,
                                       TRemConCoreApiButtonAction buttonAct)
{
    switch (operationId) {


    case ERemConCoreApiVolumeUp:
        if (buttonAct == ERemConCoreApiButtonClick)
            emit mediaKeyClicked(MediaKeysObserver::EVolIncKey);
        else if (buttonAct == ERemConCoreApiButtonPress)
            emit mediaKeyPressed(MediaKeysObserver::EVolIncKey);
        else if (buttonAct == ERemConCoreApiButtonRelease)
            emit mediaKeyReleased(MediaKeysObserver::EVolIncKey);
        break;

    case ERemConCoreApiVolumeDown:
        if (buttonAct == ERemConCoreApiButtonClick)
            emit mediaKeyClicked(MediaKeysObserver::EVolDecKey);
        else if (buttonAct == ERemConCoreApiButtonPress)
            emit mediaKeyPressed(MediaKeysObserver::EVolDecKey);
        else if (buttonAct == ERemConCoreApiButtonRelease)
            emit mediaKeyReleased(MediaKeysObserver::EVolDecKey);
        break;
    case ERemConCoreApiUp:
        if (buttonAct == ERemConCoreApiButtonClick)
            emit mediaKeyClicked(MediaKeysObserver::EUpKey);
        else if (buttonAct == ERemConCoreApiButtonPress)
            emit mediaKeyPressed(MediaKeysObserver::EUpKey);
        else if (buttonAct == ERemConCoreApiButtonRelease)
            emit mediaKeyReleased(MediaKeysObserver::EUpKey);
        break;
    default:
        break;
    }
}


