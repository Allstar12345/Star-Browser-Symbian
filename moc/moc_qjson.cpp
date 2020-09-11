/****************************************************************************
** Meta object code from reading C++ file 'qjson.h'
**
** Created: Sat 6. Dec 13:22:01 2014
**      by: The Qt Meta Object Compiler version 62 (Qt 4.7.4)
**
** WARNING! All changes made in this file will be lost!
*****************************************************************************/

#include "../QJson/qjson.h"
#if !defined(Q_MOC_OUTPUT_REVISION)
#error "The header file 'qjson.h' doesn't include <QObject>."
#elif Q_MOC_OUTPUT_REVISION != 62
#error "This file was generated using the moc from 4.7.4. It"
#error "cannot be used with the include files from this version of Qt."
#error "(The moc has changed too much.)"
#endif

QT_BEGIN_MOC_NAMESPACE
static const uint qt_meta_data_QJson[] = {

 // content:
       5,       // revision
       0,       // classname
       0,    0, // classinfo
       6,   14, // methods
       0,    0, // properties
       0,    0, // enums/sets
       0,    0, // constructors
       0,       // flags
       2,       // signalCount

 // signals: signature, parameters, type, tag, flags
      20,    7,    6,    6, 0x05,
      61,   39,    6,    6, 0x05,

 // methods: signature, parameters, type, tag, flags
     103,   91,   82,    6, 0x02,
     136,  127,   82,    6, 0x22,
     161,  154,   82,    6, 0x02,
     183,  179,   82,    6, 0x22,

       0        // eod
};

static const char qt_meta_stringdata_QJson[] = {
    "QJson\0\0line,message\0error(int,QString)\0"
    "statusCode,statusText\0failure(int,QString)\0"
    "QVariant\0jsonData,ok\0parse(QByteArray,bool*)\0"
    "jsonData\0parse(QByteArray)\0url,ok\0"
    "parse(QUrl,bool*)\0url\0parse(QUrl)\0"
};

const QMetaObject QJson::staticMetaObject = {
    { &QObject::staticMetaObject, qt_meta_stringdata_QJson,
      qt_meta_data_QJson, 0 }
};

#ifdef Q_NO_DATA_RELOCATION
const QMetaObject &QJson::getStaticMetaObject() { return staticMetaObject; }
#endif //Q_NO_DATA_RELOCATION

const QMetaObject *QJson::metaObject() const
{
    return QObject::d_ptr->metaObject ? QObject::d_ptr->metaObject : &staticMetaObject;
}

void *QJson::qt_metacast(const char *_clname)
{
    if (!_clname) return 0;
    if (!strcmp(_clname, qt_meta_stringdata_QJson))
        return static_cast<void*>(const_cast< QJson*>(this));
    return QObject::qt_metacast(_clname);
}

int QJson::qt_metacall(QMetaObject::Call _c, int _id, void **_a)
{
    _id = QObject::qt_metacall(_c, _id, _a);
    if (_id < 0)
        return _id;
    if (_c == QMetaObject::InvokeMetaMethod) {
        switch (_id) {
        case 0: error((*reinterpret_cast< int(*)>(_a[1])),(*reinterpret_cast< QString(*)>(_a[2]))); break;
        case 1: failure((*reinterpret_cast< const int(*)>(_a[1])),(*reinterpret_cast< const QString(*)>(_a[2]))); break;
        case 2: { QVariant _r = parse((*reinterpret_cast< const QByteArray(*)>(_a[1])),(*reinterpret_cast< bool*(*)>(_a[2])));
            if (_a[0]) *reinterpret_cast< QVariant*>(_a[0]) = _r; }  break;
        case 3: { QVariant _r = parse((*reinterpret_cast< const QByteArray(*)>(_a[1])));
            if (_a[0]) *reinterpret_cast< QVariant*>(_a[0]) = _r; }  break;
        case 4: { QVariant _r = parse((*reinterpret_cast< const QUrl(*)>(_a[1])),(*reinterpret_cast< bool*(*)>(_a[2])));
            if (_a[0]) *reinterpret_cast< QVariant*>(_a[0]) = _r; }  break;
        case 5: { QVariant _r = parse((*reinterpret_cast< const QUrl(*)>(_a[1])));
            if (_a[0]) *reinterpret_cast< QVariant*>(_a[0]) = _r; }  break;
        default: ;
        }
        _id -= 6;
    }
    return _id;
}

// SIGNAL 0
void QJson::error(int _t1, QString _t2)
{
    void *_a[] = { 0, const_cast<void*>(reinterpret_cast<const void*>(&_t1)), const_cast<void*>(reinterpret_cast<const void*>(&_t2)) };
    QMetaObject::activate(this, &staticMetaObject, 0, _a);
}

// SIGNAL 1
void QJson::failure(const int _t1, const QString & _t2)
{
    void *_a[] = { 0, const_cast<void*>(reinterpret_cast<const void*>(&_t1)), const_cast<void*>(reinterpret_cast<const void*>(&_t2)) };
    QMetaObject::activate(this, &staticMetaObject, 1, _a);
}
QT_END_MOC_NAMESPACE
