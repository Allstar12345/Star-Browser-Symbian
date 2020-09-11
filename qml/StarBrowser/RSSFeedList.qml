/**
Copyright (C) 2020 Allstar Software (Paul Wallace)
*/
import QtQuick 1.1
import com.nokia.symbian 1.1

Rectangle{
    id: root1
    anchors.fill: parent
    color: "black"
    property bool shareMode:false
    onShareModeChanged: {if(shareMode==true){
            banner.showText("Tap Feed Item you want to share")
        }
    }
    z: 10
    Component.onCompleted: {root1.opacity=1;toolbarappeardelay.start();webViewHidden=true}
    Behavior on opacity{NumberAnimation{}}
     Timer{id: toolbarappeardelay; interval: 200; onTriggered: {toolbar.appear();}}
    Timer{id: killtimer;interval: 200; onTriggered: {root1.destroy();}}
    function closeList(){
       webViewHidden=false
        root1.opacity= 0
        killtimer.start()
    }
    TopToolBar{
        id: toolbar

               ToolButtonSense {
                   id: btnBack
                   anchors.left:parent.left
                   imgsource: "img/back_flat.svg"
                   onClicked: {
                      closeList();
                }
             }
               ToolButtonSense {
                   anchors{left:parent.left; leftMargin:screen.width===640? 160:100}
                   imgsource: "img/refresh_holdcontrol.svg"
                   onClicked: {
                       feedModel.source=""
                       feedModel.source=currentFeed
                }
             }
               ToolButtonSense{
                   opacity:feedModel.progress===1? true:false
                   buttonPressed: shareMode
                   imgsource: "img/share_flat.svg"
                   anchors{right:parent.right; rightMargin:screen.width===640? 160:100}
                   onClicked: {
                       if(shareMode==true)shareMode=false
                       else shareMode=true
                   }
               }
               BusyIndicator{anchors{right:parent.right; rightMargin: 2}
                   height: parent.height-5
                   width: parent.height-5
                   running: feedModel.progress===1? false: true
                   visible: feedModel.progress===1? false: true
                   z: 3
               }
               }

    XmlListModel {
        id: feedModel
        source: currentFeed
        query: "/rss/channel/item"
        onProgressChanged: {
            console.debug(feedModel.progress)
          }
        XmlRole { name: "title"; query: "title/string()" }
        XmlRole { name: "link"; query: "link/string()" }
        XmlRole { name: "description"; query: "description/string()" }
    }
    ListHeader {
        z: 5
        anchors.top: toolbar.bottom
        id: sectionHeading
headerText:currentFeedName
    }

    ListView {
        footer: Rectangle{anchors{right:parent.right; left: parent.left}color: popupbutton.color; height: 0.6}
        id: list
        anchors{top:sectionHeading.bottom;right: parent.right;left: parent.left;bottom: parent.bottom}
        model: feedModel
        delegate: RSSDelegate {}
    }
}
