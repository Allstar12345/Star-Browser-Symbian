/**
Copyright (C) 2020 Allstar Software (Paul Wallace)
*/
import QtQuick 1.1
import com.nokia.symbian 1.1

 Item {
     id: delegate
     height: column.height + 15
     anchors{left: parent.left;right:parent.right}
     property Component sharer: null
     property Component oper: null

     MouseArea{id: mouse; z:1; anchors.fill: parent; onClicked:{
             if(shareMode==true){if (!sharer) sharer = Qt.createComponent("RSSFeeds/ShareAreaRSS.qml")
                 sharer.createObject(root1); shareMode=false}
             else{if (!oper) oper = Qt.createComponent("RSSFeeds/FeedWindowChooser.qml")
                 oper.createObject(root1);} }
     }
     Rectangle{Behavior on opacity {NumberAnimation{duration: 200}} id: cover; anchors.fill: parent; color:popupbutton.colour; opacity: mouse.pressed? 0.7:0}


     Column {
         id: column
         anchors{right: parent.right;left: parent.left}
         Text {
             id: titleText
             text: title; wrapMode: Text.WordWrap
             anchors{top: parent.top; left:parent.left;leftMargin:2; topMargin: 2; horizontalCenter: parent.horizontalCenter}
             z: 5
             color: shareMode? "white": "red"
             font {bold: true; family: "Helvetica"; pointSize: 5.2}
         }
         Rectangle{opacity: 0.7; anchors{left:parent.left;right: parent.right; top: titleText.bottom; topMargin: 5} color:"transparent"; height: 2}

             Text {
                 id: descriptionText
                 text: description
                 width: parent.width
                 elide: Text.ElideLeft
                 wrapMode: Text.WordWrap; font.family: "Helvetica"
                 font.pointSize: 5
                 color: "white"
                 z:5
             }
     }

     Rectangle {
         width: parent.width; height: 1; color: "#cccccc"
         anchors.bottom: parent.bottom
     }
 }
