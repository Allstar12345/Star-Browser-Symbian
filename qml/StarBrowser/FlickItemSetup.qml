/**
Copyright (C) 2020 Allstar Software (Paul Wallace)
*/
import QtQuick 1.1

Rectangle {
    anchors{right:parent.right;left:parent.left}
    height: 50
    color:"#00aaff"
    property alias iconSource: img.source
    property alias itemText: text.text
    Image{id: img; anchors.verticalCenter: parent.verticalCenter;anchors.left:parent.left; anchors.leftMargin: 10}
    Text{id: text; color: "white"; font.pointSize: 7; anchors.centerIn: parent}
}
