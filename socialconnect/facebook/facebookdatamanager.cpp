#include "facebookdatamanager.h"
#include <QScriptEngine>
#include <QScriptValueIterator>
#include <QDebug>

// Constants
namespace {
    const QString PostIdStr("post_id");
    const QString MessageStr("message");
    const QString CreatedTimeStr("created_time");
    const QString TimeStr("time");
    const QString IdStr("id");
    const QString TextStr("text");
    const QString UrlStr("url");
    const QString DescriptionStr("description");
    const QString AttachmentStr("attachment");
    const QString HrefStr("href");
}

/*!
  \internal

  Constructor.
*/
FacebookDataManager::FacebookDataManager(QObject *parent) :
    QObject(parent)
{
}

/*!
  \internal

  Parses retrieved messages from JSON string.
*/
void FacebookDataManager::handleRetrievedMessages(const QByteArray &result)
{
    // Evaluate string to JSON object.
    QScriptEngine engine;
    QScriptValue value = engine.evaluate("(" + QString(result) + ")");

    m_lastPosts.clear();

    if (value.property("data").isArray()) {
        QScriptValueIterator it(value.property("data"));

        while (it.hasNext()) {
            it.next();
            addValue(it.value());
        }
    }
}

/*!
  \internal

  Parses retrieved message count from JSON string.
*/
void FacebookDataManager::handleRetrieveMessageCount(const QByteArray &result)
{
    // Evaluate string to JSON object.
    QScriptEngine engine;
    QScriptValue value = engine.evaluate("(" + QString(result) + ")");

    int count = 0;

    if (value.property("data").isArray()) {
        QScriptValueIterator it(value.property("data"));

        while (it.hasNext()) {
            it.next();
            count++;
        }
    }

    m_postCount = count;
}

/*!
  \internal

  Parses screen name from JSON string.
*/
QString FacebookDataManager::handleScreenName(const QByteArray &result)
{
    QScriptEngine engine;
    QScriptValue value = engine.evaluate("(" + QString(result) + ")");

    return value.property("name").toString();
}

/*!
  \internal

  Helper function for parsing information from a message object.
*/
void FacebookDataManager::addValue(const QScriptValue &value)
{
    QVariant message = value.property(MessageStr).toVariant();
    QVariant postId = value.property(PostIdStr).toVariant();
    QVariant created = value.property(CreatedTimeStr).toVariant();
    QVariant url = value.property(AttachmentStr).property(HrefStr).toVariant();
    QVariant description = value.property(AttachmentStr).property(DescriptionStr).toVariant();

    // Add only valid entries. All mandatory properties must be found.
    if (message.isValid() && postId.isValid() && created.isValid()) {

        // Insert all the needed data to last posts.
        QVariantMap messageMap;
        messageMap.insert(TextStr, message);
        messageMap.insert(IdStr, postId);
        messageMap.insert(UrlStr, url);
        messageMap.insert(DescriptionStr, description);
        messageMap.insert(TimeStr, created);
        m_lastPosts.append(messageMap);

        qDebug() << "Status:"  << message.toString()
                 << "Post-id:" << postId.toString()
                 << "Created:" << created.toInt()
                 << "Url:" << url.toString()
                 << "Description:" << description.toString();
    }
}

/*!
  \internal

  Returns posts.
*/
QVariantList FacebookDataManager::posts() const
{
    return m_lastPosts;
}

/*!
  \internal

  Returns post count.
*/
int FacebookDataManager::postCount() const
{
    return m_postCount;
}

