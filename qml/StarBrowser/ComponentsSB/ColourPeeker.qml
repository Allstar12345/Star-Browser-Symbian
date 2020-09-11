/**
Copyright (C) 2020 Allstar Software (Paul Wallace)
*/
import QtQuick 1.1

Rectangle {
    id: root
    anchors.verticalCenter: parent.verticalCenter
    z: 1
    anchors.right: parent.right
    anchors.rightMargin: 10
    width: 50
    height: screen.height===480? parent.height-45: parent.height-15
    color: null
    property alias colour: root.color
}
