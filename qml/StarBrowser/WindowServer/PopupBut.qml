/**
Copyright (C) 2020 Allstar Software (Paul Wallace)
*/
import QtQuick 1.1

Rectangle {
    id: root
    visible: true
    color:popupbutton.color
    height: 150
    opacity: mouse.pressed? 0.70: 1
    border.width: privateBrowsing? 2: 0
    border.color: "red"
    Behavior on opacity {NumberAnimation{}}
    function hide() {disappear.start()}
    function show(){appear.start()}
    function showmovement(){scrolldelayappear.start()}
    function hidemovement(){scrolldelaydisappear.start()}
    function showPageProgress(){time.text=Math.round(webView.progress*10) + "%"}
    function hidePageProgress(){time.text=symbian.currentTime}
    property alias text: time.text
    property alias colour: root.color
    anchors.bottom: parent.bottom
    anchors.horizontalCenter: parent.horizontalCenter
    anchors.bottomMargin: -110
    width: 150
    radius: 80
    smooth: true
    Timer{id: scrolldelayappear; interval: 300; onTriggered:{show()}}
    Timer{id: scrolldelaydisappear; interval: 300; onTriggered:{hide()}}
    SmoothedAnimation{target: root; to: -110; id: appear; property: "anchors.bottomMargin"}
    SmoothedAnimation{target: root; to: -150; id: disappear; property: "anchors.bottomMargin"}
    Text{id: time; text:webView.progress===1?  symbian.currentTime: Math.round(webView.progress*100)+"%"; anchors.horizontalCenter: parent.horizontalCenter; anchors.top: parent.top; anchors.topMargin: 10; color: "white"; font.pointSize: if(screen.height===480){largeQAButtons?7:6}else{largeQAButtons?10:9}}
    MouseArea{
        id: mouse
        enabled: true
        anchors.fill: parent
        onClicked:{wmenuOpen=true;disappear.start(); openswmenu()}
    }
}
