/**
Copyright (C) 2020 Allstar Software (Paul Wallace)
*/
import QtQuick 1.1
import "../"
Rectangle{
    anchors.fill: parent
    z: 2
    property string colour:popupbutton.colour
    id: root
    opacity: 0
    clip: true
    Behavior on opacity {NumberAnimation{} }
    color: "black"
    MouseArea{
        anchors.fill: parent
        onClicked: close()
    }
    Component.onCompleted: {open()}
    function open(){
        root.opacity=0.800;
        bobappear.start();
}

    function close(){
        root.opacity=0
        root.destroy(500);
    }

    SmoothedAnimation {id: bobappear; target: bob; property:"anchors.bottomMargin"; to:0; duration: 800}
    Rectangle{height: 80; id: bob; color: colour ;anchors{right: parent.right; left: parent.left; bottom: parent.bottom; bottomMargin: -90}
        MenuButtonLabel{id:find ; anchors.horizontalCenterOffset:screen.width===640? 140: 120; anchors.verticalCenterOffset: -6;imgSource: "../img/search_flat.svg"; buttonText: "Find Text" ;anchors{verticalCenter: parent.verticalCenter;horizontalCenter: parent.horizontalCenter} onClicked:{close();showTextFinder();}}
        MenuButtonLabel{id:resetzoom ; anchors.verticalCenterOffset: -6;imgSource: "../img/undo.svg"; buttonText: "Reset Zoom" ;anchors{verticalCenter: parent.verticalCenter;horizontalCenter: parent.horizontalCenter} onClicked:{close();webView.contentsScale=1.0}}

        MenuButtonLabel{id: sel; anchors.horizontalCenterOffset: screen.width===640? -140: -120;anchors.verticalCenterOffset: -6;imgSource: "../img/selectAll.svg"; buttonText: "Select All" ;anchors{verticalCenter: parent.verticalCenter;horizontalCenter: parent.horizontalCenter} onClicked:{close();webView.selectAll.trigger();}}

        MenuButtonLabel{id: zoomin; anchors.horizontalCenterOffset:260;anchors.verticalCenterOffset: -6;imgSource: "../img/zoom_in.svg"; buttonText: "Zoom In" ;anchors{verticalCenter: parent.verticalCenter;horizontalCenter: parent.horizontalCenter} onClicked:{if (webView.contentsScale>3.0){} else{webView.contentsScale+=0.3}}}
        MenuButtonLabel{id: zoomout; anchors.horizontalCenterOffset:-260;anchors.verticalCenterOffset: -6;imgSource: "../img/zoom_out.svg"; buttonText: "Zoom Out" ;anchors{verticalCenter: parent.verticalCenter;horizontalCenter: parent.horizontalCenter} onClicked:{if (webView.contentsScale<1.0){} else{webView.contentsScale-=0.3}}

    }


}
}
