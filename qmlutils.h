/*Copyright (C) 2020 Allstar Software (Paul Wallace)*/

#ifndef QMLUTILS_H
#define QMLUTILS_H

#include <QtCore/QObject>
#include <QtGui/QApplication>
#include <QDesktopServices>
#include <QUrl>
#include <CAknFileSelectionDialog.h>
#include <akndiscreetpopup.h>
#include <QSystemScreenSaver>
#include <QPixmap>
#include <QDir>
#include <QDeclarativeView>


class QClipboard;
class QDeclarativeItem;
class QDeclarativeView;

class QMLUtils : public QObject
{
    Q_OBJECT
public:
    explicit QMLUtils(QDeclarativeView *view, QObject *parent = 0);
    Q_INVOKABLE void copyToClipboard(const QString &text);
    Q_INVOKABLE void minimizeApp() const;
    Q_INVOKABLE void restart() const;
    Q_INVOKABLE void opennotes() const;
    Q_INVOKABLE void purgecookies() const;
    Q_INVOKABLE void purgeTemp() const;
    Q_INVOKABLE QString openFileSelectionDlg();
    Q_INVOKABLE void showPopup(QString title,QString message);
    Q_INVOKABLE void hideFromSight() const;
    Q_INVOKABLE void showToTask() const;
    Q_INVOKABLE void exportSource (QString text, QString title) const;
    Q_INVOKABLE void openBrowser (const QUrl &url) const;
    Q_INVOKABLE void snapScreen();
    Q_INVOKABLE void exportBookmark(QString url, QString title);
    Q_INVOKABLE void removeJSLog();
    Q_INVOKABLE void openJSLog();
    Q_INVOKABLE void openExternal(QString url);
    Q_INVOKABLE bool checkJSLog();
    Q_INVOKABLE void snapWebPage(int window);
    Q_INVOKABLE void purgeWindowImages();
    Q_INVOKABLE bool checkImagesource();
    Q_INVOKABLE QString jsLog();
    Q_INVOKABLE static bool isWebsiteSafe(QString url);
    Q_INVOKABLE static void dirCheckOrCreate(QString path);


private:
    QDeclarativeView * m_view;
        QClipboard *clipboard;



};

#endif // QMLUTILS_H
