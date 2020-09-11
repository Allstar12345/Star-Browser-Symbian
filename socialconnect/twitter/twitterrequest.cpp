/**
 * Copyright (c) 2012 Nokia Corporation.
 * All rights reserved.
 *
 * For the applicable distribution terms see the license text file included in
 * the distribution.
 */
 
#include "twitterrequest.h"

#include "twitterconstants.h"
#include <QDateTime>
#include <QDebug>
#include <QFile>
#include <QFileInfo>
#include <QStringList>

// A Helper function to generate a correct kind of request for image uploads.
//
// %1 Status update text.
// %2 Uploaded image file name.
// %3 Image's file suffix (e.g. jpg).
// %4 Image data in binary format.
QByteArray createImageUploadContent(const QString & bound,
                                    const QString &text,
                                    const QString &fileName,
                                    const QString &fileSuffix,
                                    const QByteArray &fileData)
{
    QByteArray content;

    // Add the status update message to the first HTTP (multi)part.
    content = "--" + bound.toAscii() + "\r\n";
    content += "Content-Disposition: form-data; name=\"status\"\r\n";
    content += "Content-Transfer-Encoding: binary\r\n";
    content += "Content-Type: text/plain; charset=utf-8\r\n";
    content += "\r\n" + text.toUtf8() + "\r\n";
    content += "\r\n";

    // And add the file content (image) to the first HTTP (multi)part.
    content += "--" + bound.toAscii() + "\r\n";
    content += "Content-Disposition: form-data; name=\"media[]\"; filename=\""
            + fileName.toAscii() + "\"\r\n";
    content += "Content-Transfer-Encoding: binary\r\n";
    content += "Content-Type: image/" + fileSuffix.toLower() + "\r\n";
    content += "\r\n" + fileData + "\r\n";
    content += "\r\n";
    content += "--" + bound.toAscii() + "--";

    return content;
}

TwitterRequest::TwitterRequest(QObject *parent) :
    QObject(parent)
{

}

void TwitterRequest::setConsumerKey(const QString &consumerKey)
{
    m_consumerKey = consumerKey;
}

void TwitterRequest::setConsumerSecret(const QString &consumerSecret)
{
    m_consumerSecret = consumerSecret;
}

void TwitterRequest::setAccessToken(const QString &accessToken)
{
    m_accessToken = accessToken;
}

void TwitterRequest::setAccessTokenSecret(const QString &accessTokenSecret)
{
    m_accessTokenSecret = accessTokenSecret;
}

QNetworkRequest TwitterRequest::createRequestTokenRequest(const QString &callbackUrl)
{
    QVariantMap params;
    params.insert(OAUTH_CALLBACK, callbackUrl);
    QNetworkRequest req = createRequest(QUrl(REQUEST_TOKEN_URL), HTTP_POST, params);
    req.setRawHeader(HTTP_HEADER_HOST, HTTP_HEADER_VALUE_TWITTER_API);

    return req;
}

QNetworkRequest TwitterRequest::createAccessTokenRequest(const QString &verifier)
{
    QVariantMap params;
    params.insert(OAUTH_VERIFIER, verifier);
    QNetworkRequest req = createRequest(QUrl(ACCESS_TOKEN_URL), HTTP_POST, params);
    req.setRawHeader(HTTP_HEADER_HOST, HTTP_HEADER_VALUE_TWITTER_API);

    return req;
}

QNetworkRequest TwitterRequest::createRetrieveMessageCountRequest()
{
    QNetworkRequest req = createRequest(
                QUrl(ACCOUNT_TOTALS_URL), HTTP_GET);
    req.setRawHeader(HTTP_HEADER_HOST, HTTP_HEADER_VALUE_TWITTER_API);

    return req;
}

QNetworkRequest TwitterRequest::createRetrieveMessagesRequest(
        const QString &name, const QString &from, const QString &to, int count)
{
    QVariantMap params;

    if (!from.isEmpty()) {
        params.insert(TWITTER_SINCE_ID, from);
    }

    if (!to.isEmpty()) {
        params.insert(TWITTER_MAX_ID, to);
    }
    params.insert(TWITTER_SCREEN_NAME, name);
    params.insert(TWITTER_MESSAGE_COUNT, count);

    // Create the request. The URL parameters have to be part of the signature.
    QUrl url(USER_TIMELINE_URL);
    QNetworkRequest req = createRequest(url, HTTP_GET, params);

    if (!from.isEmpty()) {
        url.addEncodedQueryItem(TWITTER_SINCE_ID, from.toAscii());
    }

    if (!to.isEmpty()) {
        url.addEncodedQueryItem(TWITTER_MAX_ID, to.toAscii());
    }
    url.addEncodedQueryItem(TWITTER_SCREEN_NAME, name.toUtf8());
    url.addEncodedQueryItem(TWITTER_MESSAGE_COUNT, QByteArray::number(count));

    req.setUrl(QUrl(url));
    req.setRawHeader(HTTP_HEADER_HOST, HTTP_HEADER_VALUE_TWITTER_API);

    return req;
}

QNetworkRequest TwitterRequest::createPostMessageRequest(const QString &text,
                                                         const QUrl &fileUrl,
                                                         QByteArray *retContent)
{
    QByteArray content;
    QNetworkRequest req;

    if (!fileUrl.isEmpty()) {
        // Status update with a picture included.
        QString file = fileUrl.toLocalFile();
        QFileInfo fileInfo(file);
        QByteArray fileData = handleFile(file);
        const QString bound = "WaB33xxDoEd";    // Just some random string.

        // Create the request body content with an internal helper function.
        content = createImageUploadContent(
                    bound, text, fileInfo.fileName(), fileInfo.suffix(), fileData);

        // Create the request with the OAuth Authorization. The image POSTs have
        // only the oauth_* -fields in the signature.
        req = createRequest(QUrl(UPDATE_WITH_MEDIA_URL), HTTP_POST);
        req.setRawHeader(HTTP_HEADER_HOST, HTTP_HEADER_VALUE_TWITTER_UPLOAD);
        req.setRawHeader(HTTP_HEADER_CONTENT_TYPE,
                         HTTP_HEADER_VALUE_FORM_DATA_BOUNDARY + bound.toAscii());
        req.setRawHeader(HTTP_HEADER_CONTENT_LENGTH,
                         QString::number(content.length()).toAscii());
    }
    else {
        // Normal status update (without any files).
        QVariantMap params;
        params.insert(TWITTER_STATUS_UPDATE, text);

        QByteArray encodedMsg = QUrl::toPercentEncoding(
                    text.normalized(QString::NormalizationForm_C));
        content = QByteArray(TWITTER_STATUS_UPDATE).append("=").append(encodedMsg);

        // Create the request. The message has to be part of the signature.
        req = createRequest(QUrl(UPDATE_URL), HTTP_POST, params);
        req.setRawHeader(HTTP_HEADER_HOST, HTTP_HEADER_VALUE_TWITTER_API);
        req.setRawHeader(HTTP_HEADER_CONTENT_TYPE, HTTP_HEADER_VALUE_FORM_URLENCODED);
    }

    *retContent = content;
    return req;
}

// Method for adding raw file data for the requests.
QByteArray TwitterRequest::handleFile(const QString &filePath)
{
    QFile file(filePath);

    if (!file.exists()) {
        qWarning() << "File not found:" << filePath;
        return QByteArray();
    }

    if (!file.open(QIODevice::ReadOnly)) {
        qWarning() << "Cannot open file:" << filePath;
        return QByteArray();
    }

    return file.readAll();
}

QNetworkRequest TwitterRequest::createRequest(const QUrl& requestUrl,
                                              const QString httpMethod,
                                              QVariantMap params)
{
    QMap<QString, QString> requestHeaders;
    QVariantMap::const_iterator i = params.constBegin();

    while (i != params.constEnd()) {
        requestHeaders.insert(i.key(), QUrl::toPercentEncoding(i.value().toString()));
        ++i;
    }

    if (!m_accessToken.isEmpty()) {
        requestHeaders.insert(OAUTH_TOKEN, QUrl::toPercentEncoding(m_accessToken));
    }
    requestHeaders.insert(OAUTH_CONSUMER_KEY, QUrl::toPercentEncoding(m_consumerKey));
    requestHeaders.insert(OAUTH_NONCE, QUrl::toPercentEncoding(generateNonce()));
    requestHeaders.insert(OAUTH_SIGNATURE_METHOD, QUrl::toPercentEncoding("HMAC-SHA1"));
    requestHeaders.insert(OAUTH_TIMESTAMP, QUrl::toPercentEncoding(currentTime()));
    requestHeaders.insert(OAUTH_VERSION, QUrl::toPercentEncoding("1.0"));

    // Create the base signature string and sign it with the secrets.
    QString signatureBaseString = createSignatureBaseString(
                requestUrl.toString(), requestHeaders, httpMethod);
    QString signature = signRequest(signatureBaseString,
                                    QString(m_consumerSecret) + '&' + m_accessTokenSecret);
    requestHeaders.insert(OAUTH_SIGNATURE, QUrl::toPercentEncoding(signature));

    // Generate authentication headers for the request.
    QString authHeader = generateAuthHeader(requestHeaders);
    QByteArray authHeaderByteArray = authHeader.toUtf8();

    QNetworkRequest request(requestUrl);
    request.setRawHeader(HTTP_HEADER_AUTHORIZATION, authHeaderByteArray);

    return request;
}

QString TwitterRequest::generateAuthHeader(const QMap<QString, QString> &requestHeaders)
{
    QString authHeader = "OAuth ";

    if (!requestHeaders.value(OAUTH_CALLBACK).isEmpty()) {
        authHeader += QString("%1=\"%2\", ").arg(OAUTH_CALLBACK).arg(requestHeaders.value(OAUTH_CALLBACK));
    }

    if (!requestHeaders.value(OAUTH_VERIFIER).isEmpty()) {
        authHeader += QString("%1=\"%2\", ").arg(OAUTH_VERIFIER).arg(requestHeaders.value(OAUTH_VERIFIER));
    }

    if (!m_accessToken.isEmpty()) {
        authHeader += QString("%1=\"%2\", ").arg(OAUTH_TOKEN).arg(requestHeaders.value(OAUTH_TOKEN));
    }

    authHeader += QString("%1=\"%2\", ").arg(OAUTH_CONSUMER_KEY).arg(requestHeaders.value(OAUTH_CONSUMER_KEY));
    authHeader += QString("%1=\"%2\", ").arg(OAUTH_NONCE).arg(requestHeaders.value(OAUTH_NONCE));
    authHeader += QString("%1=\"%2\", ").arg(OAUTH_SIGNATURE_METHOD).arg(requestHeaders.value(OAUTH_SIGNATURE_METHOD));
    authHeader += QString("%1=\"%2\", ").arg(OAUTH_TIMESTAMP).arg(requestHeaders.value(OAUTH_TIMESTAMP));
    authHeader += QString("%1=\"%2\", ").arg(OAUTH_VERSION).arg(requestHeaders.value(OAUTH_VERSION));
    authHeader += QString("%1=\"%2\"").arg(OAUTH_SIGNATURE).arg(requestHeaders.value(OAUTH_SIGNATURE));

    qDebug() << "Generated authHeader: " << authHeader;
    return authHeader;
}

// Methods required for the requests signing process.
QString TwitterRequest::createSignatureBaseString(
        QString url,
        QMap<QString, QString> requestTokens,
        const QString httpMethod) const
{
    // Pseudocode for signing
    //
    // httpMethod + "&" +
    // url_encode(  base_uri ) + "&" +
    // sorted_query_params.each  { | k, v |
    //    url_encode ( k ) + "%3D" +
    //    url_encode ( v )
    // }.join("%26")

    QString signatureBaseString =  httpMethod +
            "&" +
            QUrl::toPercentEncoding(url) +
            "&";

    // Parameters must be sorted in lexicographical order
    // QMap stores item automatically in correct order
    QList<QString> keys = requestTokens.keys();
    QStringList encodedKeyValuePairs;

    foreach (QString key, keys) {
        encodedKeyValuePairs += key + "=" + requestTokens.value(key);
    }
    QString prefix = QUrl::toPercentEncoding(encodedKeyValuePairs.join("&"), "", "%");
    signatureBaseString += prefix;
    qDebug() << "Generated signature base string: " << signatureBaseString;

    return signatureBaseString;
}

QString TwitterRequest::signRequest(QString signatureBaseString, QString secret) const
{
    QByteArray hash = hmac(secret.toUtf8(),
                           signatureBaseString.toAscii(),
                           QCryptographicHash::Sha1);
    return hash.toBase64();
}

QByteArray TwitterRequest::hmac(QByteArray secret, QByteArray data,
                               QCryptographicHash::Algorithm algorithm) const
{
    const int IPAD = 0x36;
    const int OPAD = 0x5c;
    const int BLOCK_SIZE = 64;
    QByteArray key = secret;

    if (secret.length() > BLOCK_SIZE) {
        key = QCryptographicHash::hash(secret, algorithm);
    }
    
    QByteArray key_ipad = key.leftJustified(BLOCK_SIZE, '\0');
    QByteArray key_opad = key.leftJustified(BLOCK_SIZE, '\0');

    for (int i = 0; i < BLOCK_SIZE; ++i) {
        key_ipad[i] = key_ipad[i] ^ IPAD;
        key_opad[i] = key_opad[i] ^ OPAD;
    }
    
    QCryptographicHash hash(algorithm);
    hash.addData(key_ipad);
    hash.addData(data);
    QByteArray innerResult = hash.result();
    hash.reset();
    hash.addData(key_opad);
    hash.addData(innerResult);

    return hash.result();
}

QByteArray TwitterRequest::currentTime() const
{
    return QString::number(QDateTime::currentDateTime().toTime_t()).toUtf8();
}

QByteArray TwitterRequest::generateNonce() const
{
    QByteArray nonce = currentTime().append(QString::number(qrand())).append(currentTime()).append(QString::number(qrand()));
    return nonce;
}
