/****************************************************************************
** Meta object code from reading C++ file 'qsymbianapplication.h'
**
** Created: Fri 15. May 22:42:31 2020
**      by: The Qt Meta Object Compiler version 62 (Qt 4.7.4)
**
** WARNING! All changes made in this file will be lost!
*****************************************************************************/

#include "../qsymbianapplication.h"
#if !defined(Q_MOC_OUTPUT_REVISION)
#error "The header file 'qsymbianapplication.h' doesn't include <QObject>."
#elif Q_MOC_OUTPUT_REVISION != 62
#error "This file was generated using the moc from 4.7.4. It"
#error "cannot be used with the include files from this version of Qt."
#error "(The moc has changed too much.)"
#endif

QT_BEGIN_MOC_NAMESPACE
static const uint qt_meta_data_QSymbianApplication[] = {

 // content:
       5,       // revision
       0,       // classname
       0,    0, // classinfo
      16,   14, // methods
       0,    0, // properties
       0,    0, // enums/sets
       0,    0, // constructors
       0,       // flags
      13,       // signalCount

 // signals: signature, parameters, type, tag, flags
      28,   21,   20,   20, 0x05,
      52,   20,   20,   20, 0x05,
      69,   65,   20,   20, 0x05,
      95,   20,   20,   20, 0x05,
     105,   20,   20,   20, 0x05,
     120,   20,   20,   20, 0x05,
     132,   20,   20,   20, 0x05,
     140,   20,   20,   20, 0x05,
     148,   20,   20,   20, 0x05,
     156,   20,   20,   20, 0x05,
     166,   20,   20,   20, 0x05,
     175,   20,   20,   20, 0x05,
     196,   20,   20,   20, 0x05,

 // slots: signature, parameters, type, tag, flags
     207,   20,   20,   20, 0x0a,

 // methods: signature, parameters, type, tag, flags
     227,   20,  222,   20, 0x02,
     240,   20,   20,   20, 0x02,

       0        // eod
};

static const char qt_meta_stringdata_QSymbianApplication[] = {
    "QSymbianApplication\0\0status\0"
    "foregroundChanged(bool)\0redPressed()\0"
    "val\0keyboardEventChanged(int)\0inFocus()\0"
    "inBackground()\0reloadKey()\0f3Key()\0"
    "f4Key()\0f6Key()\0homeKey()\0endKey()\0"
    "closeWithoutDialog()\0closeApp()\0"
    "stateChanged()\0bool\0foreground()\0"
    "downloadCloseDialog()\0"
};

const QMetaObject QSymbianApplication::staticMetaObject = {
    { &QApplication::staticMetaObject, qt_meta_stringdata_QSymbianApplication,
      qt_meta_data_QSymbianApplication, 0 }
};

#ifdef Q_NO_DATA_RELOCATION
const QMetaObject &QSymbianApplication::getStaticMetaObject() { return staticMetaObject; }
#endif //Q_NO_DATA_RELOCATION

const QMetaObject *QSymbianApplication::metaObject() const
{
    return QObject::d_ptr->metaObject ? QObject::d_ptr->metaObject : &staticMetaObject;
}

void *QSymbianApplication::qt_metacast(const char *_clname)
{
    if (!_clname) return 0;
    if (!strcmp(_clname, qt_meta_stringdata_QSymbianApplication))
        return static_cast<void*>(const_cast< QSymbianApplication*>(this));
    return QApplication::qt_metacast(_clname);
}

int QSymbianApplication::qt_metacall(QMetaObject::Call _c, int _id, void **_a)
{
    _id = QApplication::qt_metacall(_c, _id, _a);
    if (_id < 0)
        return _id;
    if (_c == QMetaObject::InvokeMetaMethod) {
        switch (_id) {
        case 0: foregroundChanged((*reinterpret_cast< bool(*)>(_a[1]))); break;
        case 1: redPressed(); break;
        case 2: keyboardEventChanged((*reinterpret_cast< int(*)>(_a[1]))); break;
        case 3: inFocus(); break;
        case 4: inBackground(); break;
        case 5: reloadKey(); break;
        case 6: f3Key(); break;
        case 7: f4Key(); break;
        case 8: f6Key(); break;
        case 9: homeKey(); break;
        case 10: endKey(); break;
        case 11: closeWithoutDialog(); break;
        case 12: closeApp(); break;
        case 13: stateChanged(); break;
        case 14: { bool _r = foreground();
            if (_a[0]) *reinterpret_cast< bool*>(_a[0]) = _r; }  break;
        case 15: downloadCloseDialog(); break;
        default: ;
        }
        _id -= 16;
    }
    return _id;
}

// SIGNAL 0
void QSymbianApplication::foregroundChanged(bool _t1)
{
    void *_a[] = { 0, const_cast<void*>(reinterpret_cast<const void*>(&_t1)) };
    QMetaObject::activate(this, &staticMetaObject, 0, _a);
}

// SIGNAL 1
void QSymbianApplication::redPressed()
{
    QMetaObject::activate(this, &staticMetaObject, 1, 0);
}

// SIGNAL 2
void QSymbianApplication::keyboardEventChanged(int _t1)
{
    void *_a[] = { 0, const_cast<void*>(reinterpret_cast<const void*>(&_t1)) };
    QMetaObject::activate(this, &staticMetaObject, 2, _a);
}

// SIGNAL 3
void QSymbianApplication::inFocus()
{
    QMetaObject::activate(this, &staticMetaObject, 3, 0);
}

// SIGNAL 4
void QSymbianApplication::inBackground()
{
    QMetaObject::activate(this, &staticMetaObject, 4, 0);
}

// SIGNAL 5
void QSymbianApplication::reloadKey()
{
    QMetaObject::activate(this, &staticMetaObject, 5, 0);
}

// SIGNAL 6
void QSymbianApplication::f3Key()
{
    QMetaObject::activate(this, &staticMetaObject, 6, 0);
}

// SIGNAL 7
void QSymbianApplication::f4Key()
{
    QMetaObject::activate(this, &staticMetaObject, 7, 0);
}

// SIGNAL 8
void QSymbianApplication::f6Key()
{
    QMetaObject::activate(this, &staticMetaObject, 8, 0);
}

// SIGNAL 9
void QSymbianApplication::homeKey()
{
    QMetaObject::activate(this, &staticMetaObject, 9, 0);
}

// SIGNAL 10
void QSymbianApplication::endKey()
{
    QMetaObject::activate(this, &staticMetaObject, 10, 0);
}

// SIGNAL 11
void QSymbianApplication::closeWithoutDialog()
{
    QMetaObject::activate(this, &staticMetaObject, 11, 0);
}

// SIGNAL 12
void QSymbianApplication::closeApp()
{
    QMetaObject::activate(this, &staticMetaObject, 12, 0);
}
QT_END_MOC_NAMESPACE
