/**
Copyright (C) 2020 Allstar Software (Paul Wallace)
*/
import QtQuick 1.1

Rectangle{
    id: root
    radius: 60
    smooth: true
    opacity: buttonEnabled? 1:0.7
    border.color: "white"
    property bool buttonEnabled: true
    Component.onCompleted: {if(img.source=="")text.anchors.centerIn=root
    else{text.anchors.bottom=root.bottom; text.anchors.bottomMargin=-14; text.anchors.horizontalCenter=root.horizontalCenter}
    }
    border.width: holdExtra == "true"? 1.5: 0.00
    Image{id: highlight; anchors.fill:parent; Behavior on opacity{NumberAnimation{duration: 80}} opacity:mousereload.pressed?1: 0 ; source: "img/button_option_enabled.svg"; sourceSize.height:root.height; sourceSize.width: root.height; width: sourceSize.width; height: sourceSize.width}
    Image{id: feimg; source:"img/button_option_enabled.svg"; anchors.fill:parent; opacity:buttonPressed?1.0: 0.0 ;Behavior on opacity{NumberAnimation{}}}
    signal clicked
    signal hold
    signal released
    property string customIconWidth: ""
    property bool customIconSize: false
    property alias imgSource: img.source
    property alias buttonText: text.text
    property bool buttonPressed: false
    property string holdExtra: "false"
    function flash(duration){
        buttonPressed=true;
        flashtimer.interval=duration;
        flashtimer.start();
    }
    Timer{id: flashtimer; onTriggered: {buttonPressed=false;}}
    height: 65
    width: 65
    Behavior on scale{ NumberAnimation{duration: 40}}
    color: "transparent"
    Image{
        id: img
        Component.onCompleted: {if(largeQAButtons==true)sourceSize.width="49"}
        sourceSize.width: customIconSize? customIconWidth: 33
        width: sourceSize.width
        height: sourceSize.width
        smooth: true
        anchors.centerIn: parent
        source: ""
    }
    Text{id: text;color:"white"; Component.onCompleted: {if(largeQAButtons==true)font.pointSize= img.source===""?screen.height===480?8:9 :screen.height===480?7:6} font.pointSize: img.source===""?  screen.height===480?6:8: screen.height===480?6:7}
    MouseArea{
        id: mousereload
        enabled: buttonEnabled
        anchors.fill:parent
        onClicked:{
            root.clicked();}
        onPressAndHold: root.hold();
        onReleased: root.released();
    }
}
