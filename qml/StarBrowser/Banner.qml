/**
Copyright (C) 2020 Allstar Software (Paul Wallace)
*/
import QtQuick 1.1
Item{
    anchors { top: parent.top; left: parent.left; right: parent.right }
    property alias text: text.text
    property alias color: bannerrect.color
    property alias bannerheight: bannerrect.height
   property alias timeout : timer.interval
    function banneropen(){ go.start();text.opacity=1;
        if (timer.interval)timer.restart();
    }
    function bannerclose() {back.start();text.opacity=0;}
    SmoothedAnimation{
        id: go
        duration: 300
        target: bannerrect
        property: "anchors.topMargin"
        to: 0
    }
    SmoothedAnimation{
        id: back
        duration: 300
        target: bannerrect
        property: "anchors.topMargin"
        to: largeQAButtons? -70: -56
    }

    Rectangle{
        id: bannerrect
        z: 10
        color:appsettings.getSystemSetting("bannercolour", "")===""? "black":appsettings.getSystemSetting("bannercolour", "")
        height: largeQAButtons? 70: 56
        opacity: 0.900
        anchors { top: parent.top; left: parent.left; right: parent.right; topMargin: largeQAButtons?-70: -56 }

         Text{
             Behavior on opacity { NumberAnimation{duration: 400}}
             anchors.fill: parent
             wrapMode: Text.Wrap
             opacity: 0
             width: parent.width-20
             font {pointSize: largeQAButtons? 9:7;family: platformStyle.fontFamilyRegular}
             id: text
             maximumLineCount: 2
             color: platformStyle.colorNormalLight
             verticalAlignment: Text.AlignVCenter
             horizontalAlignment: Text.AlignHCenter
         }
    }

    Timer{
        id: timer
        interval:  2700
        running: true
        onTriggered: {bannerclose();}
    }
}
