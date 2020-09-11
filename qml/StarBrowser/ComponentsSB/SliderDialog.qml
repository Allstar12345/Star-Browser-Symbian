/**
Copyright (C) 2020 Allstar Software (Paul Wallace)
*/
import QtQuick 1.1
import com.nokia.symbian 1.1
import "../"

Item{
    id: root
    z: 10
    visible: true
    opacity:1
    anchors.fill: parent
    MouseArea{id: mouse; anchors.fill: parent}
    Timer{id:killtimer; interval: 200; onTriggered:{root.destroy();}}
    property bool transbackground: false
    function closeDialog(){background.opacity=0; base.scale=0.93; base.opacity=0;valuetext.opacity=0;headerText.opacity=0;baseheader.opacity=0;headerb.opacity=0;closebut.opacity=0;htext.opacity=0; lowercolor.opacity=0;lowercolorb.opacity=0;killtimer.start();}
    property alias headerText: htext.text
    property string svalue: ""
    property string colour: appsettings.getSystemSetting("newfloatingsource", "")===""?"#00aaff":appsettings.getSystemSetting("newfloatingsource", "")
    signal closePressed
    property bool round1: false
    Component.onCompleted: {transbackground? background.opacity=0: background.opacity=0.3; base.scale=1; base.opacity=1;}
    Rectangle{id: background; opacity: 0;color:"black";anchors.fill: parent;Behavior on opacity {NumberAnimation{}}z: 8}
    Rectangle{
        Behavior on opacity{NumberAnimation{duration: 100}}
        Behavior on scale {NumberAnimation{}}
        id: base
        clip: true
        anchors.centerIn: parent
        height: 160
        radius: 10
        smooth:true
        opacity: 0.95
        scale: 0.95
        width: parent.width-5
        color:"black"
        z: 9

        Text{Behavior on opacity{NumberAnimation{duration: 100}}id: valuetext;font.pointSize: largeQAButtons?18:15; text:round1?Math.round(svalue*100): Math.round(svalue*1); color:"white";anchors{horizontalCenter: parent.horizontalCenter; verticalCenter: parent.verticalCenter; verticalCenterOffset: -7}}
        Rectangle{Behavior on opacity{NumberAnimation{duration: 100}}id: baseheader;smooth: true; anchors{right:base.right; left:base.left; top:base.top}color:colour; z: 2; radius: 10;height: 45
            Rectangle{Behavior on opacity{NumberAnimation{duration: 100}}id: headerb;z: 10; height: 7.5; color:"black";anchors{right:parent.right; left:parent.left;bottom: parent.bottom}}
            ToolButtonSenseDialog{Behavior on opacity{NumberAnimation{duration: 100}}id: closebut;onClicked: {closePressed();closeDialog();}anchors.right: parent.right;anchors.verticalCenterOffset: -3; imgsource: "../img/close_stop_flat.svg"; height: largeQAButtons? 36:30; width: largeQAButtons? 36:30; z: 10}
        Text{Behavior on opacity{NumberAnimation{duration: 100}}id: htext;font.pointSize:largeQAButtons?8: 7; font.bold: true;color:"white";anchors{verticalCenter: parent.verticalCenter; verticalCenterOffset: -4;left: parent.left; leftMargin: 6}}
        }
        Rectangle{Behavior on opacity{NumberAnimation{duration: 100}}id: lowercolor;z: 10; radius: 10; height: 9; smooth: true;color:colour;anchors{right:parent.right; left:parent.left;bottom: parent.bottom}
            Rectangle{id: lowercolorb;z: 10; height: 6; smooth: true;color:"black";anchors{right:parent.right; left:parent.left;top:parent.top}}}
    }
}
