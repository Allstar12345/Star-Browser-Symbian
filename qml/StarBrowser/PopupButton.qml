/**
Copyright (C) 2020 Allstar Software (Paul Wallace)
*/
import QtQuick 1.1

Rectangle {
    id: root
    visible: true
    color: if (appsettings.getSystemSetting("newfloatingsource", "")=== ""){"#00aaff"}else{appsettings.getSystemSetting("newfloatingsource", "")}
    height: 150
    opacity: mouse.pressed? 0.70: 1
    border.width: privateBrowsing? 2: 0
    border.color: "red"
    Behavior on opacity {NumberAnimation{}}
    function hide() {disappear.start()}
    function show(){appear.start()}
    function showmovement(){scrolldelayappear.start()}
    function hidemovement(){scrolldelaydisappear.start()}
    function showPageProgress(){time.text=Math.round(web_view1.progress*10) + "%"}
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
    SmoothedAnimation{target: root; duration: 650 ;to: -110; id: appear; property: "anchors.bottomMargin"}
    SmoothedAnimation{target: root; duration: 650 ;to: -150; id: disappear; property: "anchors.bottomMargin"}
    Text{id: time; text:web_view1.progress===1?  symbian.currentTime: Math.round(web_view1.progress*100)+"%"; anchors.horizontalCenter: parent.horizontalCenter; anchors.top: parent.top; anchors.topMargin:10; color: "white"; font.pointSize: if(screen.height===480){largeQAButtons?7:6}else{largeQAButtons?10:9}}
    MouseArea{
        id: mouse
        enabled: popupButtonEnabled? true:false
        anchors.fill: parent
        onClicked:{popupButtonEnabled=false; menuOpen=true; disappear.start();hideScreenControls(); showpopmenu()}
        onPressAndHold: {web_view1.progress < 1.0 ? showStopPopup() : showReloadPopup()}
       // property int xPos
      //  property int yPos
       // onPressed: {
          //          xPos = mouseX;
          //          yPos = mouseY;
           //     }
      //  onReleased:{ if ((Math.abs(mouseY - xPos) < 5) && ((mouseX - yPos) > 5)) banner.showText("swiped down")}
    }
}
