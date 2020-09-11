/**
Copyright (C) 2020 Allstar Software (Paul Wallace)
*/
import QtQuick 1.1

Image{
    height: sourceSize.height
    width: sourceSize.width
    signal clicked
    signal pressed
    property bool buttonPressed:false
    signal released
    Behavior on opacity{NumberAnimation{}}
    property alias highlightSource: highlight.source
    property bool buttonBackground: true
    signal hold
    sourceSize.height: 58
    sourceSize.width: 58
    visible: true
    property url imgsource
    property string ps: appsettings.getSystemSetting("toolbuttonsource", "")===""?  "img/ToolButton/blue.svg":appsettings.getSystemSetting("toolbuttonsource", "")
    id: root
    source:buttonBackground? "img/ToolButton/float_background.svg": ""
    smooth:false
    Image{anchors.centerIn: parent;smooth:true; source: privateStyle.toolBarIconPath(imgsource); id:image;  sourceSize.width: largeQAButtons? 39:32
        sourceSize.height:  largeQAButtons? 39:32
        height:sourceSize.height
        width:sourceSize.width}
    Image{id: highlighter; anchors.fill:parent; Behavior on opacity{NumberAnimation{duration: 80}} opacity:buttonPressed?1: 0 ; source: "img/button_option_enabled.svg"; sourceSize.height:root.height; sourceSize.width: root.height; width: sourceSize.width; height: sourceSize.width}
    Image{anchors.fill: root; smooth: true; source: ps; id: highlight;opacity: mouse.pressed? 0.8:0; z: 1;Behavior on opacity{NumberAnimation{easing.type: Easing.Linear; duration: 100}}}
    MouseArea{id: mouse;anchors.fill: parent; onPressed: root.pressed();onClicked: root.clicked();onPressAndHold: root.hold();onReleased: root.released();z:2}
}
