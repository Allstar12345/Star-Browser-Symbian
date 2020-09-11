/**
Copyright (C) 2020 Allstar Software (Paul Wallace)
*/
import QtQuick 1.1
import com.nokia.symbian 1.1
import DownloadBackend 1.0
import "../"
Rectangle{
    id: root
    anchors.fill: parent
    color: "black"
    property string name
    z:2
    property Component a: null
    Component.onCompleted: {root.opacity=1;toolbarappeardelay.start();webViewHidden=true; }
    Behavior on opacity{NumberAnimation{}}
    Timer{interval: 1150; id: listappear; onTriggered:{bmView.opacity=1}}
    Timer{id: toolbarappeardelay; interval: 200; onTriggered: {toolbar.appear();}}
    function closePage(){imgViewerOpen=false; root.opacity=0;root.destroy(); webViewHidden=false;}
    function openSaveChooser(){if (!a) a = Qt.createComponent("WebImageViewerFileTypeChooser.qml")
        a.createObject(root)}
DownloadBackend{id: download}
    TopToolBar{
        id: toolbar
               ToolButtonSense {
                   id: btnBack
                   anchors.left: parent.left
                   imgsource: "../img/back_flat.svg"
                   onClicked: {
                       closePage();
                }
             }
ToolButtonSense{
    imgsource: "../img/save.svg"
    id: saveBut
     visible: requestedImageURL.indexOf("file:///") > -1 ? false:true
    anchors.centerIn: parent
    onClicked:{openSaveChooser()}
}

               ToolButtonSense{
                   id: reload
                   imgsource: "../img/refresh.svg"
                   anchors.right:parent.right
                   onClicked: {img.source=""; img.source= requestedImageURL;}
               }
               }
    ToolButtonSenseFloat{
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.horizontalCenterOffset: -50
        anchors.bottom: parent.bottom
        anchors.bottomMargin: 10
        id: zoomout
        z:1
        imgsource: "../img/zoom_out.svg"
        onClicked: {if (flick.scale < 1){zoomout.opacity=0}else{flick.scale-=0.5; zoomin.opacity=1}}
    }
    ToolButtonSenseFloat{
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.horizontalCenterOffset: 50
        anchors.bottom: parent.bottom
        anchors.bottomMargin: 10
        z:1
        id: zoomin
        imgsource: "../img/zoom_in.svg"
        onClicked: {if(flick.scale == 2.0){zoomin.opacity=0} else{flick.scale+=0.5; zoomout.opacity=1}}
    }

    BusyIndicator{id: bind; running: true; Behavior on opacity {NumberAnimation{}}anchors.centerIn: parent; height: 60;width: 60;}
     Flickable{id: flick;contentHeight: img.height
         Behavior on scale {NumberAnimation{}}

         contentWidth: img.width;boundsBehavior: "DragOverBounds"
         flickableDirection: Flickable.AutoFlickDirection;anchors{top: toolbar.bottom;bottom: parent.bottom;right: parent.right; left: parent.left;}
     /*    function fitToScreen() {
        scale = Math.min(flick.width / width, flick.height / height, 1)
        pinchArea.minScale = scale
        prevScale = scale
        }
         property real prevScale
         PinchArea {
         id: pinchArea
         property real minScale: 1.0
         property real maxScale: 3.0
         anchors.fill: parent
         enabled: img.status === Image.Ready
         pinch.target: img
         pinch.minimumScale: minScale * 0.5 // This is to create "bounce back effect"
         pinch.maximumScale: maxScale * 1.5 // when over zoomed
         onPinchFinished: {
         flick.returnToBounds()
         if (img.scale < pinchArea.minScale) {
         bounceBackAnimation.to = pinchArea.minScale
         bounceBackAnimation.start()
         }
         else if (img.scale > pinchArea.maxScale) {
         bounceBackAnimation.to = pinchArea.maxScale
         bounceBackAnimation.start()
         }
         }
         NumberAnimation {
         id: bounceBackAnimation
         target: img
         duration: 250
         property: "scale"
         from: img.scale
         }
         }*/

    AnimatedImage{

        id: img
        source: requestedImageURL
        anchors.centerIn: parent
        smooth: !flick.moving
        playing: true
        cache: false
        asynchronous: true
        fillMode: Image.PreserveAspectFit
        onSourceChanged: {console.debug("Source Changed"); console.log(img.source); }
        onStatusChanged: {if (img.status == Image.Ready) {bind.running=false;bind.opacity=0}}
       /* onScaleChanged: {
       if ((width * scale) > flick.width) {
       var xoff = (flick.width / 2 + flick.contentX) * scale / prevScale;
      flick.contentX = xoff - flick.width / 2
       }
       if ((height * scale) > flick.height) {
       var yoff = (flick.height / 2 + flick.contentY) * scale / prevScale;
       flick.contentY = yoff - flick.height / 2
       }
       prevScale = scale
       }*/
    }


         }
}
