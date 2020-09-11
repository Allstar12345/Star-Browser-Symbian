/**
Copyright (C) 2020 Allstar Software (Paul Wallace)
*/
import QtQuick 1.1
import com.nokia.symbian 1.1
import "../"

ListItemer{
    id: root
    height: expanded?150: 90
    property bool expanded:false
  onClicked: {expanded===true? expanded=false:expanded=true}
    property bool downloadActive
    property bool downloadPaused
    property alias text: title.text
    property alias subText: subtitleText.text
    property alias downloadProgress:progress.value
  signal pauseStartClicked
  signal stopClicked
    Behavior on height {NumberAnimation{}}

        ListItemText {
             role: "Title"
             id: title
            anchors.fill: parent.paddingItem
         }
         ListItemText {
             id: subtitleText
             opacity: expanded? 1:0
             Behavior on opacity {NumberAnimation{}}
             anchors{left:parent.left; leftMargin: 10; bottom:parent.bottom; bottomMargin:10}
             role: "SubTitle"
             mode: root.mode
         }

         ProgressBar{
             indeterminate: false
             id: progress
             anchors{
                 bottom:parent.bottom; bottomMargin:expanded? 60:5; right:parent.right; left:parent.left; rightMargin:10; leftMargin:10}
             minimumValue: 0.0
             maximumValue: 1.0
         }

         ToolButtonSenseFloat{buttonBackground: false; anchors{right:parent.right; rightMargin: 10; bottom:parent.bottom} imgsource: "../img/stop.svg"
             opacity: expanded? 1:0
             Behavior on opacity {NumberAnimation{}}
             onClicked:{stopClicked();}
         }
         ToolButtonSenseFloat{buttonBackground: false;anchors{right:parent.right; rightMargin: 60; bottom:parent.bottom} imgsource: downloadPaused?"../img/play.svg": "../img/pause.svg"
             opacity: expanded? 1:0
             Behavior on opacity {NumberAnimation{}}
             onClicked:{pauseStartClicked();}
         }


}
