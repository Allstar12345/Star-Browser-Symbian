/**
Copyright (C) 2020 Allstar Software (Paul Wallace)
*/
import QtQuick 1.1


Rectangle{
    color:"black"
    opacity: 0
    Behavior on opacity{NumberAnimation{}}
    id: root
    function open(){root.opacity=0.8}
    z:1
    Timer{id: killTimer; interval: 4000; onTriggered: root.opacity=0}
    property int value
    onValueChanged: {decide()}
    function decide(){image.rotation=value;killTimer.restart();}
    Component.onCompleted: {image.rotation=appsettings.getSystemSetting("volumeChangerValue", "")}
Image{
id: image
Behavior on rotation {NumberAnimation{}}
anchors.centerIn: parent
source:"../img/AudioVolume/audiovolumemute.svg"
sourceSize.height: 150
sourceSize.width: 150
width: sourceSize.width
z:10
smooth: true
height: sourceSize.height
}

}
