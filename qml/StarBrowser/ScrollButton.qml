/**
Copyright (C) 2020 Allstar Software (Paul Wallace)
*/
import QtQuick 1.1
Rectangle{
    id: scrollbutton
    visible: set_scroll
    rotation: scrollingDown? -90: 90
    opacity: 0
    function show(){scrollbutton.opacity=0.700}
    function hide(){scrolldelay.start();}
    Timer{ id: scrolldelay;interval: 790;onTriggered: {scrollbutton.opacity=0; scrollingdowndelayfalse.start();scrollingupdelayfalse.start()
        }}
    Behavior on opacity { NumberAnimation { duration: 100; easing.type: Easing.OutBounce} }
    border.width: 2
    border.color: mouse.pressed? "red": "white"
    color: "black"
    radius: 40
    smooth: true
    height: 63
    width: 63
    anchors.verticalCenter: parent.verticalCenter
    anchors.right: parent.right
    anchors.rightMargin: 6
    Image{
        source: "img/back_flat.svg"
        anchors.centerIn: parent
    }
    MouseArea{
        id: mouse
        anchors.fill: parent
        onClicked:{
            if(scrollingDown===true){flickable1.contentY= webViewHeight}
            else{flickable1.contentY=0}

        }
    }
}
