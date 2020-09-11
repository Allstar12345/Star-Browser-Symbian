/****************************************************************************
** Meta object code from reading C++ file 'facebookrequest.h'
**
** Created: Mon 14. Sep 14:12:45 2015
**      by: The Qt Meta Object Compiler version 62 (Qt 4.7.4)
**
** WARNING! All changes made in this file will be lost!
*****************************************************************************/

#include "../socialconnect/facebook/facebookrequest.h"
#if !defined(Q_MOC_OUTPUT_REVISION)
#error "The header file 'facebookrequest.h' doesn't include <QObject>."
#elif Q_MOC_OUTPUT_REVISION != 62
#error "This file was generated using the moc from 4.7.4. It"
#error "cannot be used with the include files from this version of Qt."
#error "(The moc has changed too much.)"
#endif

QT_BEGIN_MOC_NAMESPACE
static const uint qt_meta_data_FacebookRequest[] = {

 // content:
       5,       // revision
       0,       // classname
       0,    0, // classinfo
       2,   14, // methods
       0,    0, // properties
       0,    0, // enums/sets
       0,    0, // constructors
       0,       // flags
       1,       // signalCount

 // signals: signature, parameters, type, tag, flags
      31,   17,   16,   16, 0x05,

 // slots: signature, parameters, type, tag, flags
      86,   80,   16,   16, 0x0a,

       0        // eod
};

static const char qt_meta_stringdata_FacebookRequest[] = {
    "FacebookRequest\0\0request,reply\0"
    "requestFinished(FacebookRequest*,FacebookReply*)\0"
    "reply\0onFinished(QNetworkReply*)\0"
};

const QMetaObject FacebookRequest::staticMetaObject = {
    { &QObject::staticMetaObject, qt_meta_stringdata_FacebookRequest,
      qt_meta_data_FacebookRequest, 0 }
};

#ifdef Q_NO_DATA_RELOCATION
const QMetaObject &FacebookRequest::getStaticMetaObject() { return staticMetaObject; }
#endif //Q_NO_DATA_RELOCATION

const QMetaObject *FacebookRequest::metaObject() const
{
    return QObject::d_ptr->metaObject ? QObject::d_ptr->metaObject : &staticMetaObject;
}

void *FacebookRequest::qt_metacast(const char *_clname)
{
    if (!_clname) return 0;
    if (!strcmp(_clname, qt_meta_stringdata_FacebookRequest))
        return static_cast<void*>(const_cast< FacebookRequest*>(this));
    return QObject::qt_metacast(_clname);
}

int FacebookRequest::qt_metacall(QMetaObject::Call _c, int _id, void **_a)
{
    _id = QObject::qt_metacall(_c, _id, _a);
    if (_id < 0)
        return _id;
    if (_c == QMetaObject::InvokeMetaMethod) {
        switch (_id) {
        case 0: requestFinished((*reinterpret_cast< FacebookRequest*(*)>(_a[1])),(*reinterpret_cast< FacebookReply*(*)>(_a[2]))); break;
        case 1: onFinished((*reinterpret_cast< QNetworkReply*(*)>(_a[1]))); break;
        default: ;
        }
        _id -= 2;
    }
    return _id;
}

// SIGNAL 0
void FacebookRequest::requestFinished(FacebookRequest * _t1, FacebookReply * _t2)
{
    void *_a[] = { 0, const_cast<void*>(reinterpret_cast<const void*>(&_t1)), const_cast<void*>(reinterpret_cast<const void*>(&_t2)) };
    QMetaObject::activate(this, &staticMetaObject, 0, _a);
}
QT_END_MOC_NAMESPACE
