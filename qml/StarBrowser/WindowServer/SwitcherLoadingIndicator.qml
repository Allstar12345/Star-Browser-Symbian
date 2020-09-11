/**
Copyright (C) 2020 Allstar Software (Paul Wallace)
*/
import QtQuick 1.1

Rectangle{
    color:"transparent"
    opacity: 1
    id: root
    function start(){shifter.start()}
    function stop(){shifter.stop()}
    z:10
    anchors.fill: parent
    Timer{id: shifter; repeat: true; interval: 90; onTriggered:{image.rotation +=40}}
    Component.onCompleted: {}
Image{
id: image
Behavior on rotation {NumberAnimation{}}
anchors.centerIn: parent
source:"../img/windowLoad.svg"
sourceSize.height: 95
sourceSize.width: 95
width: sourceSize.width
z:10
smooth: true
height: sourceSize.height
}
MouseArea{
    anchors.fill:parent
    enabled: true
}
}
