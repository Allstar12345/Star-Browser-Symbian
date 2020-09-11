/****************************************************************************
** Meta object code from reading C++ file 'facebook.h'
**
** Created: Mon 14. Sep 14:12:44 2015
**      by: The Qt Meta Object Compiler version 62 (Qt 4.7.4)
**
** WARNING! All changes made in this file will be lost!
*****************************************************************************/

#include "../socialconnect/facebook/facebook.h"
#if !defined(Q_MOC_OUTPUT_REVISION)
#error "The header file 'facebook.h' doesn't include <QObject>."
#elif Q_MOC_OUTPUT_REVISION != 62
#error "This file was generated using the moc from 4.7.4. It"
#error "cannot be used with the include files from this version of Qt."
#error "(The moc has changed too much.)"
#endif

QT_BEGIN_MOC_NAMESPACE
static const uint qt_meta_data_Facebook[] = {

 // content:
       5,       // revision
       0,       // classname
       0,    0, // classinfo
       8,   14, // methods
       0,    0, // properties
       0,    0, // enums/sets
       0,    0, // constructors
       0,       // flags
       7,       // signalCount

 // signals: signature, parameters, type, tag, flags
      19,   10,    9,    9, 0x05,
      55,   44,    9,    9, 0x05,
      94,   82,    9,    9, 0x05,
     133,  122,    9,    9, 0x05,
     174,  157,    9,    9, 0x05,
     229,  212,    9,    9, 0x05,
     271,  261,    9,    9, 0x05,

 // slots: signature, parameters, type, tag, flags
     310,  296,    9,    9, 0x08,

       0        // eod
};

static const char qt_meta_stringdata_Facebook[] = {
    "Facebook\0\0clientId\0clientIdChanged(QString)\0"
    "screenName\0screenNameChanged(QString)\0"
    "accessToken\0accessTokenChanged(QString)\0"
    "authorized\0authorizedChanged(bool)\0"
    "requestId,result\0requestCompleted(QVariant,QByteArray)\0"
    "requestId,reason\0requestFailed(QVariant,QString)\0"
    "requestId\0requestLoading(QVariant)\0"
    "request,reply\0"
    "onRequestFinished(FacebookRequest*,FacebookReply*)\0"
};

const QMetaObject Facebook::staticMetaObject = {
    { &QObject::staticMetaObject, qt_meta_stringdata_Facebook,
      qt_meta_data_Facebook, 0 }
};

#ifdef Q_NO_DATA_RELOCATION
const QMetaObject &Facebook::getStaticMetaObject() { return staticMetaObject; }
#endif //Q_NO_DATA_RELOCATION

const QMetaObject *Facebook::metaObject() const
{
    return QObject::d_ptr->metaObject ? QObject::d_ptr->metaObject : &staticMetaObject;
}

void *Facebook::qt_metacast(const char *_clname)
{
    if (!_clname) return 0;
    if (!strcmp(_clname, qt_meta_stringdata_Facebook))
        return static_cast<void*>(const_cast< Facebook*>(this));
    return QObject::qt_metacast(_clname);
}

int Facebook::qt_metacall(QMetaObject::Call _c, int _id, void **_a)
{
    _id = QObject::qt_metacall(_c, _id, _a);
    if (_id < 0)
        return _id;
    if (_c == QMetaObject::InvokeMetaMethod) {
        switch (_id) {
        case 0: clientIdChanged((*reinterpret_cast< const QString(*)>(_a[1]))); break;
        case 1: screenNameChanged((*reinterpret_cast< const QString(*)>(_a[1]))); break;
        case 2: accessTokenChanged((*reinterpret_cast< const QString(*)>(_a[1]))); break;
        case 3: authorizedChanged((*reinterpret_cast< const bool(*)>(_a[1]))); break;
        case 4: requestCompleted((*reinterpret_cast< const QVariant(*)>(_a[1])),(*reinterpret_cast< const QByteArray(*)>(_a[2]))); break;
        case 5: requestFailed((*reinterpret_cast< const QVariant(*)>(_a[1])),(*reinterpret_cast< const QString(*)>(_a[2]))); break;
        case 6: requestLoading((*reinterpret_cast< const QVariant(*)>(_a[1]))); break;
        case 7: onRequestFinished((*reinterpret_cast< FacebookRequest*(*)>(_a[1])),(*reinterpret_cast< FacebookReply*(*)>(_a[2]))); break;
        default: ;
        }
        _id -= 8;
    }
    return _id;
}

// SIGNAL 0
void Facebook::clientIdChanged(const QString & _t1)
{
    void *_a[] = { 0, const_cast<void*>(reinterpret_cast<const void*>(&_t1)) };
    QMetaObject::activate(this, &staticMetaObject, 0, _a);
}

// SIGNAL 1
void Facebook::screenNameChanged(const QString & _t1)
{
    void *_a[] = { 0, const_cast<void*>(reinterpret_cast<const void*>(&_t1)) };
    QMetaObject::activate(this, &staticMetaObject, 1, _a);
}

// SIGNAL 2
void Facebook::accessTokenChanged(const QString & _t1)
{
    void *_a[] = { 0, const_cast<void*>(reinterpret_cast<const void*>(&_t1)) };
    QMetaObject::activate(this, &staticMetaObject, 2, _a);
}

// SIGNAL 3
void Facebook::authorizedChanged(const bool _t1)
{
    void *_a[] = { 0, const_cast<void*>(reinterpret_cast<const void*>(&_t1)) };
    QMetaObject::activate(this, &staticMetaObject, 3, _a);
}

// SIGNAL 4
void Facebook::requestCompleted(const QVariant & _t1, const QByteArray & _t2)
{
    void *_a[] = { 0, const_cast<void*>(reinterpret_cast<const void*>(&_t1)), const_cast<void*>(reinterpret_cast<const void*>(&_t2)) };
    QMetaObject::activate(this, &staticMetaObject, 4, _a);
}

// SIGNAL 5
void Facebook::requestFailed(const QVariant & _t1, const QString & _t2)
{
    void *_a[] = { 0, const_cast<void*>(reinterpret_cast<const void*>(&_t1)), const_cast<void*>(reinterpret_cast<const void*>(&_t2)) };
    QMetaObject::activate(this, &staticMetaObject, 5, _a);
}

// SIGNAL 6
void Facebook::requestLoading(const QVariant & _t1)
{
    void *_a[] = { 0, const_cast<void*>(reinterpret_cast<const void*>(&_t1)) };
    QMetaObject::activate(this, &staticMetaObject, 6, _a);
}
QT_END_MOC_NAMESPACE
