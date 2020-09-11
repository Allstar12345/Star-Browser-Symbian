/**
Copyright (C) 2020 Allstar Software (Paul Wallace)
*/
import QtQuick 1.1

Rectangle {
    id: root
    signal clicked
    signal hold
    signal released
    property alias imgSource: img.source
    height:largeQAButtons?42: 40
    z:1
    Rectangle{anchors.fill: parent; color: "grey" ;opacity: mouse.pressed? 0.6:0; z:2;  Behavior on opacity {NumberAnimation{duration:80}}}
    Behavior on opacity {NumberAnimation{duration:120}}
    color: popupbutton.color

    MouseArea{
        id: mouse
        anchors.fill:parent
        onClicked:{
            root.clicked();}
        onPressAndHold: root.hold();
        onReleased: root.released();
    }
    Image{
        anchors.centerIn: parent
        smooth:true
        id: img
        sourceSize.width: largeQAButtons?40: 32
        sourceSize.height: largeQAButtons?40: 32
        width: sourceSize.width
        height: sourceSize.height
    }
}
