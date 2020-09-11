/****************************************************************************
** Meta object code from reading C++ file 'updatesystem.h'
**
** Created: Sat 2. May 23:46:11 2020
**      by: The Qt Meta Object Compiler version 62 (Qt 4.7.4)
**
** WARNING! All changes made in this file will be lost!
*****************************************************************************/

#include "../updatesystem.h"
#if !defined(Q_MOC_OUTPUT_REVISION)
#error "The header file 'updatesystem.h' doesn't include <QObject>."
#elif Q_MOC_OUTPUT_REVISION != 62
#error "This file was generated using the moc from 4.7.4. It"
#error "cannot be used with the include files from this version of Qt."
#error "(The moc has changed too much.)"
#endif

QT_BEGIN_MOC_NAMESPACE
static const uint qt_meta_data_UpdateSystem[] = {

 // content:
       5,       // revision
       0,       // classname
       0,    0, // classinfo
       7,   14, // methods
       4,   49, // properties
       0,    0, // enums/sets
       0,    0, // constructors
       0,       // flags
       4,       // signalCount

 // signals: signature, parameters, type, tag, flags
      27,   14,   13,   13, 0x05,
      56,   13,   13,   13, 0x05,
      86,   74,   13,   13, 0x05,
     122,  108,   13,   13, 0x05,

 // slots: signature, parameters, type, tag, flags
     150,  144,   13,   13, 0x08,
     194,  179,   13,   13, 0x08,

 // methods: signature, parameters, type, tag, flags
     226,   13,   13,   13, 0x02,

 // properties: name, type, flags
     248,  243, 0x01495001,
     274,  266, 0x0a495001,
     288,  266, 0x0a495001,
     298,  266, 0x0a495001,

 // properties: notify_signal_id
       0,
       0,
       0,
       0,

       0        // eod
};

static const char qt_meta_stringdata_UpdateSystem[] = {
    "UpdateSystem\0\0version,date\0"
    "updateFound(QString,QString)\0"
    "versionUpToDate()\0errorString\0"
    "errorOccured(QString)\0currentStatus\0"
    "downloadStatus(float)\0reply\0"
    "dataReceived(QNetworkReply*)\0"
    "recieved,total\0downloadProgress(qint64,qint64)\0"
    "checkForUpdate()\0bool\0isUpdateAvailable\0"
    "QString\0latestVersion\0updateUrl\0"
    "updateLog\0"
};

const QMetaObject UpdateSystem::staticMetaObject = {
    { &QObject::staticMetaObject, qt_meta_stringdata_UpdateSystem,
      qt_meta_data_UpdateSystem, 0 }
};

#ifdef Q_NO_DATA_RELOCATION
const QMetaObject &UpdateSystem::getStaticMetaObject() { return staticMetaObject; }
#endif //Q_NO_DATA_RELOCATION

const QMetaObject *UpdateSystem::metaObject() const
{
    return QObject::d_ptr->metaObject ? QObject::d_ptr->metaObject : &staticMetaObject;
}

void *UpdateSystem::qt_metacast(const char *_clname)
{
    if (!_clname) return 0;
    if (!strcmp(_clname, qt_meta_stringdata_UpdateSystem))
        return static_cast<void*>(const_cast< UpdateSystem*>(this));
    return QObject::qt_metacast(_clname);
}

int UpdateSystem::qt_metacall(QMetaObject::Call _c, int _id, void **_a)
{
    _id = QObject::qt_metacall(_c, _id, _a);
    if (_id < 0)
        return _id;
    if (_c == QMetaObject::InvokeMetaMethod) {
        switch (_id) {
        case 0: updateFound((*reinterpret_cast< QString(*)>(_a[1])),(*reinterpret_cast< QString(*)>(_a[2]))); break;
        case 1: versionUpToDate(); break;
        case 2: errorOccured((*reinterpret_cast< QString(*)>(_a[1]))); break;
        case 3: downloadStatus((*reinterpret_cast< float(*)>(_a[1]))); break;
        case 4: dataReceived((*reinterpret_cast< QNetworkReply*(*)>(_a[1]))); break;
        case 5: downloadProgress((*reinterpret_cast< qint64(*)>(_a[1])),(*reinterpret_cast< qint64(*)>(_a[2]))); break;
        case 6: checkForUpdate(); break;
        default: ;
        }
        _id -= 7;
    }
#ifndef QT_NO_PROPERTIES
      else if (_c == QMetaObject::ReadProperty) {
        void *_v = _a[0];
        switch (_id) {
        case 0: *reinterpret_cast< bool*>(_v) = getUpdateAvailability(); break;
        case 1: *reinterpret_cast< QString*>(_v) = getLatestVersion(); break;
        case 2: *reinterpret_cast< QString*>(_v) = getUpdateUrl(); break;
        case 3: *reinterpret_cast< QString*>(_v) = getUpdateLog(); break;
        }
        _id -= 4;
    } else if (_c == QMetaObject::WriteProperty) {
        _id -= 4;
    } else if (_c == QMetaObject::ResetProperty) {
        _id -= 4;
    } else if (_c == QMetaObject::QueryPropertyDesignable) {
        _id -= 4;
    } else if (_c == QMetaObject::QueryPropertyScriptable) {
        _id -= 4;
    } else if (_c == QMetaObject::QueryPropertyStored) {
        _id -= 4;
    } else if (_c == QMetaObject::QueryPropertyEditable) {
        _id -= 4;
    } else if (_c == QMetaObject::QueryPropertyUser) {
        _id -= 4;
    }
#endif // QT_NO_PROPERTIES
    return _id;
}

// SIGNAL 0
void UpdateSystem::updateFound(QString _t1, QString _t2)
{
    void *_a[] = { 0, const_cast<void*>(reinterpret_cast<const void*>(&_t1)), const_cast<void*>(reinterpret_cast<const void*>(&_t2)) };
    QMetaObject::activate(this, &staticMetaObject, 0, _a);
}

// SIGNAL 1
void UpdateSystem::versionUpToDate()
{
    QMetaObject::activate(this, &staticMetaObject, 1, 0);
}

// SIGNAL 2
void UpdateSystem::errorOccured(QString _t1)
{
    void *_a[] = { 0, const_cast<void*>(reinterpret_cast<const void*>(&_t1)) };
    QMetaObject::activate(this, &staticMetaObject, 2, _a);
}

// SIGNAL 3
void UpdateSystem::downloadStatus(float _t1)
{
    void *_a[] = { 0, const_cast<void*>(reinterpret_cast<const void*>(&_t1)) };
    QMetaObject::activate(this, &staticMetaObject, 3, _a);
}
QT_END_MOC_NAMESPACE
