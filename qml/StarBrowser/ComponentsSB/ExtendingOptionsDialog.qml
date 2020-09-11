/**
Copyright (C) 2020 Allstar Software (Paul Wallace)
*/
import QtQuick 1.1
import com.nokia.symbian 1.1

Rectangle{
    anchors{right: parent.right; left:parent.left}
    id: root
    height: 40
    signal clicked
    color: "black"
    property bool open: false
    opacity: mouse.pressed? 0.80: 1
    Behavior on opacity {NumberAnimation{duration:70}}
    property alias paneHeight: root.height
    property alias title: rootText.text
    Behavior on height{NumberAnimation{duration: 400; easing.type: Easing.InOutQuart}}
    function drillRotate(){drillimg.rotation=90; drillimg.anchors.verticalCenterOffset-=7}
    function drillRotateBack(){drillimg.rotation=0; drillimg.anchors.verticalCenterOffset+=7}
    function close(){root.height=40; drillRotateBack(); open=false}
    Rectangle{id: header
    color:popupbutton.color
    height: 40
    radius: 5
    smooth:true
    anchors{top: root.top; right: parent.right; left:parent.left; rightMargin:5; leftMargin: 5}
    ListItemText {
        role: "Title"
        id: rootText
        anchors.leftMargin: 10
        anchors.verticalCenter: parent.verticalCenter
        anchors.left: parent.left
        z: 1
    }
    Image{
        id: drillimg
        sourceSize.width: platformStyle.graphicSizeSmall
        sourceSize.height: platformStyle.graphicSizeSmall
        width:sourceSize.width
        Behavior on anchors.verticalCenterOffset {NumberAnimation{duration: 500; easing.type: Easing.InOutQuart}}
        height: sourceSize.height
        Behavior on rotation {NumberAnimation{duration: 500; easing.type: Easing.InOutQuart}}
        source: "../img/drilldown.svg"
        anchors.verticalCenter: parent.verticalCenter
        anchors.right: parent.right
        anchors.rightMargin: 10
    }
    MouseArea{id: mouse;anchors.fill: parent; onClicked: root.clicked()}}






}
