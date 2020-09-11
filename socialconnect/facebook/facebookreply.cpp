/**
 * Copyright (c) 2012 Nokia Corporation.
 */

#include "facebookreply.h"

#include <QDebug>
#include <QStringList>

/*!
  \class FacebookReply
  \brief The FacebookReply class encapsulates Facebook request completion
         and request error data.
*/

/*!
  \internal

  Constructor.
*/
FacebookReply::FacebookReply(const QByteArray &responseData,
                             const bool error,
                             const OAuthError errorCode,
                             const QString &errorString,
                             QObject *parent)
    : QObject(parent),
      m_responseData(responseData),
      m_error(error),
      m_errorCode(errorCode),
      m_errorString(errorString)
{
}

/*!
  \internal

  Returns response JSON data.
*/
QByteArray FacebookReply::responseData() const
{
    return m_responseData;
}

/*!
  \internal

  Returns true if an error was occurred, otherwise false.
*/
bool FacebookReply::error() const
{
    return m_error;
}

/*!
  \internal

  Returns OAuthException error code.
*/
FacebookReply::OAuthError FacebookReply::errorCode() const
{
    return m_errorCode;
}

/*!
  \internal

  Returns an error string if an error was occurred, otherwise returns
  an empty string.
*/
QString FacebookReply::errorString() const
{
    return m_errorString;
}
