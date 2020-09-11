/**
 * Copyright (c) 2012 Nokia Corporation.
 */

#include "facebookrequest.h"
#include "facebookreply.h"
#include <QStringList>
#include <QNetworkAccessManager>
#include <QNetworkReply>
#include <QNetworkRequest>
#include <QScriptEngine>
#include <QDebug>
#include <QFile>

// Constants
namespace {
    const QString Image("picture");
    const QString Video("video");
    const QString GraphURL("https://graph.facebook/v2.1/");
    const QString Boundary("3i2ndDfv2rTHiSisAbouNdArYfORhtTPEefj3q2f");
    const QString EndLine("\r\n--%1\r\n");
    const QString ContentTypeFormat("Content-Type: %1/%2\r\n\r\n");
    const QString ContentDispositionFilename("Content-Disposition: form-data; filename=\"%1\"\r\n");
    const QString ContentDispositionOther("Content-Disposition: form-data; name=\"%@\"\r\n\r\n");
}

// Inline utility functions definitions.
namespace Util {

    /*!
     \internal

     Helper function for parsing postable data from \a parameters.
    */
    inline QVariantMap parseData(const QVariantMap &parameters)
    {
        QVariantMap data;
        QMapIterator<QString, QVariant> iter(parameters);
        while (iter.hasNext()) {
            iter.next();
            if (iter.key().compare(Image) == 0) {
                data.insert(iter.key(), iter.value());
                qDebug() << "Found image. Url:" << iter.value().toUrl();
            }
            else if (iter.key().compare(Video) == 0) {
                data.insert(iter.key(), iter.value());
                qDebug() << "Found video. Url:" << iter.value().toUrl();
            }
        }

        return data;
    }

    /*!
     \internal

      Helper function for parsing OAuthException error codes from JSON.
    */
    inline FacebookReply::OAuthError parseOAuthError(const QByteArray &result)
    {
        // Evaluate string to JSON object.
        QScriptEngine engine;
        QScriptValue value = engine.evaluate("(" + QString(result) + ")");

        return (FacebookReply::OAuthError)value.property("error").property("code").toInt32();
    }


    /*!
     \internal

      Helper function for reading file raw data to array.
    */
    inline QByteArray handleFile(const QUrl &fileUrl)
    {
        QFile file(fileUrl.toLocalFile());
        if (!file.exists()) {
            qWarning() << "File not found:" << fileUrl.toLocalFile();
            return QByteArray();
        }
        if (!file.open(QIODevice::ReadOnly)) {
            qWarning() << "Cannot open file:" << fileUrl.toLocalFile();
            return QByteArray();
        }

        return file.readAll();
    }


    /*!
     \internal

      Helper function for constructing an URL.
    */
    inline QUrl generateUrl(const QString &graphPath, const QVariantMap &parameters)
    {
        QUrl url(GraphURL);
        url.setPath(graphPath);

        QMapIterator<QString, QVariant> i(parameters);

        while (i.hasNext()) {
            i.next();

            if (i.key().compare(Image) != 0 &&
                i.key().compare(Video) != 0) {
                url.addQueryItem(i.key(), i.value().toString());
            }
        }
        return url;
    }


    /*!
     \internal

     Helper function for generating body for POST request.
    */
    inline QByteArray generateBody(const QVariantMap &parameters)
    {
        QVariantMap data(parseData(parameters));
        QByteArray body;
        body.append(QString("--%1\r\n").arg(Boundary).toAscii());
        const QByteArray endLine(QString(EndLine).arg(Boundary).toAscii());

        QMapIterator<QString, QVariant> iter(data);

        while (iter.hasNext()) {
            iter.next();
            QByteArray bytes;

            if (iter.key().compare(Image) == 0) {
                QUrl url(iter.value().toString());

                if (url.scheme().compare("file") == 0) {
                    bytes = Util::handleFile(url);

                    if (!bytes.isEmpty()) {
                        // Strip file type from file name for Content-Type part of the body.
                        QString fileType = url.path().section(".", -1);
                        qDebug() << "Filetype:" << fileType;
                        body.append(QString(ContentDispositionFilename).arg(iter.value().toString()));
                        body.append(QString(ContentTypeFormat).arg("image").arg(fileType));
                        body.append(bytes);
                    }
                }
            }
            else if (iter.key().compare(Video) == 0) {
                QUrl url(iter.value().toString());

                if (url.scheme().compare("file") == 0) {
                    bytes = Util::handleFile(url);

                    if (!bytes.isEmpty()) {
                        body.append(QString(ContentDispositionFilename).arg(iter.value().toString()));
                        body.append(QString(ContentTypeFormat).arg(parameters.value("contentType").toString()));
                        body.append(bytes);
                    }
                }
            }

            body.append(endLine);
        }

        return body;
    }
} // namespace Util


/*!
  \class FacebookRequest
  \brief The FacebookRequest class encapsulates a Facebook request.
         Do not use this class directly. Use FacebookConnection request
         methods instead.
*/


/*!
  \internal

  Constructor.
*/
FacebookRequest::FacebookRequest(const QVariant &requestId,
                                 QNetworkAccessManager *networkAccess,
                                 const QVariantMap &parameters,
                                 const FacebookConnection::HTTPMethod method,
                                 const QString &graphPath,
                                 QObject *parent)
    : QObject(parent),
      m_networkAccess(networkAccess),
      m_ongoingRequest(0),
      m_requestId(requestId),
      m_parameters(parameters),
      m_method(method),
      m_graphPath(graphPath)
{
    connect(m_networkAccess, SIGNAL(finished(QNetworkReply*)), this, SLOT(onFinished(QNetworkReply*)));
}

/*!
  \internal

  Destructor.
*/
FacebookRequest::~FacebookRequest()
{
    cancelRequest();
}

/*!
  \internal

  Executes the request.
*/
bool FacebookRequest::executeRequest()
{
    if (m_graphPath.isEmpty()) {
        FacebookReply *facebookReply =
                new FacebookReply(QByteArray(), true, FacebookReply::OAuthGeneralError,
                                  "Facebook error. Invalid graph path.", this);
        emit requestFinished(this, facebookReply);
        return false;
    }

    bool ret = true;

    QNetworkRequest request(Util::generateUrl(m_graphPath, m_parameters));
    qDebug() << "FacebookRequest::executeRequest - URL:" << request.url();

    switch (m_method) {
    case FacebookConnection::HTTPPost:
        request.setRawHeader("Content-Type",
                             QString("multipart/form-data; boundary=%1")
                             .arg(Boundary).toAscii());
        m_ongoingRequest = m_networkAccess->post(request, Util::generateBody(m_parameters));
        break;
    case FacebookConnection::HTTPGet:
        m_ongoingRequest = m_networkAccess->get(request);
        break;
    case FacebookConnection::HTTPDelete:
        m_ongoingRequest = m_networkAccess->deleteResource(request);
        break;
    default: {
        FacebookReply *facebookReply =
                new FacebookReply(QByteArray(), true,
                                  FacebookReply::OAuthGeneralError,
                                  "Facebook error. Invalid request method.",
                                  this);
        emit requestFinished(this, facebookReply);
        ret = false;
    }
    }

    return ret;
}

/*!
  \internal

  Cancels the ongoing request.
*/
void FacebookRequest::cancelRequest()
{
    if (m_ongoingRequest.isNull()) {
        return;
    }

    if (m_ongoingRequest->isRunning()) {
        m_ongoingRequest->abort();
    }
}

/*!
  \internal

  Returns the request id.
*/
QVariant FacebookRequest::requestId() const
{
    return m_requestId;
}

/*!
  \internal

  Handles the response for the request.
*/
void FacebookRequest::onFinished(QNetworkReply *reply)
{
    const QByteArray result = reply->readAll();

    FacebookReply::OAuthError oauthError = FacebookReply::OAuthNoError;

    // QNetworkReply returns always QNetworkReply::UnknownContentError on
    // OAuthException. Need to parse the OAuthException error code from JSON.
    if (reply->error() != QNetworkReply::NoError) {
        oauthError = Util::parseOAuthError(result);
    }

    FacebookReply *facebookReply =
            new FacebookReply(result,
                              reply->error(),
                              oauthError,
                              reply->errorString(),
                              this);
    qDebug() << "Result: " << facebookReply->responseData();
    emit requestFinished(this, facebookReply);
}


