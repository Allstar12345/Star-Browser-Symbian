#ifndef FACEBOOKDATAMANAGER_H
#define FACEBOOKDATAMANAGER_H

#include <QObject>
#include <QVariant>
#include <QScriptValue>

class FacebookDataManager : public QObject
{
    Q_OBJECT

public:

    explicit FacebookDataManager(QObject *parent = 0);

    // Methods
    void handleRetrievedMessages(const QByteArray &result);
    void handleRetrieveMessageCount(const QByteArray &result);
    QString handleScreenName(const QByteArray &result);

    QVariantList posts() const;
    int postCount() const;

private:

    void addValue(const QScriptValue &value);

private:

    QString m_lastError;
    QVariantList m_lastPosts;

    int m_postCount;
};

#endif // FACEBOOKDATAMANAGER_H
