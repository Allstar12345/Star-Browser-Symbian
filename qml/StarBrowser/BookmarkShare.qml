/**
Copyright (C) 2020 Allstar Software (Paul Wallace)
*/
import QtQuick 1.1
import com.nokia.symbian 1.1

AppPage {
    Component.onCompleted: {show(); toolbar.appear(); listappear.start();}
    Component.onDestruction: {console.debug ("Share Destroyed") }
    Timer{interval: 450; id: listappear; onTriggered:{flickable1.opacity=1}}
    colour: "black"
    id: root
TopToolBar{
    setDuration: "400"
    id: toolbar
        ToolButtonSense {
            id: btnBack
            imgsource: "img/back_flat.svg"
            onClicked: {close(); }}
        }
Flickable {
    id: flickable1
    opacity: 0
    Behavior on opacity {NumberAnimation{}}
    anchors.bottom: parent.bottom
    anchors.right: parent.right
    anchors.left: parent.left
    anchors.top: toolbar.bottom
    contentHeight: column.height
    contentWidth: column.width
Column {
    id: column
   spacing: 1
   ListHeader {
       id: sectionHeading
       headerText: "Share A Bookmark"
   }
   ListItemer {
        id: fb
        height: 100
        onClicked: {
            web_view1.url= "http://mbasic.facebook.com/sharer.php?u="+"&t="+ bmView.currentItem.myData.url
             close();
              closePage();
        }
        ListItemText {
            width: 125
            height: 32
            role: "Title"
            text: "Facebook"
            font.pointSize: 20
            anchors.verticalCenter: parent.verticalCenter
        }
        Image{
            anchors.right: parent.right
            anchors.rightMargin: 0
            anchors.verticalCenter: parent.verticalCenter
            source: "img/facebook.svg"
        }

    }
   ListItemer {
        id: twit
        height: 100
        onClicked: {
            web_view1.url="http://mobile.twitter.com/home?status=Currently reading " + bmView.currentItem.myData.url
            close();
              closePage();
        }

        ListItemText {
            width: 96
            height: 32
            role: "Title"
            text: "Twitter"
            font.pointSize: 20
            anchors.verticalCenter: parent.verticalCenter
        }
        Image{
            anchors.right: parent.right
            anchors.rightMargin: 0
            anchors.verticalCenter: parent.verticalCenter
            source: "img/twitter.svg"
        }
    }

   ListItemer {
        id: email
        height: 100
        onClicked: {
            Qt.openUrlExternally("mailto:?subject= " +"body=" +  bmView.currentItem.myData.url )
        }
        ListItemText {
            width: 125
            height: 32
            role: "Title"
            text: "Email"
            font.pointSize: 20
            anchors.verticalCenter: parent.verticalCenter
        }
        Image{
            anchors.right: parent.right
            anchors.rightMargin: 10
            anchors.verticalCenter: parent.verticalCenter
            source: "img/mail_flat.svg"
        }

    }

   ListItemer {
        id: sms
        height: 100
        onClicked: {
            Qt.openUrlExternally("sms:" + "?body=" + bmView.currentItem.myData.url)

        }
        ListItemText {
            width: 125
            height: 32
            role: "Title"
            text: "SMS"
            font.pointSize: 20
            anchors.verticalCenter: parent.verticalCenter
        }
        Image{
            anchors.right: parent.right
            anchors.rightMargin: 10
            anchors.verticalCenter: parent.verticalCenter
            source: "img/messaging_flat.svg"
        }

    }
}
}

}
