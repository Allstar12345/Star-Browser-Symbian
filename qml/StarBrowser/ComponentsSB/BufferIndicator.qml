/**
Copyright (C) 2020 Allstar Software (Paul Wallace)
*/
import QtQuick 1.1


Rectangle{
    color:"black"
    opacity: 0
    Behavior on opacity{NumberAnimation{}}
    id: root
    function start(){root.opacity=0.8;shifter.start()}
    function stop(){root.opacity=0; shifter.stop()}
    z:10
    Timer{id: shifter; repeat: true; interval: 50; onTriggered:{image.rotation +=50}}
    Component.onCompleted: {}
Image{
id: image
Behavior on rotation {NumberAnimation{}}
anchors.centerIn: parent
source:"../img/bufferingind.svg"
sourceSize.height: 150
sourceSize.width: 150
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
