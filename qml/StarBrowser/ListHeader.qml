/**
Copyright (C) 2020 Allstar Software (Paul Wallace)
*/
import QtQuick 1.1
import "." 1.1

Item {
    id: root
    property alias headerText: text.text
    property alias paddingItem: paddingItem // Read-only
    implicitWidth: ListView.view ? ListView.view.width : screen.width
    implicitHeight: platformStyle.graphicSizeSmall

    Rectangle {
        color:popupbutton.color
        smooth: true
        radius: 5
        anchors.fill: parent
    }
    Text{
         id: text
        anchors.centerIn: parent
        color:"white"
        font.pointSize:largeQAButtons?8:7

    }

    Item {
        id: paddingItem
        anchors {
            fill: parent
            leftMargin: platformStyle.paddingLarge
            rightMargin: privateStyle.scrollBarThickness
            topMargin: platformStyle.paddingSmall
            bottomMargin: platformStyle.paddingSmall
        }
    }
}
