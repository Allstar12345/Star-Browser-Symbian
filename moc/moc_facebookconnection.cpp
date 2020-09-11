/****************************************************************************
** Meta object code from reading C++ file 'facebookconnection.h'
**
** Created: Mon 14. Sep 14:12:44 2015
**      by: The Qt Meta Object Compiler version 62 (Qt 4.7.4)
**
** WARNING! All changes made in this file will be lost!
*****************************************************************************/

#include "../socialconnect/facebook/facebookconnection.h"
#if !defined(Q_MOC_OUTPUT_REVISION)
#error "The header file 'facebookconnection.h' doesn't include <QObject>."
#elif Q_MOC_OUTPUT_REVISION != 62
#error "This file was generated using the moc from 4.7.4. It"
#error "cannot be used with the include files from this version of Qt."
#error "(The moc has changed too much.)"
#endif

QT_BEGIN_MOC_NAMESPACE
static const uint qt_meta_data_FacebookConnection[] = {

 // content:
       5,       // revision
       0,       // classname
       0,    0, // classinfo
      12,   14, // methods
       3,   74, // properties
       1,   86, // enums/sets
       0,    0, // constructors
       0,       // flags
       4,       // signalCount

 // signals: signature, parameters, type, tag, flags
      29,   20,   19,   19, 0x05,
      66,   54,   19,   19, 0x05,
     106,   94,   19,   19, 0x05,
     163,  138,   19,   19, 0x05,

 // slots: signature, parameters, type, tag, flags
     229,  209,  204,   19, 0x0a,
     286,  255,  204,   19, 0x0a,
     362,  324,  204,   19, 0x0a,
     415,  411,   19,   19, 0x09,
     439,  434,   19,   19, 0x08,
     479,  462,   19,   19, 0x08,
     536,  519,   19,   19, 0x08,
     584,  570,   19,   19, 0x08,

 // properties: name, type, flags
      20,  614, 0x0a495103,
      54,  614, 0x0a495103,
      94,  622, 0x0b495103,

 // properties: notify_signal_id
       0,
       1,
       2,

 // enums: name, flags, count, data
     634, 0x0,    3,   90,

 // enum data: key, value
     645, uint(FacebookConnection::HTTPGet),
     653, uint(FacebookConnection::HTTPPost),
     662, uint(FacebookConnection::HTTPDelete),

       0        // eod
};

static const char qt_meta_stringdata_FacebookConnection[] = {
    "FacebookConnection\0\0clientId\0"
    "clientIdChanged(QString)\0accessToken\0"
    "accessTokenChanged(QString)\0permissions\0"
    "permissionsChanged(QStringList)\0"
    "success,requestId,result\0"
    "requestCompleted(bool,QVariant,QVariant)\0"
    "bool\0requestId,graphPath\0"
    "request(QVariant,QString)\0"
    "requestId,graphPath,parameters\0"
    "request(QVariant,QString,QVariantMap)\0"
    "requestId,graphPath,method,parameters\0"
    "request(QVariant,QString,HTTPMethod,QVariantMap)\0"
    "url\0onUrlChanged(QUrl)\0name\0"
    "onNameChanged(QString)\0requestId,result\0"
    "onRequestCompleted(QVariant,QByteArray)\0"
    "requestId,reason\0onRequestFailed(QVariant,QString)\0"
    "authenticated\0onAuthenticationChanged(bool)\0"
    "QString\0QStringList\0HTTPMethod\0HTTPGet\0"
    "HTTPPost\0HTTPDelete\0"
};

const QMetaObject FacebookConnection::staticMetaObject = {
    { &SocialConnection::staticMetaObject, qt_meta_stringdata_FacebookConnection,
      qt_meta_data_FacebookConnection, 0 }
};

#ifdef Q_NO_DATA_RELOCATION
const QMetaObject &FacebookConnection::getStaticMetaObject() { return staticMetaObject; }
#endif //Q_NO_DATA_RELOCATION

const QMetaObject *FacebookConnection::metaObject() const
{
    return QObject::d_ptr->metaObject ? QObject::d_ptr->metaObject : &staticMetaObject;
}

void *FacebookConnection::qt_metacast(const char *_clname)
{
    if (!_clname) return 0;
    if (!strcmp(_clname, qt_meta_stringdata_FacebookConnection))
        return static_cast<void*>(const_cast< FacebookConnection*>(this));
    return SocialConnection::qt_metacast(_clname);
}

int FacebookConnection::qt_metacall(QMetaObject::Call _c, int _id, void **_a)
{
    _id = SocialConnection::qt_metacall(_c, _id, _a);
    if (_id < 0)
        return _id;
    if (_c == QMetaObject::InvokeMetaMethod) {
        switch (_id) {
        case 0: clientIdChanged((*reinterpret_cast< const QString(*)>(_a[1]))); break;
        case 1: accessTokenChanged((*reinterpret_cast< const QString(*)>(_a[1]))); break;
        case 2: permissionsChanged((*reinterpret_cast< const QStringList(*)>(_a[1]))); break;
        case 3: requestCompleted((*reinterpret_cast< bool(*)>(_a[1])),(*reinterpret_cast< const QVariant(*)>(_a[2])),(*reinterpret_cast< const QVariant(*)>(_a[3]))); break;
        case 4: { bool _r = request((*reinterpret_cast< const QVariant(*)>(_a[1])),(*reinterpret_cast< const QString(*)>(_a[2])));
            if (_a[0]) *reinterpret_cast< bool*>(_a[0]) = _r; }  break;
        case 5: { bool _r = request((*reinterpret_cast< const QVariant(*)>(_a[1])),(*reinterpret_cast< const QString(*)>(_a[2])),(*reinterpret_cast< const QVariantMap(*)>(_a[3])));
            if (_a[0]) *reinterpret_cast< bool*>(_a[0]) = _r; }  break;
        case 6: { bool _r = request((*reinterpret_cast< const QVariant(*)>(_a[1])),(*reinterpret_cast< const QString(*)>(_a[2])),(*reinterpret_cast< const HTTPMethod(*)>(_a[3])),(*reinterpret_cast< const QVariantMap(*)>(_a[4])));
            if (_a[0]) *reinterpret_cast< bool*>(_a[0]) = _r; }  break;
        case 7: onUrlChanged((*reinterpret_cast< const QUrl(*)>(_a[1]))); break;
        case 8: onNameChanged((*reinterpret_cast< const QString(*)>(_a[1]))); break;
        case 9: onRequestCompleted((*reinterpret_cast< const QVariant(*)>(_a[1])),(*reinterpret_cast< const QByteArray(*)>(_a[2]))); break;
        case 10: onRequestFailed((*reinterpret_cast< const QVariant(*)>(_a[1])),(*reinterpret_cast< const QString(*)>(_a[2]))); break;
        case 11: onAuthenticationChanged((*reinterpret_cast< const bool(*)>(_a[1]))); break;
        default: ;
        }
        _id -= 12;
    }
#ifndef QT_NO_PROPERTIES
      else if (_c == QMetaObject::ReadProperty) {
        void *_v = _a[0];
        switch (_id) {
        case 0: *reinterpret_cast< QString*>(_v) = clientId(); break;
        case 1: *reinterpret_cast< QString*>(_v) = accessToken(); break;
        case 2: *reinterpret_cast< QStringList*>(_v) = permissions(); break;
        }
        _id -= 3;
    } else if (_c == QMetaObject::WriteProperty) {
        void *_v = _a[0];
        switch (_id) {
        case 0: setClientId(*reinterpret_cast< QString*>(_v)); break;
        case 1: setAccessToken(*reinterpret_cast< QString*>(_v)); break;
        case 2: setPermissions(*reinterpret_cast< QStringList*>(_v)); break;
        }
        _id -= 3;
    } else if (_c == QMetaObject::ResetProperty) {
        _id -= 3;
    } else if (_c == QMetaObject::QueryPropertyDesignable) {
        _id -= 3;
    } else if (_c == QMetaObject::QueryPropertyScriptable) {
        _id -= 3;
    } else if (_c == QMetaObject::QueryPropertyStored) {
        _id -= 3;
    } else if (_c == QMetaObject::QueryPropertyEditable) {
        _id -= 3;
    } else if (_c == QMetaObject::QueryPropertyUser) {
        _id -= 3;
    }
#endif // QT_NO_PROPERTIES
    return _id;
}

// SIGNAL 0
void FacebookConnection::clientIdChanged(const QString & _t1)
{
    void *_a[] = { 0, const_cast<void*>(reinterpret_cast<const void*>(&_t1)) };
    QMetaObject::activate(this, &staticMetaObject, 0, _a);
}

// SIGNAL 1
void FacebookConnection::accessTokenChanged(const QString & _t1)
{
    void *_a[] = { 0, const_cast<void*>(reinterpret_cast<const void*>(&_t1)) };
    QMetaObject::activate(this, &staticMetaObject, 1, _a);
}

// SIGNAL 2
void FacebookConnection::permissionsChanged(const QStringList & _t1)
{
    void *_a[] = { 0, const_cast<void*>(reinterpret_cast<const void*>(&_t1)) };
    QMetaObject::activate(this, &staticMetaObject, 2, _a);
}

// SIGNAL 3
void FacebookConnection::requestCompleted(bool _t1, const QVariant & _t2, const QVariant & _t3)
{
    void *_a[] = { 0, const_cast<void*>(reinterpret_cast<const void*>(&_t1)), const_cast<void*>(reinterpret_cast<const void*>(&_t2)), const_cast<void*>(reinterpret_cast<const void*>(&_t3)) };
    QMetaObject::activate(this, &staticMetaObject, 3, _a);
}
QT_END_MOC_NAMESPACE
