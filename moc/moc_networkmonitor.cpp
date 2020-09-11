/****************************************************************************
** Meta object code from reading C++ file 'networkmonitor.h'
**
** Created: Fri 15. May 22:42:14 2020
**      by: The Qt Meta Object Compiler version 62 (Qt 4.7.4)
**
** WARNING! All changes made in this file will be lost!
*****************************************************************************/

#include "../networkmonitor.h"
#if !defined(Q_MOC_OUTPUT_REVISION)
#error "The header file 'networkmonitor.h' doesn't include <QObject>."
#elif Q_MOC_OUTPUT_REVISION != 62
#error "This file was generated using the moc from 4.7.4. It"
#error "cannot be used with the include files from this version of Qt."
#error "(The moc has changed too much.)"
#endif

QT_BEGIN_MOC_NAMESPACE
static const uint qt_meta_data_NetworkMonitor[] = {

 // content:
       5,       // revision
       0,       // classname
       0,    0, // classinfo
       3,   14, // methods
       1,   29, // properties
       0,    0, // enums/sets
       0,    0, // constructors
       0,       // flags
       1,       // signalCount

 // signals: signature, parameters, type, tag, flags
      16,   15,   15,   15, 0x05,

 // slots: signature, parameters, type, tag, flags
      32,   15,   15,   15, 0x08,

 // methods: signature, parameters, type, tag, flags
      48,   15,   15,   15, 0x02,

 // properties: name, type, flags
      67,   62, 0x01495001,

 // properties: notify_signal_id
       0,

       0        // eod
};

static const char qt_meta_stringdata_NetworkMonitor[] = {
    "NetworkMonitor\0\0onlineChanged()\0"
    "checkIsOnline()\0setToOnline()\0bool\0"
    "online\0"
};

const QMetaObject NetworkMonitor::staticMetaObject = {
    { &QObject::staticMetaObject, qt_meta_stringdata_NetworkMonitor,
      qt_meta_data_NetworkMonitor, 0 }
};

#ifdef Q_NO_DATA_RELOCATION
const QMetaObject &NetworkMonitor::getStaticMetaObject() { return staticMetaObject; }
#endif //Q_NO_DATA_RELOCATION

const QMetaObject *NetworkMonitor::metaObject() const
{
    return QObject::d_ptr->metaObject ? QObject::d_ptr->metaObject : &staticMetaObject;
}

void *NetworkMonitor::qt_metacast(const char *_clname)
{
    if (!_clname) return 0;
    if (!strcmp(_clname, qt_meta_stringdata_NetworkMonitor))
        return static_cast<void*>(const_cast< NetworkMonitor*>(this));
    return QObject::qt_metacast(_clname);
}

int NetworkMonitor::qt_metacall(QMetaObject::Call _c, int _id, void **_a)
{
    _id = QObject::qt_metacall(_c, _id, _a);
    if (_id < 0)
        return _id;
    if (_c == QMetaObject::InvokeMetaMethod) {
        switch (_id) {
        case 0: onlineChanged(); break;
        case 1: checkIsOnline(); break;
        case 2: setToOnline(); break;
        default: ;
        }
        _id -= 3;
    }
#ifndef QT_NO_PROPERTIES
      else if (_c == QMetaObject::ReadProperty) {
        void *_v = _a[0];
        switch (_id) {
        case 0: *reinterpret_cast< bool*>(_v) = isOnline(); break;
        }
        _id -= 1;
    } else if (_c == QMetaObject::WriteProperty) {
        _id -= 1;
    } else if (_c == QMetaObject::ResetProperty) {
        _id -= 1;
    } else if (_c == QMetaObject::QueryPropertyDesignable) {
        _id -= 1;
    } else if (_c == QMetaObject::QueryPropertyScriptable) {
        _id -= 1;
    } else if (_c == QMetaObject::QueryPropertyStored) {
        _id -= 1;
    } else if (_c == QMetaObject::QueryPropertyEditable) {
        _id -= 1;
    } else if (_c == QMetaObject::QueryPropertyUser) {
        _id -= 1;
    }
#endif // QT_NO_PROPERTIES
    return _id;
}

// SIGNAL 0
void NetworkMonitor::onlineChanged()
{
    QMetaObject::activate(this, &staticMetaObject, 0, 0);
}
QT_END_MOC_NAMESPACE
