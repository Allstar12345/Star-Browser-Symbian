/**
Copyright (C) 2020 Allstar Software (Paul Wallace)
*/
import QtQuick 1.1

Rectangle{
    color:"black"
    opacity: 0
    Behavior on opacity{NumberAnimation{duration: 600}}
    anchors.fill:parent
    visible: true
    z: 10
    id: root
    Component.onCompleted: {root.opacity=0.85;text.opacity=0.9;textTimer.start(); }

    Text{
        id: text
        Behavior on opacity{NumberAnimation{duration: 1000}}
        font.pointSize: 12
        font.bold: true
        anchors{centerIn:parent}
        text:"Slide for more options"
        color:"white"
}
    Timer{id: textTimer; interval:2300; onTriggered: {text.opacity=0; startanim();}}
      function startanim(){img1.opacity=0.8; img1anim.start();step2wait.start(); step3wait.start(); step4wait.start()}
    Timer{id: step2wait; interval: 400; onTriggered: {img2.opacity=0.8; img2anim.start()}}
    Timer{id: step3wait; interval: 700; onTriggered: {img3.opacity=0.8; img3anim.start()}}
    Timer{id: step4wait; interval: 1050; onTriggered: {img4.opacity=0.8; img4anim.start()}}
    Timer{id: killtimer; interval: 1500; onTriggered:{root.destroy();}}
    SmoothedAnimation{id: img1anim; target:img1; property:"anchors.horizontalCenterOffset";  to:60; duration: 1500; onCompleted: {img1.opacity=0}}
    SmoothedAnimation{id: img2anim; target:img2; property:"anchors.horizontalCenterOffset"; to:10; duration: 1500; onCompleted: {img2.opacity=0}}
    SmoothedAnimation{id: img3anim; target:img3; property:"anchors.horizontalCenterOffset"; to:-40; duration: 1500; onCompleted: {img3.opacity=0}}
    SmoothedAnimation{id: img4anim; target:img4; property:"anchors.horizontalCenterOffset"; to:-90; duration: 1500; onCompleted: {img4.opacity=0;root.opacity=0; killtimer.start()}}

    Image{id: img1; Behavior on opacity{NumberAnimation{duration: 500}} opacity:0; sourceSize.height: 120; sourceSize.width: 90; height: sourceSize.height; width: sourceSize.width;source:"img/SwipeIndicator/swipearrow_flat.svg"; anchors{verticalCenter: parent.verticalCenter;horizontalCenterOffset: 150; horizontalCenter: parent.horizontalCenter}
    }
    Image{id: img2; Behavior on opacity{NumberAnimation{duration: 500}} opacity:0; sourceSize.height: 120; sourceSize.width: 90; height: sourceSize.height; width: sourceSize.width;source:"img/SwipeIndicator/swipearrow_flat.svg"; anchors{verticalCenter: parent.verticalCenter;horizontalCenterOffset: 62; horizontalCenter: parent.horizontalCenter}
    }
    Image{id: img3; Behavior on opacity{NumberAnimation{duration: 500}} opacity:0; sourceSize.height: 120; sourceSize.width: 90; height: sourceSize.height; width: sourceSize.width;source:"img/SwipeIndicator/swipearrow_flat.svg"; anchors{verticalCenter: parent.verticalCenter;horizontalCenterOffset: 12; horizontalCenter: parent.horizontalCenter}
    }
    Image{id: img4; Behavior on opacity{NumberAnimation{duration: 500}} opacity:0; sourceSize.height: 120; sourceSize.width: 90; height: sourceSize.height; width: sourceSize.width;source:"img/SwipeIndicator/swipearrow_flat.svg"; anchors{verticalCenter: parent.verticalCenter;horizontalCenterOffset: -42; horizontalCenter: parent.horizontalCenter}
    }
}
