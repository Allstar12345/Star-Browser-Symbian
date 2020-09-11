/****************************************************************************
** Meta object code from reading C++ file 'twitterconnection.h'
**
** Created: Sat 20. Dec 10:15:20 2014
**      by: The Qt Meta Object Compiler version 62 (Qt 4.7.4)
**
** WARNING! All changes made in this file will be lost!
*****************************************************************************/

#include "../socialconnect/twitter/twitterconnection.h"
#if !defined(Q_MOC_OUTPUT_REVISION)
#error "The header file 'twitterconnection.h' doesn't include <QObject>."
#elif Q_MOC_OUTPUT_REVISION != 62
#error "This file was generated using the moc from 4.7.4. It"
#error "cannot be used with the include files from this version of Qt."
#error "(The moc has changed too much.)"
#endif

QT_BEGIN_MOC_NAMESPACE
static const uint qt_meta_data_TwitterConnection[] = {

 // content:
       5,       // revision
       0,       // classname
       0,    0, // classinfo
      11,   14, // methods
       5,   69, // properties
       0,    0, // enums/sets
       0,    0, // constructors
       0,       // flags
       5,       // signalCount

 // signals: signature, parameters, type, tag, flags
      31,   19,   18,   18, 0x05,
      74,   59,   18,   18, 0x05,
     117,  105,   18,   18, 0x05,
     163,  145,   18,   18, 0x05,
     209,  197,   18,   18, 0x05,

 // slots: signature, parameters, type, tag, flags
     241,  237,   18,   18, 0x09,
     260,   18,   18,   18, 0x08,
     282,   18,   18,   18, 0x08,
     303,   18,   18,   18, 0x08,
     324,   18,   18,   18, 0x08,
     350,   18,   18,   18, 0x08,

 // properties: name, type, flags
      19,  380, 0x0a495103,
      59,  380, 0x0a495103,
     105,  380, 0x0a495103,
     145,  380, 0x0a495103,
     197,  380, 0x0a495103,

 // properties: notify_signal_id
       0,
       1,
       2,
       3,
       4,

       0        // eod
};

static const char qt_meta_stringdata_TwitterConnection[] = {
    "TwitterConnection\0\0consumerKey\0"
    "consumerKeyChanged(QString)\0consumerSecret\0"
    "consumerSecretChanged(QString)\0"
    "accessToken\0accessTokenChanged(QString)\0"
    "accessTokenSecret\0accessTokenSecretChanged(QString)\0"
    "callbackUrl\0callbackUrlChanged(QString)\0"
    "url\0onUrlChanged(QUrl)\0onRequestTokenReply()\0"
    "onAccessTokenReply()\0onPostMessageReply()\0"
    "onRetrieveMessagesReply()\0"
    "onRetrieveMessageCountReply()\0QString\0"
};

const QMetaObject TwitterConnection::staticMetaObject = {
    { &SocialConnection::staticMetaObject, qt_meta_stringdata_TwitterConnection,
      qt_meta_data_TwitterConnection, 0 }
};

#ifdef Q_NO_DATA_RELOCATION
const QMetaObject &TwitterConnection::getStaticMetaObject() { return staticMetaObject; }
#endif //Q_NO_DATA_RELOCATION

const QMetaObject *TwitterConnection::metaObject() const
{
    return QObject::d_ptr->metaObject ? QObject::d_ptr->metaObject : &staticMetaObject;
}

void *TwitterConnection::qt_metacast(const char *_clname)
{
    if (!_clname) return 0;
    if (!strcmp(_clname, qt_meta_stringdata_TwitterConnection))
        return static_cast<void*>(const_cast< TwitterConnection*>(this));
    return SocialConnection::qt_metacast(_clname);
}

int TwitterConnection::qt_metacall(QMetaObject::Call _c, int _id, void **_a)
{
    _id = SocialConnection::qt_metacall(_c, _id, _a);
    if (_id < 0)
        return _id;
    if (_c == QMetaObject::InvokeMetaMethod) {
        switch (_id) {
        case 0: consumerKeyChanged((*reinterpret_cast< QString(*)>(_a[1]))); break;
        case 1: consumerSecretChanged((*reinterpret_cast< QString(*)>(_a[1]))); break;
        case 2: accessTokenChanged((*reinterpret_cast< QString(*)>(_a[1]))); break;
        case 3: accessTokenSecretChanged((*reinterpret_cast< QString(*)>(_a[1]))); break;
        case 4: callbackUrlChanged((*reinterpret_cast< QString(*)>(_a[1]))); break;
        case 5: onUrlChanged((*reinterpret_cast< const QUrl(*)>(_a[1]))); break;
        case 6: onRequestTokenReply(); break;
        case 7: onAccessTokenReply(); break;
        case 8: onPostMessageReply(); break;
        case 9: onRetrieveMessagesReply(); break;
        case 10: onRetrieveMessageCountReply(); break;
        default: ;
        }
        _id -= 11;
    }
#ifndef QT_NO_PROPERTIES
      else if (_c == QMetaObject::ReadProperty) {
        void *_v = _a[0];
        switch (_id) {
        case 0: *reinterpret_cast< QString*>(_v) = consumerKey(); break;
        case 1: *reinterpret_cast< QString*>(_v) = consumerSecret(); break;
        case 2: *reinterpret_cast< QString*>(_v) = accessToken(); break;
        case 3: *reinterpret_cast< QString*>(_v) = accessTokenSecret(); break;
        case 4: *reinterpret_cast< QString*>(_v) = callbackUrl(); break;
        }
        _id -= 5;
    } else if (_c == QMetaObject::WriteProperty) {
        void *_v = _a[0];
        switch (_id) {
        case 0: setConsumerKey(*reinterpret_cast< QString*>(_v)); break;
        case 1: setConsumerSecret(*reinterpret_cast< QString*>(_v)); break;
        case 2: setAccessToken(*reinterpret_cast< QString*>(_v)); break;
        case 3: setAccessTokenSecret(*reinterpret_cast< QString*>(_v)); break;
        case 4: setCallbackUrl(*reinterpret_cast< QString*>(_v)); break;
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
void TwitterConnection::consumerKeyChanged(QString _t1)
{
    void *_a[] = { 0, const_cast<void*>(reinterpret_cast<const void*>(&_t1)) };
    QMetaObject::activate(this, &staticMetaObject, 0, _a);
}

// SIGNAL 1
void TwitterConnection::consumerSecretChanged(QString _t1)
{
    void *_a[] = { 0, const_cast<void*>(reinterpret_cast<const void*>(&_t1)) };
    QMetaObject::activate(this, &staticMetaObject, 1, _a);
}

// SIGNAL 2
void TwitterConnection::accessTokenChanged(QString _t1)
{
    void *_a[] = { 0, const_cast<void*>(reinterpret_cast<const void*>(&_t1)) };
    QMetaObject::activate(this, &staticMetaObject, 2, _a);
}

// SIGNAL 3
void TwitterConnection::accessTokenSecretChanged(QString _t1)
{
    void *_a[] = { 0, const_cast<void*>(reinterpret_cast<const void*>(&_t1)) };
    QMetaObject::activate(this, &staticMetaObject, 3, _a);
}

// SIGNAL 4
void TwitterConnection::callbackUrlChanged(QString _t1)
{
    void *_a[] = { 0, const_cast<void*>(reinterpret_cast<const void*>(&_t1)) };
    QMetaObject::activate(this, &staticMetaObject, 4, _a);
}
QT_END_MOC_NAMESPACE
