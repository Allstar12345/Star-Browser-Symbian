/**
Copyright (C) 2020 Allstar Software (Paul Wallace)
*/
import QtQuick 1.1
import com.nokia.symbian 1.1

 Item {
     id: delegate
     height: column.height
     width:parent.width
     MouseArea{id: mouse; z:1; anchors.fill: parent; onClicked:{QMLUtils.openBrowser(link)}}
     Rectangle{Behavior on opacity {NumberAnimation{duration: 200}} id: cover; anchors.fill: parent; color:popupbutton.colour; opacity: mouse.pressed? 0.7:0}


     Column {
         id: column
         anchors{right: parent.right;left: parent.left}
         Image{
             id: imager
             width: 70
             height: 70
             onStateChanged: {}
             anchors{left:parent.left; leftMargin:5;}
             asynchronous: true
             source:image
             BusyIndicator{
                 anchors.centerIn: parent
                 height: 40
                 width: 40
                 visible: imager.progress===1.0?false:true
                 running: imager.progress===1.0?false:true
             }
         }
         Text {
             id: titleText
             text: name; wrapMode: Text.WordWrap
             anchors{top: parent.top; left:imager.right;leftMargin:5; topMargin: 2; horizontalCenter: parent.horizontalCenter}
             z: 5
             color: "white"
             font {bold: true; family: "Helvetica"; pointSize: 9}
         }     }

     Rectangle {
         width: parent.width; height: 1; color: "#cccccc"
         anchors.bottom: parent.bottom
     }
 }
