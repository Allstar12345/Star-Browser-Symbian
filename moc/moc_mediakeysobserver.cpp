/****************************************************************************
** Meta object code from reading C++ file 'mediakeysobserver.h'
**
** Created: Fri 15. May 22:42:18 2020
**      by: The Qt Meta Object Compiler version 62 (Qt 4.7.4)
**
** WARNING! All changes made in this file will be lost!
*****************************************************************************/

#include "../mediakeysobserver.h"
#if !defined(Q_MOC_OUTPUT_REVISION)
#error "The header file 'mediakeysobserver.h' doesn't include <QObject>."
#elif Q_MOC_OUTPUT_REVISION != 62
#error "This file was generated using the moc from 4.7.4. It"
#error "cannot be used with the include files from this version of Qt."
#error "(The moc has changed too much.)"
#endif

QT_BEGIN_MOC_NAMESPACE
static const uint qt_meta_data_MediaKeysObserver[] = {

 // content:
       5,       // revision
       0,       // classname
       0,    0, // classinfo
       3,   14, // methods
       0,    0, // properties
       1,   29, // enums/sets
       0,    0, // constructors
       0,       // flags
       3,       // signalCount

 // signals: signature, parameters, type, tag, flags
      23,   19,   18,   18, 0x05,
      44,   19,   18,   18, 0x05,
      65,   19,   18,   18, 0x05,

 // enums: name, flags, count, data
      87, 0x0,    3,   33,

 // enum data: key, value
      96, uint(MediaKeysObserver::EVolIncKey),
     107, uint(MediaKeysObserver::EVolDecKey),
     118, uint(MediaKeysObserver::EUpKey),

       0        // eod
};

static const char qt_meta_stringdata_MediaKeysObserver[] = {
    "MediaKeysObserver\0\0key\0mediaKeyClicked(int)\0"
    "mediaKeyPressed(int)\0mediaKeyReleased(int)\0"
    "MediaKey\0EVolIncKey\0EVolDecKey\0EUpKey\0"
};

const QMetaObject MediaKeysObserver::staticMetaObject = {
    { &QObject::staticMetaObject, qt_meta_stringdata_MediaKeysObserver,
      qt_meta_data_MediaKeysObserver, 0 }
};

#ifdef Q_NO_DATA_RELOCATION
const QMetaObject &MediaKeysObserver::getStaticMetaObject() { return staticMetaObject; }
#endif //Q_NO_DATA_RELOCATION

const QMetaObject *MediaKeysObserver::metaObject() const
{
    return QObject::d_ptr->metaObject ? QObject::d_ptr->metaObject : &staticMetaObject;
}

void *MediaKeysObserver::qt_metacast(const char *_clname)
{
    if (!_clname) return 0;
    if (!strcmp(_clname, qt_meta_stringdata_MediaKeysObserver))
        return static_cast<void*>(const_cast< MediaKeysObserver*>(this));
    if (!strcmp(_clname, "MRemConCoreApiTargetObserver"))
        return static_cast< MRemConCoreApiTargetObserver*>(const_cast< MediaKeysObserver*>(this));
    return QObject::qt_metacast(_clname);
}

int MediaKeysObserver::qt_metacall(QMetaObject::Call _c, int _id, void **_a)
{
    _id = QObject::qt_metacall(_c, _id, _a);
    if (_id < 0)
        return _id;
    if (_c == QMetaObject::InvokeMetaMethod) {
        switch (_id) {
        case 0: mediaKeyClicked((*reinterpret_cast< int(*)>(_a[1]))); break;
        case 1: mediaKeyPressed((*reinterpret_cast< int(*)>(_a[1]))); break;
        case 2: mediaKeyReleased((*reinterpret_cast< int(*)>(_a[1]))); break;
        default: ;
        }
        _id -= 3;
    }
    return _id;
}

// SIGNAL 0
void MediaKeysObserver::mediaKeyClicked(int _t1)
{
    void *_a[] = { 0, const_cast<void*>(reinterpret_cast<const void*>(&_t1)) };
    QMetaObject::activate(this, &staticMetaObject, 0, _a);
}

// SIGNAL 1
void MediaKeysObserver::mediaKeyPressed(int _t1)
{
    void *_a[] = { 0, const_cast<void*>(reinterpret_cast<const void*>(&_t1)) };
    QMetaObject::activate(this, &staticMetaObject, 1, _a);
}

// SIGNAL 2
void MediaKeysObserver::mediaKeyReleased(int _t1)
{
    void *_a[] = { 0, const_cast<void*>(reinterpret_cast<const void*>(&_t1)) };
    QMetaObject::activate(this, &staticMetaObject, 2, _a);
}
QT_END_MOC_NAMESPACE
