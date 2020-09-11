/**
Copyright (C) 2020 Allstar Software (Paul Wallace)
*/
import QtQuick 1.1

Rectangle{
    id: root
    radius: 25
    //smooth: true
    Image{id: highlight; anchors.fill:parent; Behavior on opacity{NumberAnimation{duration: 80}} opacity:mousereload.pressed?1: 0 ; source: "../img/button_option_enabled.svg"; sourceSize.height: 65; sourceSize.width: 65; width: sourceSize.width; height: sourceSize.width}
    Image{id: feimg; source:"../img/button_option_enabled.svg"; anchors.fill:parent; opacity:buttonPressed?1.0: 0.0 ;Behavior on opacity{NumberAnimation{}}}
    signal clicked
    signal hold
    signal released
    function hide() {disappear.start()}
    function show(){appear.start()}
    SmoothedAnimation{target: root; duration: 650 ;to: -31; id: appear; property: "anchors.bottomMargin"}
    SmoothedAnimation{target: root; duration: 650 ;to: -100; id: disappear; property: "anchors.bottomMargin"}
    property bool buttonPressed: false
    property alias imgSource: img.source
    property alias buttonText: text.text
    height: 70
    width: 90
    Behavior on scale{ NumberAnimation{duration: 40}}
    color: popupbutton.color
    Image{
        id: img
        smooth: true
        anchors.verticalCenter: parent.verticalCenter
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.horizontalCenterOffset: 7
        anchors.verticalCenterOffset:- 15
        sourceSize.width: largeQAButtons? 38:30
        sourceSize.height: largeQAButtons? 38:30
        height:sourceSize.height
        width:sourceSize.width
        source: ""
    }
    Text{id: text; anchors.centerIn: parent;color:"white"; font.pointSize: screen.height===480?6:7}
    MouseArea{
        id: mousereload
        anchors.fill:parent
        onClicked:{
            root.clicked();}
        onPressAndHold: root.hold();
        onReleased: root.released();
    }
}
