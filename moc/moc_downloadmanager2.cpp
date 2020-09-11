/****************************************************************************
** Meta object code from reading C++ file 'downloadmanager2.h'
**
** Created: Fri 15. May 22:42:30 2020
**      by: The Qt Meta Object Compiler version 62 (Qt 4.7.4)
**
** WARNING! All changes made in this file will be lost!
*****************************************************************************/

#include "../downloadmanager2.h"
#if !defined(Q_MOC_OUTPUT_REVISION)
#error "The header file 'downloadmanager2.h' doesn't include <QObject>."
#elif Q_MOC_OUTPUT_REVISION != 62
#error "This file was generated using the moc from 4.7.4. It"
#error "cannot be used with the include files from this version of Qt."
#error "(The moc has changed too much.)"
#endif

QT_BEGIN_MOC_NAMESPACE
static const uint qt_meta_data_DownloadManager2[] = {

 // content:
       5,       // revision
       0,       // classname
       0,    0, // classinfo
      17,   14, // methods
       0,    0, // properties
       0,    0, // enums/sets
       0,    0, // constructors
       0,       // flags
       9,       // signalCount

 // signals: signature, parameters, type, tag, flags
      18,   17,   17,   17, 0x05,
      48,   37,   17,   17, 0x05,
      86,   72,   17,   17, 0x05,
     108,   17,   17,   17, 0x05,
     126,   17,   17,   17, 0x05,
     143,   17,   17,   17, 0x05,
     175,  161,   17,   17, 0x05,
     199,   17,   17,   17, 0x05,
     231,  219,   17,   17, 0x05,

 // slots: signature, parameters, type, tag, flags
     259,   17,   17,   17, 0x0a,
     281,  268,   17,   17, 0x0a,
     304,   17,   17,   17, 0x0a,
     312,   17,   17,   17, 0x0a,
     329,  321,   17,   17, 0x08,
     356,   17,   17,   17, 0x08,
     392,  367,   17,   17, 0x08,
     429,  424,   17,   17, 0x08,

       0        // eod
};

static const char qt_meta_stringdata_DownloadManager2[] = {
    "DownloadManager2\0\0downloadComplete()\0"
    "percentage\0progressPercentage(int)\0"
    "currentStatus\0downloadStatus(float)\0"
    "downloadStarted()\0downloadPaused()\0"
    "downloadResumed()\0bytesReceived\0"
    "downloadedBytes(qint64)\0downloadCancelled()\0"
    "downloadURL\0downloadURLChanged(QString)\0"
    "cancel()\0url,fileName\0download(QUrl,QString)\0"
    "pause()\0resume()\0request\0"
    "download(QNetworkRequest&)\0finished()\0"
    "bytesReceived,bytesTotal\0"
    "downloadProgress(qint64,qint64)\0code\0"
    "error(QNetworkReply::NetworkError)\0"
};

const QMetaObject DownloadManager2::staticMetaObject = {
    { &QObject::staticMetaObject, qt_meta_stringdata_DownloadManager2,
      qt_meta_data_DownloadManager2, 0 }
};

#ifdef Q_NO_DATA_RELOCATION
const QMetaObject &DownloadManager2::getStaticMetaObject() { return staticMetaObject; }
#endif //Q_NO_DATA_RELOCATION

const QMetaObject *DownloadManager2::metaObject() const
{
    return QObject::d_ptr->metaObject ? QObject::d_ptr->metaObject : &staticMetaObject;
}

void *DownloadManager2::qt_metacast(const char *_clname)
{
    if (!_clname) return 0;
    if (!strcmp(_clname, qt_meta_stringdata_DownloadManager2))
        return static_cast<void*>(const_cast< DownloadManager2*>(this));
    return QObject::qt_metacast(_clname);
}

int DownloadManager2::qt_metacall(QMetaObject::Call _c, int _id, void **_a)
{
    _id = QObject::qt_metacall(_c, _id, _a);
    if (_id < 0)
        return _id;
    if (_c == QMetaObject::InvokeMetaMethod) {
        switch (_id) {
        case 0: downloadComplete(); break;
        case 1: progressPercentage((*reinterpret_cast< int(*)>(_a[1]))); break;
        case 2: downloadStatus((*reinterpret_cast< float(*)>(_a[1]))); break;
        case 3: downloadStarted(); break;
        case 4: downloadPaused(); break;
        case 5: downloadResumed(); break;
        case 6: downloadedBytes((*reinterpret_cast< qint64(*)>(_a[1]))); break;
        case 7: downloadCancelled(); break;
        case 8: downloadURLChanged((*reinterpret_cast< QString(*)>(_a[1]))); break;
        case 9: cancel(); break;
        case 10: download((*reinterpret_cast< QUrl(*)>(_a[1])),(*reinterpret_cast< QString(*)>(_a[2]))); break;
        case 11: pause(); break;
        case 12: resume(); break;
        case 13: download((*reinterpret_cast< QNetworkRequest(*)>(_a[1]))); break;
        case 14: finished(); break;
        case 15: downloadProgress((*reinterpret_cast< qint64(*)>(_a[1])),(*reinterpret_cast< qint64(*)>(_a[2]))); break;
        case 16: error((*reinterpret_cast< QNetworkReply::NetworkError(*)>(_a[1]))); break;
        default: ;
        }
        _id -= 17;
    }
    return _id;
}

// SIGNAL 0
void DownloadManager2::downloadComplete()
{
    QMetaObject::activate(this, &staticMetaObject, 0, 0);
}

// SIGNAL 1
void DownloadManager2::progressPercentage(int _t1)
{
    void *_a[] = { 0, const_cast<void*>(reinterpret_cast<const void*>(&_t1)) };
    QMetaObject::activate(this, &staticMetaObject, 1, _a);
}

// SIGNAL 2
void DownloadManager2::downloadStatus(float _t1)
{
    void *_a[] = { 0, const_cast<void*>(reinterpret_cast<const void*>(&_t1)) };
    QMetaObject::activate(this, &staticMetaObject, 2, _a);
}

// SIGNAL 3
void DownloadManager2::downloadStarted()
{
    QMetaObject::activate(this, &staticMetaObject, 3, 0);
}

// SIGNAL 4
void DownloadManager2::downloadPaused()
{
    QMetaObject::activate(this, &staticMetaObject, 4, 0);
}

// SIGNAL 5
void DownloadManager2::downloadResumed()
{
    QMetaObject::activate(this, &staticMetaObject, 5, 0);
}

// SIGNAL 6
void DownloadManager2::downloadedBytes(qint64 _t1)
{
    void *_a[] = { 0, const_cast<void*>(reinterpret_cast<const void*>(&_t1)) };
    QMetaObject::activate(this, &staticMetaObject, 6, _a);
}

// SIGNAL 7
void DownloadManager2::downloadCancelled()
{
    QMetaObject::activate(this, &staticMetaObject, 7, 0);
}

// SIGNAL 8
void DownloadManager2::downloadURLChanged(QString _t1)
{
    void *_a[] = { 0, const_cast<void*>(reinterpret_cast<const void*>(&_t1)) };
    QMetaObject::activate(this, &staticMetaObject, 8, _a);
}
QT_END_MOC_NAMESPACE
