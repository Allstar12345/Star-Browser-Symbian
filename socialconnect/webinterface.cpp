/**
 * Copyright (c) 2012 Nokia Corporation.
 */

#include "webinterface.h"

/*!
    \class WebInterface

    WebInterface is the minimum interface required by the SocialConnection
    derived social network implementations.

    The purpose of this class is to abstract the dependencies of the plugins so
    that the social network components do not get tightly interwined with for
    example the QML WebView in case users of the SocialConnect module wish to
    use some other element in place of it.
 */
 
/*!
    \property WebInterface::url

    This property is the web URL access point for \c SocialConnection derived
    plugins. The main purpose is to enable \c WebView based authentication
    flows via setting the user authentication input URL to this property and
    then waiting for the \c WebView or such to proceed to a another URL with the
    authentication credentials as URL parameters.
    
    Application may not have a web view instantiated at all times and also might
    want to delete instances that are not needed. Therefore the use of this
    property must be surrounded by the appropriate use of \c active property.
 */
 
/*!
    \property WebInterface::active

    This property is set to true for the time the plugin using this 
    \c WebInterface instance requires a \c WebView or similar to be
    instantiated and reserved for the plugin's use. Also this property must be
    set to false when the plugin does not need the access to \c url property
    anymore so that the application does not have to keep an unused \c WebView
    or such around for no reason.
 */

WebInterface::WebInterface(QObject *parent) :
    QObject(parent),
    m_active(false)
{
}

WebInterface::~WebInterface()
{
}

void WebInterface::setActive(bool active)
{
    if (active != m_active) {
        m_active = active;
        emit activeChanged(active);
    }
}

bool WebInterface::active() const
{
    return m_active;
}

QUrl WebInterface::url() const
{
    return m_url;
}

void WebInterface::setUrl(const QUrl &url)
{
    if (url != m_url) {
        m_url = url;
        emit urlChanged(url);
    }
}
