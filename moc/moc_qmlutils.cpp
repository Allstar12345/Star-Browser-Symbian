/****************************************************************************
** Meta object code from reading C++ file 'qmlutils.h'
**
** Created: Fri 15. May 22:42:19 2020
**      by: The Qt Meta Object Compiler version 62 (Qt 4.7.4)
**
** WARNING! All changes made in this file will be lost!
*****************************************************************************/

#include "../qmlutils.h"
#if !defined(Q_MOC_OUTPUT_REVISION)
#error "The header file 'qmlutils.h' doesn't include <QObject>."
#elif Q_MOC_OUTPUT_REVISION != 62
#error "This file was generated using the moc from 4.7.4. It"
#error "cannot be used with the include files from this version of Qt."
#error "(The moc has changed too much.)"
#endif

QT_BEGIN_MOC_NAMESPACE
static const uint qt_meta_data_QMLUtils[] = {

 // content:
       5,       // revision
       0,       // classname
       0,    0, // classinfo
      24,   14, // methods
       0,    0, // properties
       0,    0, // enums/sets
       0,    0, // constructors
       0,       // flags
       0,       // signalCount

 // methods: signature, parameters, type, tag, flags
      15,   10,    9,    9, 0x02,
      40,    9,    9,    9, 0x02,
      54,    9,    9,    9, 0x02,
      64,    9,    9,    9, 0x02,
      76,    9,    9,    9, 0x02,
      91,    9,    9,    9, 0x02,
     111,    9,  103,    9, 0x02,
     148,  134,    9,    9, 0x02,
     175,    9,    9,    9, 0x02,
     191,    9,    9,    9, 0x02,
     215,  204,    9,    9, 0x02,
     249,  245,    9,    9, 0x02,
     267,    9,    9,    9, 0x02,
     290,  280,    9,    9, 0x02,
     322,    9,    9,    9, 0x02,
     336,    9,    9,    9, 0x02,
     348,  245,    9,    9, 0x02,
     375,    9,  370,    9, 0x02,
     395,  388,    9,    9, 0x02,
     412,    9,    9,    9, 0x02,
     432,    9,  370,    9, 0x02,
     451,    9,  103,    9, 0x02,
     459,  245,  370,    9, 0x02,
     487,  482,    9,    9, 0x02,

       0        // eod
};

static const char qt_meta_stringdata_QMLUtils[] = {
    "QMLUtils\0\0text\0copyToClipboard(QString)\0"
    "minimizeApp()\0restart()\0opennotes()\0"
    "purgecookies()\0purgeTemp()\0QString\0"
    "openFileSelectionDlg()\0title,message\0"
    "showPopup(QString,QString)\0hideFromSight()\0"
    "showToTask()\0text,title\0"
    "exportSource(QString,QString)\0url\0"
    "openBrowser(QUrl)\0snapScreen()\0url,title\0"
    "exportBookmark(QString,QString)\0"
    "removeJSLog()\0openJSLog()\0"
    "openExternal(QString)\0bool\0checkJSLog()\0"
    "window\0snapWebPage(int)\0purgeWindowImages()\0"
    "checkImagesource()\0jsLog()\0"
    "isWebsiteSafe(QString)\0path\0"
    "dirCheckOrCreate(QString)\0"
};

const QMetaObject QMLUtils::staticMetaObject = {
    { &QObject::staticMetaObject, qt_meta_stringdata_QMLUtils,
      qt_meta_data_QMLUtils, 0 }
};

#ifdef Q_NO_DATA_RELOCATION
const QMetaObject &QMLUtils::getStaticMetaObject() { return staticMetaObject; }
#endif //Q_NO_DATA_RELOCATION

const QMetaObject *QMLUtils::metaObject() const
{
    return QObject::d_ptr->metaObject ? QObject::d_ptr->metaObject : &staticMetaObject;
}

void *QMLUtils::qt_metacast(const char *_clname)
{
    if (!_clname) return 0;
    if (!strcmp(_clname, qt_meta_stringdata_QMLUtils))
        return static_cast<void*>(const_cast< QMLUtils*>(this));
    return QObject::qt_metacast(_clname);
}

int QMLUtils::qt_metacall(QMetaObject::Call _c, int _id, void **_a)
{
    _id = QObject::qt_metacall(_c, _id, _a);
    if (_id < 0)
        return _id;
    if (_c == QMetaObject::InvokeMetaMethod) {
        switch (_id) {
        case 0: copyToClipboard((*reinterpret_cast< const QString(*)>(_a[1]))); break;
        case 1: minimizeApp(); break;
        case 2: restart(); break;
        case 3: opennotes(); break;
        case 4: purgecookies(); break;
        case 5: purgeTemp(); break;
        case 6: { QString _r = openFileSelectionDlg();
            if (_a[0]) *reinterpret_cast< QString*>(_a[0]) = _r; }  break;
        case 7: showPopup((*reinterpret_cast< QString(*)>(_a[1])),(*reinterpret_cast< QString(*)>(_a[2]))); break;
        case 8: hideFromSight(); break;
        case 9: showToTask(); break;
        case 10: exportSource((*reinterpret_cast< QString(*)>(_a[1])),(*reinterpret_cast< QString(*)>(_a[2]))); break;
        case 11: openBrowser((*reinterpret_cast< const QUrl(*)>(_a[1]))); break;
        case 12: snapScreen(); break;
        case 13: exportBookmark((*reinterpret_cast< QString(*)>(_a[1])),(*reinterpret_cast< QString(*)>(_a[2]))); break;
        case 14: removeJSLog(); break;
        case 15: openJSLog(); break;
        case 16: openExternal((*reinterpret_cast< QString(*)>(_a[1]))); break;
        case 17: { bool _r = checkJSLog();
            if (_a[0]) *reinterpret_cast< bool*>(_a[0]) = _r; }  break;
        case 18: snapWebPage((*reinterpret_cast< int(*)>(_a[1]))); break;
        case 19: purgeWindowImages(); break;
        case 20: { bool _r = checkImagesource();
            if (_a[0]) *reinterpret_cast< bool*>(_a[0]) = _r; }  break;
        case 21: { QString _r = jsLog();
            if (_a[0]) *reinterpret_cast< QString*>(_a[0]) = _r; }  break;
        case 22: { bool _r = isWebsiteSafe((*reinterpret_cast< QString(*)>(_a[1])));
            if (_a[0]) *reinterpret_cast< bool*>(_a[0]) = _r; }  break;
        case 23: dirCheckOrCreate((*reinterpret_cast< QString(*)>(_a[1]))); break;
        default: ;
        }
        _id -= 24;
    }
    return _id;
}
QT_END_MOC_NAMESPACE
