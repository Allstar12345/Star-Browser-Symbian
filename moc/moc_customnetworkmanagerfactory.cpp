/****************************************************************************
** Meta object code from reading C++ file 'customnetworkmanagerfactory.h'
**
** Created: Fri 15. May 22:42:32 2020
**      by: The Qt Meta Object Compiler version 62 (Qt 4.7.4)
**
** WARNING! All changes made in this file will be lost!
*****************************************************************************/

#include "../customnetworkmanagerfactory.h"
#if !defined(Q_MOC_OUTPUT_REVISION)
#error "The header file 'customnetworkmanagerfactory.h' doesn't include <QObject>."
#elif Q_MOC_OUTPUT_REVISION != 62
#error "This file was generated using the moc from 4.7.4. It"
#error "cannot be used with the include files from this version of Qt."
#error "(The moc has changed too much.)"
#endif

QT_BEGIN_MOC_NAMESPACE
static const uint qt_meta_data_CustomNetworkManagerFactory[] = {

 // content:
       5,       // revision
       0,       // classname
       0,    0, // classinfo
       1,   14, // methods
       0,    0, // properties
       0,    0, // enums/sets
       0,    0, // constructors
       0,       // flags
       0,       // signalCount

 // slots: signature, parameters, type, tag, flags
      41,   29,   28,   28, 0x0a,

       0        // eod
};

static const char qt_meta_stringdata_CustomNetworkManagerFactory[] = {
    "CustomNetworkManagerFactory\0\0reply,error\0"
    "onIgnoreSSLErrors(QNetworkReply*,QList<QSslError>)\0"
};

const QMetaObject CustomNetworkManagerFactory::staticMetaObject = {
    { &QObject::staticMetaObject, qt_meta_stringdata_CustomNetworkManagerFactory,
      qt_meta_data_CustomNetworkManagerFactory, 0 }
};

#ifdef Q_NO_DATA_RELOCATION
const QMetaObject &CustomNetworkManagerFactory::getStaticMetaObject() { return staticMetaObject; }
#endif //Q_NO_DATA_RELOCATION

const QMetaObject *CustomNetworkManagerFactory::metaObject() const
{
    return QObject::d_ptr->metaObject ? QObject::d_ptr->metaObject : &staticMetaObject;
}

void *CustomNetworkManagerFactory::qt_metacast(const char *_clname)
{
    if (!_clname) return 0;
    if (!strcmp(_clname, qt_meta_stringdata_CustomNetworkManagerFactory))
        return static_cast<void*>(const_cast< CustomNetworkManagerFactory*>(this));
    if (!strcmp(_clname, "QDeclarativeNetworkAccessManagerFactory"))
        return static_cast< QDeclarativeNetworkAccessManagerFactory*>(const_cast< CustomNetworkManagerFactory*>(this));
    return QObject::qt_metacast(_clname);
}

int CustomNetworkManagerFactory::qt_metacall(QMetaObject::Call _c, int _id, void **_a)
{
    _id = QObject::qt_metacall(_c, _id, _a);
    if (_id < 0)
        return _id;
    if (_c == QMetaObject::InvokeMetaMethod) {
        switch (_id) {
        case 0: onIgnoreSSLErrors((*reinterpret_cast< QNetworkReply*(*)>(_a[1])),(*reinterpret_cast< QList<QSslError>(*)>(_a[2]))); break;
        default: ;
        }
        _id -= 1;
    }
    return _id;
}
QT_END_MOC_NAMESPACE
