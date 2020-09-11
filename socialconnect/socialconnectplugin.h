/**
 * Copyright (c) 2012 Nokia Corporation.
 */

#ifndef SOCIALCONNECTPLUGIN_H
#define SOCIALCONNECTPLUGIN_H

#include <QDeclarativeExtensionPlugin>

class SocialConnectPlugin : public QDeclarativeExtensionPlugin
{
    Q_OBJECT

public:

    void registerTypes(const char *uri);
};

#endif // SOCIALCONNECTPLUGIN_H
