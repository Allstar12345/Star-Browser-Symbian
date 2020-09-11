/**
Copyright (C) 2020 Allstar Software (Paul Wallace)
*/
import QtQuick 1.1
Item{
    z:5
    id: root
    anchors.fill: parent
Component.onCompleted: {img1.opacity=1}
Timer{id: killTimer;running: true;  interval: 900; onTriggered: {img1.opacity=0; fadeout.start();}}
Timer{id: fadeout; interval: 200;onTriggered:{root.destroy()}}
    Image{
        id: img1
        opacity: 0
        source:"../img/stop.svg"
        sourceSize.height: 230
        sourceSize.width: 230
        height: sourceSize.height
        width: sourceSize.width
        anchors.centerIn: parent
        Behavior on opacity {NumberAnimation{}}
    }
}
