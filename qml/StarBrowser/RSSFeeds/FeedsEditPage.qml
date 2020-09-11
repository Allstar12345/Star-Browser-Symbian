/**
Copyright (C) 2020 Allstar Software (Paul Wallace)
*/
import QtQuick 1.1
import com.nokia.symbian 1.1
import "../feeds.js" as Feeds
import "../"

AppPage{
    id: edit
    colour: "black"
    onWidthChanged: {if(screen.width===360) {if(url.focus===true){toolbar.appear()}}
        if(screen.width===640){
            if(url.focus===true){
            toolbar.disappear();}
        }
    }
    Component.onCompleted: {show();Feeds.openDB();toolbar.appear();listappear.start();}
    Timer{interval: 450; id: listappear; onTriggered:{flick.opacity=1}}
     TopToolBar{id: toolbar; setDuration: "400"
    ToolButtonSense{anchors.left: parent.left;imgsource: "../img/back_flat.svg"
        onClicked: {close()}}
    ToolButtonSense{anchors.right: parent.right;imgsource: "../img/save.svg"
        onClicked: {  var itemsave = Feeds.readFeedItem(bmView.currentItem.myData.id);
            itemsave.title = title.text;
            itemsave.url = url.text;
            Feeds.updateFeed(itemsave);
           updateList();
            banner.showText("Feed Updated");
            close();}
     }
     }

     ListHeader {
         anchors.top: toolbar.bottom
         id: sectionHeading
         z: 2
         headerText:"Edit Feed"
     }
    Flickable{id: flick; visible: true
    anchors{right:parent.right;left:parent.left; top:sectionHeading.bottom; bottom:edit.bottom}
    contentHeight: parent.height
    contentWidth: parent.width
    Behavior on opacity {NumberAnimation{}}
    opacity: 0

       TextField{
        id: title
        placeholderText: "Title"
        errorHighlight: title.text? false: true
        text: bmView.currentItem.myData.title
        height: 50
        anchors{right: parent.right;left: parent.left;top:parent.top; topMargin:2}
    }
       TextField{
        id: url
         height: 50
        text: bmView.currentItem.myData.url
        placeholderText: "URL"
        onActiveFocusChanged: {if(screen.height===360){
                if(url.focus===true){toolbar.disappear(); }
                else if (url.focus===false){toolbar.appear();}

            }}
        anchors{right: parent.right;left: parent.left;top:title.bottom; topMargin:5 }
    }

       ListItemer {
            anchors.top:url.bottom
            anchors.topMargin: 5
            id: cdl
            enabled: false
            Column { anchors.fill: cdl.paddingItem
            ListItemText {
                role: "Title"
                text: "Creation Date"

            }
            ListItemText {
                id: cdl1
                role: "SubTitle"
                mode: cdl.mode
                text:  bmView.currentItem.myData.creationdate
            }  }
   }

}
}
