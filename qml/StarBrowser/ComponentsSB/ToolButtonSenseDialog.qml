/**
Copyright (C) 2020 Allstar Software (Paul Wallace)
*/
import QtQuick 1.1

Image{
    height: sourceSize.height
    width: sourceSize.width
    signal clicked
    signal pressed
    signal released
    property alias highlightSource: highlight.source
    signal hold
    sourceSize.height: 60
    sourceSize.width: 60
    visible: true
    property url imgsource
    property string ps: appsettings.getSystemSetting("toolbuttonsource", "")===""?  "../img/ToolButton/blue.svg": appsettings.getSystemSetting("toolbuttonsource", "")
    id: root
    source: ""
    smooth:false
    anchors.verticalCenter: parent.verticalCenter
    Image{sourceSize.height: 25; sourceSize.width: 25; height:sourceSize.height;width: sourceSize.width; anchors.centerIn: parent;smooth:true; source: privateStyle.toolBarIconPath(imgsource); id:image}
    Image{anchors.fill: root; smooth: true; source: ps; id: highlight;opacity: mouse.pressed? 0.8:0; z: 1;Behavior on opacity{NumberAnimation{easing.type: Easing.Linear; duration: 150}}}
    MouseArea{id: mouse;anchors.fill: parent; onPressed: root.pressed();onClicked: root.clicked();onPressAndHold: root.hold();onReleased: root.released();z:2}
}
