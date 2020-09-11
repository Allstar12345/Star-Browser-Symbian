/**
 * Copyright (c) 2012 Nokia Corporation.
 */

#define QT_NO_DEBUG_OUTPUT

#include <QtCore/QDebug>

#include "webinterface.h"
#include "socialconnection.h"

/*!
    \class SocialConnection

    SocialConnection is the base class for different social network plugin
    implementations.

    The methods in this class define a common set of simple requests for all
    supported social networks. While the set of common requests is very limited
    the aim of it is to make it very easy to add some amount of social network
    support to any QML application.

    Derived social network implementations may expose more specific
    functionality to the social network in question.

    Derived implementations must emit request completion signal only after
    setting busy property to false so that it is possible to initiate a new
    request directly from the signal handler. Also all other API properties
    need to be set to the appropriate values beforehand for the sake of being
    correct at the time of executing the signal handler.

    Completion signals must not be emitted directly from the operation start
    method even if the operation result is available immediately! For example
    if deauthenticate() does not require anything else except forgetting the
    credentials locally, invoke the completion signal via the event loop with
    the

        \c {QMetaObject::invokeMethod(this, "deauthenticateCompleted", Qt::QueuedConnection, Q_ARG(bool, true));}

    call instead. Not doing this leads into a confusing program flow in the
    application.
*/

/*!
    \property SocialConnection::webInterface

    This property holds the minimum interface towards the web required by the
    social connection implementations.
 */

/*!
    \property SocialConnection::authenticated

    This property indicates if the social connection is authenticated, usually
    meaning that user has logged in.
 */

/*!
    \property SocialConnection::busy

    This property indicates that the social connection is busy and the currently
    running operation must complete or be cancelled before requesting other
    operations.
    
    \c busy does not indicate a network operation but merely that a
    \c SocialConnection API request has been started and it has not finished
    yet.
 */

/*!
    \property SocialConnection::transmitting

    This property indicates that the social connection is currently doing a
    network operation. This is a useful indicator for deciding when to display
    for example a busy indicator in the UI.
 */

/*!
    \property SocialConnection::name

    This property holds the currently authenticated user's screen name that can
    be used in a UI.
 */

/*!
    \fn virtual bool SocialConnection::authenticate() = 0

    Authenticates user with the social network.

    Returns true if the operation was successfully started and there will be a
    authenticateCompleted(bool success) signal emitted later; otherwise returns
    false.
 */

/*!
    \fn virtual bool SocialConnection::deauthenticate() = 0

    Deauthenticates user with the social network.

    Returns true if the operation was successfully started and there will be a
    deauthenticateCompleted(bool success) signal emitted later; otherwise
    returns false.
 */

/*!
    \fn virtual bool SocialConnection::postMessage(const QVariantMap &message) = 0

    Posts \a message to the social network. Where to post exactly is up to the
    plugin implementation in question, but a rule of thumb is that the "status"
    of the account is updated.

    Returns true if the operation was successfully started and there will be a
    postMessageCompleted(bool success) signal emitted later; otherwise returns
    false.

    The members/keys of the message object are:
    \list
        \li "text" (mandatory) : textual message to post
        \li "url" (optional) : attachment URL, for example a local picture file
        \li "description" (optional) : attachment URL description
    \endlist

    See derived implementation documentation for further description.
 */

/*!
    \fn virtual bool SocialConnection::retrieveMessageCount() = 0

    Retrieves the amount of retrievable messages from the social network.

    Returns true if the operation was successfully started and there will be a
    retrieveMessageCountCompleted(bool success, int count) signal emitted later;
    otherwise returns false.
 */

/*!
    \fn virtual bool SocialConnection::retrieveMessages(const QString &from, const QString &to, int max) = 0

    Retrieves \a max (or less of not enough available) messages from the
    social network in the range between \a from and \a to.
    Depending on the derived implementation \a from and \a to can be
    timestamps or other sequential message identifiers.

    Empty \a from is interpreted as a minimum and \a to as a maximum in the
    sense that the range is maximized.

    Returns true if the operation was successfully started and there will be a
    retrieveMessagesCompleted(bool success, const QVariantList &messages) signal
    emitted later; otherwise returns false.

    See derived implementation documentation for further description.
 */

/*!
    \fn virtual void SocialConnection::cancel() = 0

    Attempts to cancel the currently active request. The result of the operation
    success, failure (one reason of which may be the cancellation) is available
    in the completion signal of the operation in question.
 */

/*!
    \fn virtual bool SocialConnection::storeCredentials() = 0

    Stores authentication credentials to persistent storage. Returns true if the
    credentials were successfully stored; otherwise returns false.
 */

/*!
    \fn virtual bool SocialConnection::restoreCredentials() = 0

    Restores authentication credentials from persistent storage and sets
    \c authenticated to the assumed authentication status. Returns true if
    the credentials were successfully restored; otherwise returns false.
 */

/*!
    \fn virtual bool SocialConnection::removeCredentials() = 0

    Removes stored authentication credentials from persistent storage but does
    not affect current state of \c authenticated. Returns true if the
    credentials were successfully removed; otherwise returns false.
    
    Other possibly exposed credential properties in derived implementations are
    not affected.
 */

/*!
    \fn void SocialConnection::authenticateCompleted(bool success)

    Authentication operation has been completed. Success of the operation is
    indicated by \a success. The value of \c authenticated has been set to
    indicate the authentication status.
    
    Other possibly exposed credential properties in derived implementations have
    been set correctly.
 */

/*!
    \fn void SocialConnection::deauthenticateCompleted(bool success)

    Deauthentication operation has been completed. Success of the operation is
    indicated by \a success. The value of \c authenticated has been set to
    indicate the authentication status.
    
    Other possibly exposed credential properties in derived implementations have
    been cleared.
 */

/*!
    \fn void SocialConnection::postMessageCompleted(bool success)

    Message posting operation has been completed. Success of the operation is
    indicated by \a success.
    
    If operation failed because of bad authentication credentials,
    \c authenticated has been set to false but other possibly exposed 
    credential properties in derived implementations have been kept intact.
 */

/*!
    \fn void SocialConnection::retrieveMessageCountCompleted(bool success, int count)

    Message count retrieving operation has been completed. Success of the
    operation is indicated by \a success. If the operation was completed
    successfully then \a count indicates the amount of retrievable
    messages or -1 if the amount of retrievable messages could not be
    determined.
    
    If operation failed because of bad authentication credentials,
    \c authenticated has been set to false but other possibly exposed 
    credential properties in derived implementations have been kept intact.
 */

/*!
    \fn virtual void SocialConnection::retrieveMessagesCompleted(bool success, const QVariantList &messages) = 0

    Retrieve messages operation has been completed. Success of the operation is
    indicated by \a success. If the operation was completed successfully then
    \a messages contains an array of message objects.

    The members/keys of the message object are:
    \list
        \li "id" (mandatory) : message identifier
        \li "text" (mandatory) : message text
        \li "url" (optional) : attachment URL
        \li "description" (optional) : attachment URL description
        \li "time" (optional) : UNIX timestamp
    \endlist
    
    If operation failed because of bad authentication credentials,
    \c authenticated has been set to false but other possibly exposed 
    credential properties in derived implementations have been kept intact.
 */

SocialConnection::SocialConnection(QObject *parent) :
    QObject(parent),
    m_webInterface(0),
    m_busy(false),
    m_transmitting(false),
    m_authenticated(false)
{
    qDebug() << "SocialConnection::SocialConnection";
}
    
SocialConnection::~SocialConnection()
{
    qDebug() << "SocialConnection::~SocialConnection";
}

QObject* SocialConnection::webInterface() const
{
    qDebug() << "SocialConnection::webInterface" << m_webInterface;
    
    return qobject_cast<QObject*>(m_webInterface);
}

void SocialConnection::setWebInterface(QObject *webInterface)
{
    qDebug() << "SocialConnection::setWebInterface" << webInterface;
    
    WebInterface *newInterface = qobject_cast<WebInterface*>(webInterface);
    
    if (newInterface != m_webInterface) {
        if (m_webInterface) {
            disconnect(m_webInterface, SIGNAL(urlChanged(const QUrl &)),
                       this, SLOT(onUrlChanged(const QUrl &)));
        }
        
        m_webInterface = newInterface;
        
        if (m_webInterface) {
            connect(m_webInterface, SIGNAL(urlChanged(const QUrl &)),
                    this, SLOT(onUrlChanged(const QUrl &)));
        }

        emit webInterfaceChanged(m_webInterface ? webInterface : 0);
    }
}

bool SocialConnection::authenticated() const
{
    qDebug() << "SocialConnection::authenticated" << m_authenticated;
    
    return m_authenticated;
}

void SocialConnection::setAuthenticated(bool authenticated)
{
    qDebug() << "SocialConnection::setAuthenticated" << authenticated;
    
    if (authenticated != m_authenticated) {
        m_authenticated = authenticated;
        emit authenticatedChanged(authenticated);
    }
}

bool SocialConnection::busy() const
{
    qDebug() << "SocialConnection::busy" << m_busy;
    
    return m_busy;
}

bool SocialConnection::transmitting() const
{
    qDebug() << "SocialConnection::transmitting" << m_transmitting;
    
    return m_transmitting;
}

QString SocialConnection::name() const
{
    qDebug() << "SocialConnection::name" << m_name;
    
    return m_name;
}

void SocialConnection::setBusy(bool busy)
{
    qDebug() << "SocialConnection::setBusy" << busy;
    
    if (busy != m_busy) {
        m_busy = busy;
        emit busyChanged(busy);
    }
}

void SocialConnection::setTransmitting(bool transmitting)
{
    qDebug() << "SocialConnection::setTransmitting" << transmitting;
    
    if (transmitting != m_transmitting) {
        m_transmitting = transmitting;
        emit transmittingChanged(transmitting);
    }
}

void SocialConnection::setName(const QString &name)
{
    qDebug() << "SocialConnection::setName" << name;
    
    if (name != m_name) {
        m_name = name;
        emit nameChanged(name);
    }
}

void SocialConnection::onUrlChanged(const QUrl &url)
{
    qDebug() << "SocialConnection::urlChanged" << url;
}
