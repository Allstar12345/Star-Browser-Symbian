/**
Copyright (C) 2020 Allstar Software (Paul Wallace)
*/
import QtQuick 1.1
import com.nokia.symbian 1.1
import QtMobility.systeminfo 1.1

AppPage {
    DeviceInfo{id: info}
    Component.onCompleted: {
        show();
        listappear.start();
        toolbar.appear();
    }
    Component.onDestruction: {
        console.debug ("Help Destroyed")
    }
color: "black"
id: root
QtObject { id: create; property Component com: null;function createComponent (qmlfile){com = Qt.createComponent(qmlfile);com.createObject(root)} }

Timer{interval: 430; id: listappear; onTriggered:{flickable1.opacity=1}}
   TopToolBar{
       id:toolbar
       setDuration: "400"
            ToolButtonSense {
                id: btnBack
                imgsource: "toolbar-back"
                onClicked: {
                    close();
             }
          }
            }
    Flickable {
        opacity:0
        Behavior on opacity{NumberAnimation{}}
        id: flickable1
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
           headerText:"Star Browser Tips"

       }

       ListItemer {
            id: butsmb
            onClicked: {create.createComponent(Qt.resolvedUrl("UserTips/ButtonsDef.qml")); }

            ListItemText {
                role: "Title"
                text: "What The Button Symbols Stand For"
                anchors.centerIn: parent
            }
        }
       ListItemer {
            id: toolm
            onClicked: { create.createComponent(Qt.resolvedUrl("UserTips/StartupToolMenu.qml"));}
            ListItemText {
                role: "Title"
                text: "Extra Tool Menu"
                anchors.centerIn: parent
            }
        }
       ListItemer {
            id: hompepage
            onClicked: { create.createComponent(Qt.resolvedUrl("UserTips/Homepage.qml")); }

            ListItemText {
                role: "Title"
                text: "Setting The Homepage"
                anchors.centerIn: parent
            }
        }

       ListItemer {
            id: videoplayer
            onClicked: {create.createComponent(Qt.resolvedUrl("UserTips/HTML5Player.qml"));}
            ListItemText {
                role: "Title"
                text: "HTML 5 Video Player"
                anchors.centerIn: parent
            }
        }
         ListItemer {
           id: nightcoverl
           onClicked: {create.createComponent(Qt.resolvedUrl("UserTips/NightCover.qml"));}
           ListItemText {
               role: "Title"
               text: "Night Cover"
               anchors.centerIn: parent
           }
       }
         ListItemer {
           id: qame
           onClicked: {create.createComponent(Qt.resolvedUrl("UserTips/QAButton.qml"));}
           ListItemText {
               role: "Title"
               text: "Quick Access Button (Menu Button)"
               anchors.centerIn: parent
           }
       }
         ListItemer {
           id: usb
           visible:info.model==="500"? false:true
           onClicked: { create.createComponent(Qt.resolvedUrl("UserTips/USBKeyboard.qml"));}
           ListItemText {
               role: "Title"
               text: "USB Keyboard Support"
               anchors.centerIn: parent
           }
       }
         ListItemer {
              id: down
              onClicked: {create.createComponent(Qt.resolvedUrl("UserTips/FileDownloading.qml"));}
              ListItemText {
                  role: "Title"
                  text: "Downloading A File"
                  anchors.centerIn: parent
              }
          }

    }


}
}
