/**
Copyright (C) 2020 Allstar Software (Paul Wallace)
*/
import QtQuick 1.1
import com.nokia.symbian 1.1

AppPage{
    colour:"black"
    id: page
    pageId: "1"
    property string title: ""
    property string urls: ""
    Component.onCompleted: {
        show();
        title= web_view1.title;
        urls=web_view1.url;
        url.selectAll();
        url.copy();
        toolbarappeardelay.start();
        listappear.start();
    }

    Timer{interval: 1000; id: listappear; onTriggered:{flickable1.opacity=1}}
    Timer{id: toolbarappeardelay; interval: 200; onTriggered: {toolbar.appear();}}
opacity: 0
 property Component __fbshare: null
anchors.fill: parent
z: 5
TopToolBar{
    id: toolbar
        ToolButtonSense {
            id: btnBack
            imgsource: "img/back_flat.svg"
            onClicked: {
                close();
         }
      }
        }
Flickable {
    id: flickable1
    opacity: 0
    Behavior on opacity{NumberAnimation{}}
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
       headerText:"Share"

   }
   TextField{
       id: url
       text:urls
       anchors.right: parent.right
       anchors.left: parent.left
       anchors.top: sectionHeading.bottom
       anchors.topMargin: 5
       placeholderText: "Last Visited Url"
   }

   ListItemer {
        id: fb
        height: 100
        onClicked: {
          web_view1.url= "http://mbasic.facebook.com/sharer.php?u="+urls+"&t="+title
              close();
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
       web_view1.url="http://mobile.twitter.com/home?status=Currently reading " + urls
           close();
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
            Qt.openUrlExternally("mailto:?subject= " +"body=" + urls )
            close();

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
            Qt.openUrlExternally("sms:" + "?body=" + urls)
             close();
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
