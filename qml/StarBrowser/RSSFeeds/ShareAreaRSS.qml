/**
Copyright (C) 2020 Allstar Software (Paul Wallace)
*/
import QtQuick 1.1
import com.nokia.symbian 1.1
import "../"

AppPage {
    Component.onCompleted: {show(); toolbar.appear(); listappear.start(); linker =link; urls=link}
    Component.onDestruction: {console.debug ("Share Destroyed") }
    Timer{interval: 450; id: listappear; onTriggered:{flickable1.opacity=1}}
    colour: "black"
    id: roots
    property string linker:""
    property string urls: ""
    property Component __fbshare: null
TopToolBar{
    setDuration: "400"
    id: toolbar
        ToolButtonSense {
            id: btnBack
            imgsource: "../img/back_flat.svg"
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
       headerText:"Share A RSS Story"
   }
   ListItemer {
        id: fb
        height: 100
        onClicked: {
            if (!__fbshare) __fbshare = Qt.createComponent("../SocialShare/FacebookLoginWizard.qml")
                    __fbshare.createObject(basepage)
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
            source: "../img/facebook.svg"
        }

    }
   ListItemer {
        id: twit
        height: 100
        onClicked: {
            web_view1.url="http://mobile.twitter.com/home?status=Currently reading " + linker
            close();
            closeList();
            root.destroy();
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
            source: "../img/twitter.svg"
        }
    }

   ListItemer {
        id: email
        height: 100
        onClicked: {
            Qt.openUrlExternally("mailto:?subject= " +"body=" +  linker )
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
            source: "../img/mail_flat.svg"
        }

    }

   ListItemer {
        id: sms
        height: 100
        onClicked: {
            Qt.openUrlExternally("sms:" + "?body=" + linker)

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
            source: "../img/messaging_flat.svg"
        }

    }
}
}

}
