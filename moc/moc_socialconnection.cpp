/****************************************************************************
** Meta object code from reading C++ file 'socialconnection.h'
**
** Created: Mon 14. Sep 14:12:43 2015
**      by: The Qt Meta Object Compiler version 62 (Qt 4.7.4)
**
** WARNING! All changes made in this file will be lost!
*****************************************************************************/

#include "../socialconnect/socialconnection.h"
#if !defined(Q_MOC_OUTPUT_REVISION)
#error "The header file 'socialconnection.h' doesn't include <QObject>."
#elif Q_MOC_OUTPUT_REVISION != 62
#error "This file was generated using the moc from 4.7.4. It"
#error "cannot be used with the include files from this version of Qt."
#error "(The moc has changed too much.)"
#endif

QT_BEGIN_MOC_NAMESPACE
static const uint qt_meta_data_SocialConnection[] = {

 // content:
       5,       // revision
       0,       // classname
       0,    0, // classinfo
      20,   14, // methods
       5,  114, // properties
       0,    0, // enums/sets
       0,    0, // constructors
       0,       // flags
      10,       // signalCount

 // signals: signature, parameters, type, tag, flags
      31,   18,   17,   17, 0x05,
      66,   61,   17,   17, 0x05,
      97,   84,   17,   17, 0x05,
     137,  123,   17,   17, 0x05,
     169,  164,   17,   17, 0x05,
     198,  190,   17,   17, 0x05,
     226,  190,   17,   17, 0x05,
     256,  190,   17,   17, 0x05,
     297,  283,   17,   17, 0x05,
     354,  337,   17,   17, 0x05,

 // slots: signature, parameters, type, tag, flags
     404,   17,  399,   17, 0x0a,
     419,   17,  399,   17, 0x0a,
     444,  436,  399,   17, 0x0a,
     469,   17,  399,   17, 0x0a,
     504,  492,  399,   17, 0x0a,
     542,   17,   17,   17, 0x0a,
     551,   17,  399,   17, 0x0a,
     570,   17,  399,   17, 0x0a,
     591,   17,  399,   17, 0x0a,
     615,  611,   17,   17, 0x09,

 // properties: name, type, flags
      18,  634, 0x88495103,
     123,  399, 0x01495001,
      61,  399, 0x01495001,
      84,  399, 0x01495001,
     164,  643, 0x0a495001,

 // properties: notify_signal_id
       0,
       3,
       1,
       2,
       4,

       0        // eod
};

static const char qt_meta_stringdata_SocialConnection[] = {
    "SocialConnection\0\0webInterface\0"
    "webInterfaceChanged(QObject*)\0busy\0"
    "busyChanged(bool)\0transmitting\0"
    "transmittingChanged(bool)\0authenticated\0"
    "authenticatedChanged(bool)\0name\0"
    "nameChanged(QString)\0success\0"
    "authenticateCompleted(bool)\0"
    "deauthenticateCompleted(bool)\0"
    "postMessageCompleted(bool)\0success,count\0"
    "retrieveMessageCountCompleted(bool,int)\0"
    "success,messages\0"
    "retrieveMessagesCompleted(bool,QVariantList)\0"
    "bool\0authenticate()\0deauthenticate()\0"
    "message\0postMessage(QVariantMap)\0"
    "retrieveMessageCount()\0from,to,max\0"
    "retrieveMessages(QString,QString,int)\0"
    "cancel()\0storeCredentials()\0"
    "restoreCredentials()\0removeCredentials()\0"
    "url\0onUrlChanged(QUrl)\0QObject*\0QString\0"
};

const QMetaObject SocialConnection::staticMetaObject = {
    { &QObject::staticMetaObject, qt_meta_stringdata_SocialConnection,
      qt_meta_data_SocialConnection, 0 }
};

#ifdef Q_NO_DATA_RELOCATION
const QMetaObject &SocialConnection::getStaticMetaObject() { return staticMetaObject; }
#endif //Q_NO_DATA_RELOCATION

const QMetaObject *SocialConnection::metaObject() const
{
    return QObject::d_ptr->metaObject ? QObject::d_ptr->metaObject : &staticMetaObject;
}

void *SocialConnection::qt_metacast(const char *_clname)
{
    if (!_clname) return 0;
    if (!strcmp(_clname, qt_meta_stringdata_SocialConnection))
        return static_cast<void*>(const_cast< SocialConnection*>(this));
    return QObject::qt_metacast(_clname);
}

int SocialConnection::qt_metacall(QMetaObject::Call _c, int _id, void **_a)
{
    _id = QObject::qt_metacall(_c, _id, _a);
    if (_id < 0)
        return _id;
    if (_c == QMetaObject::InvokeMetaMethod) {
        switch (_id) {
        case 0: webInterfaceChanged((*reinterpret_cast< QObject*(*)>(_a[1]))); break;
        case 1: busyChanged((*reinterpret_cast< bool(*)>(_a[1]))); break;
        case 2: transmittingChanged((*reinterpret_cast< bool(*)>(_a[1]))); break;
        case 3: authenticatedChanged((*reinterpret_cast< bool(*)>(_a[1]))); break;
        case 4: nameChanged((*reinterpret_cast< const QString(*)>(_a[1]))); break;
        case 5: authenticateCompleted((*reinterpret_cast< bool(*)>(_a[1]))); break;
        case 6: deauthenticateCompleted((*reinterpret_cast< bool(*)>(_a[1]))); break;
        case 7: postMessageCompleted((*reinterpret_cast< bool(*)>(_a[1]))); break;
        case 8: retrieveMessageCountCompleted((*reinterpret_cast< bool(*)>(_a[1])),(*reinterpret_cast< int(*)>(_a[2]))); break;
        case 9: retrieveMessagesCompleted((*reinterpret_cast< bool(*)>(_a[1])),(*reinterpret_cast< const QVariantList(*)>(_a[2]))); break;
        case 10: { bool _r = authenticate();
            if (_a[0]) *reinterpret_cast< bool*>(_a[0]) = _r; }  break;
        case 11: { bool _r = deauthenticate();
            if (_a[0]) *reinterpret_cast< bool*>(_a[0]) = _r; }  break;
        case 12: { bool _r = postMessage((*reinterpret_cast< const QVariantMap(*)>(_a[1])));
            if (_a[0]) *reinterpret_cast< bool*>(_a[0]) = _r; }  break;
        case 13: { bool _r = retrieveMessageCount();
            if (_a[0]) *reinterpret_cast< bool*>(_a[0]) = _r; }  break;
        case 14: { bool _r = retrieveMessages((*reinterpret_cast< const QString(*)>(_a[1])),(*reinterpret_cast< const QString(*)>(_a[2])),(*reinterpret_cast< int(*)>(_a[3])));
            if (_a[0]) *reinterpret_cast< bool*>(_a[0]) = _r; }  break;
        case 15: cancel(); break;
        case 16: { bool _r = storeCredentials();
            if (_a[0]) *reinterpret_cast< bool*>(_a[0]) = _r; }  break;
        case 17: { bool _r = restoreCredentials();
            if (_a[0]) *reinterpret_cast< bool*>(_a[0]) = _r; }  break;
        case 18: { bool _r = removeCredentials();
            if (_a[0]) *reinterpret_cast< bool*>(_a[0]) = _r; }  break;
        case 19: onUrlChanged((*reinterpret_cast< const QUrl(*)>(_a[1]))); break;
        default: ;
        }
        _id -= 20;
    }
#ifndef QT_NO_PROPERTIES
      else if (_c == QMetaObject::ReadProperty) {
        void *_v = _a[0];
        switch (_id) {
        case 0: *reinterpret_cast< QObject**>(_v) = webInterface(); break;
        case 1: *reinterpret_cast< bool*>(_v) = authenticated(); break;
        case 2: *reinterpret_cast< bool*>(_v) = busy(); break;
        case 3: *reinterpret_cast< bool*>(_v) = transmitting(); break;
        case 4: *reinterpret_cast< QString*>(_v) = name(); break;
        }
        _id -= 5;
    } else if (_c == QMetaObject::WriteProperty) {
        void *_v = _a[0];
        switch (_id) {
        case 0: setWebInterface(*reinterpret_cast< QObject**>(_v)); break;
        }
        _id -= 5;
    } else if (_c == QMetaObject::ResetProperty) {
        _id -= 5;
    } else if (_c == QMetaObject::QueryPropertyDesignable) {
        _id -= 5;
    } else if (_c == QMetaObject::QueryPropertyScriptable) {
        _id -= 5;
    } else if (_c == QMetaObject::QueryPropertyStored) {
        _id -= 5;
    } else if (_c == QMetaObject::QueryPropertyEditable) {
        _id -= 5;
    } else if (_c == QMetaObject::QueryPropertyUser) {
        _id -= 5;
    }
#endif // QT_NO_PROPERTIES
    return _id;
}

// SIGNAL 0
void SocialConnection::webInterfaceChanged(QObject * _t1)
{
    void *_a[] = { 0, const_cast<void*>(reinterpret_cast<const void*>(&_t1)) };
    QMetaObject::activate(this, &staticMetaObject, 0, _a);
}

// SIGNAL 1
void SocialConnection::busyChanged(bool _t1)
{
    void *_a[] = { 0, const_cast<void*>(reinterpret_cast<const void*>(&_t1)) };
    QMetaObject::activate(this, &staticMetaObject, 1, _a);
}

// SIGNAL 2
void SocialConnection::transmittingChanged(bool _t1)
{
    void *_a[] = { 0, const_cast<void*>(reinterpret_cast<const void*>(&_t1)) };
    QMetaObject::activate(this, &staticMetaObject, 2, _a);
}

// SIGNAL 3
void SocialConnection::authenticatedChanged(bool _t1)
{
    void *_a[] = { 0, const_cast<void*>(reinterpret_cast<const void*>(&_t1)) };
    QMetaObject::activate(this, &staticMetaObject, 3, _a);
}

// SIGNAL 4
void SocialConnection::nameChanged(const QString & _t1)
{
    void *_a[] = { 0, const_cast<void*>(reinterpret_cast<const void*>(&_t1)) };
    QMetaObject::activate(this, &staticMetaObject, 4, _a);
}

// SIGNAL 5
void SocialConnection::authenticateCompleted(bool _t1)
{
    void *_a[] = { 0, const_cast<void*>(reinterpret_cast<const void*>(&_t1)) };
    QMetaObject::activate(this, &staticMetaObject, 5, _a);
}

// SIGNAL 6
void SocialConnection::deauthenticateCompleted(bool _t1)
{
    void *_a[] = { 0, const_cast<void*>(reinterpret_cast<const void*>(&_t1)) };
    QMetaObject::activate(this, &staticMetaObject, 6, _a);
}

// SIGNAL 7
void SocialConnection::postMessageCompleted(bool _t1)
{
    void *_a[] = { 0, const_cast<void*>(reinterpret_cast<const void*>(&_t1)) };
    QMetaObject::activate(this, &staticMetaObject, 7, _a);
}

// SIGNAL 8
void SocialConnection::retrieveMessageCountCompleted(bool _t1, int _t2)
{
    void *_a[] = { 0, const_cast<void*>(reinterpret_cast<const void*>(&_t1)), const_cast<void*>(reinterpret_cast<const void*>(&_t2)) };
    QMetaObject::activate(this, &staticMetaObject, 8, _a);
}

// SIGNAL 9
void SocialConnection::retrieveMessagesCompleted(bool _t1, const QVariantList & _t2)
{
    void *_a[] = { 0, const_cast<void*>(reinterpret_cast<const void*>(&_t1)), const_cast<void*>(reinterpret_cast<const void*>(&_t2)) };
    QMetaObject::activate(this, &staticMetaObject, 9, _a);
}
QT_END_MOC_NAMESPACE
