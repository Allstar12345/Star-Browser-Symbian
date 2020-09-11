/**
Copyright (C) 2020 Allstar Software (Paul Wallace)
*/
import QtQuick 1.1
Item{
    property int window
    Timer{id: snapdelay; interval:3900; onTriggered: {QMLUtils.snapWebPage(window);
}}
    function snapPage(windows){
        window=windows;snapdelay.start();
    }
}
