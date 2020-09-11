/****************************************************************************
** Meta object code from reading C++ file 'downloadbackend.h'
**
** Created: Fri 15. May 22:42:24 2020
**      by: The Qt Meta Object Compiler version 62 (Qt 4.7.4)
**
** WARNING! All changes made in this file will be lost!
*****************************************************************************/

#include "../downloadbackend.h"
#if !defined(Q_MOC_OUTPUT_REVISION)
#error "The header file 'downloadbackend.h' doesn't include <QObject>."
#elif Q_MOC_OUTPUT_REVISION != 62
#error "This file was generated using the moc from 4.7.4. It"
#error "cannot be used with the include files from this version of Qt."
#error "(The moc has changed too much.)"
#endif

QT_BEGIN_MOC_NAMESPACE
static const uint qt_meta_data_DownloadBackend[] = {

 // content:
       5,       // revision
       0,       // classname
       0,    0, // classinfo
       2,   14, // methods
       0,    0, // properties
       0,    0, // enums/sets
       0,    0, // constructors
       0,       // flags
       0,       // signalCount

 // slots: signature, parameters, type, tag, flags
      28,   17,   16,   16, 0x0a,
      66,   46,   16,   16, 0x0a,

       0        // eod
};

static const char qt_meta_stringdata_DownloadBackend[] = {
    "DownloadBackend\0\0src,target\0"
    "add(QUrl,QString)\0src,defaultFileName\0"
    "addFromQML(QUrl,QString)\0"
};

const QMetaObject DownloadBackend::staticMetaObject = {
    { &QObject::staticMetaObject, qt_meta_stringdata_DownloadBackend,
      qt_meta_data_DownloadBackend, 0 }
};

#ifdef Q_NO_DATA_RELOCATION
const QMetaObject &DownloadBackend::getStaticMetaObject() { return staticMetaObject; }
#endif //Q_NO_DATA_RELOCATION

const QMetaObject *DownloadBackend::metaObject() const
{
    return QObject::d_ptr->metaObject ? QObject::d_ptr->metaObject : &staticMetaObject;
}

void *DownloadBackend::qt_metacast(const char *_clname)
{
    if (!_clname) return 0;
    if (!strcmp(_clname, qt_meta_stringdata_DownloadBackend))
        return static_cast<void*>(const_cast< DownloadBackend*>(this));
    return QObject::qt_metacast(_clname);
}

int DownloadBackend::qt_metacall(QMetaObject::Call _c, int _id, void **_a)
{
    _id = QObject::qt_metacall(_c, _id, _a);
    if (_id < 0)
        return _id;
    if (_c == QMetaObject::InvokeMetaMethod) {
        switch (_id) {
        case 0: add((*reinterpret_cast< QUrl(*)>(_a[1])),(*reinterpret_cast< QString(*)>(_a[2]))); break;
        case 1: addFromQML((*reinterpret_cast< QUrl(*)>(_a[1])),(*reinterpret_cast< QString(*)>(_a[2]))); break;
        default: ;
        }
        _id -= 2;
    }
    return _id;
}
QT_END_MOC_NAMESPACE
