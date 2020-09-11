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
    sourceSize.height: 48
    sourceSize.width: 115
    visible: true
    property alias buttonText: text.text
    property string ps: appsettings.getSystemSetting("buttonsource", "")===""?  "img/Button/blue.svg": appsettings.getSystemSetting("buttonsource", "")
    id: root
    smooth:false
    anchors.verticalCenter: parent.verticalCenter
    Text{id: text; anchors.centerIn: parent;color:"white"; font.pointSize:largeQAButtons?10: 8; z:3}
    Image{anchors.fill: root; smooth: true; source: ps; id: highlight;opacity: mouse.pressed? 0.8:0; z: 1;Behavior on opacity{NumberAnimation{easing.type: Easing.Linear; duration: 80}}}
    MouseArea{id: mouse;anchors.fill: parent; onPressed: root.pressed();onClicked: root.clicked();onPressAndHold: root.hold();onReleased: root.released();z:2}
}
