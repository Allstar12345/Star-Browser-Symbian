/**
Copyright (C) 2020 Allstar Software (Paul Wallace)
*/
import QtQuick 1.1
import com.nokia.symbian 1.1
import "../"
import "../ComponentsSB"

AppPage{
Component.onDestruction: { console.debug ("cachevset Destroyed")}
color: "black"
Component.onCompleted: {show();listappear.start(); toolbar.appear();}
id: cacheset
Timer{interval: 430; id: listappear; onTriggered:{flickable.opacity=1;}}
TopToolBar{
    setDuration: "400"
    id: toolbar
    ToolButtonSense {
        id: btnBac
        imgsource: "../img/back_flat.svg"
        onClicked: {close();
     }
  }
}

Flickable {
    Behavior on opacity {NumberAnimation{}}
    id: flickable
    opacity: 0
    anchors.bottom: parent.bottom
    anchors.right: parent.right
    anchors.left: parent.left
    anchors.top:toolbar.bottom
    contentHeight: columnsett.height
    contentWidth: columnsett.width

Column {
    id: columnsett
   spacing: 1

   ListHeader {
       id: header
       z: 1
       headerText:"Cache Settings"
   }

   ListItemer {
              id: cookies
              enabled: false
               Column { anchors.fill: parent.paddingItem
              ListItemText {
                  role: "Title"
                  text: "Save Browsing Cookies"
                  anchors.fill: parent.paddingItem
              }
               }
              Switcher{
                  enabled: privateBrowsing?false: true
                  id:cookiessw
                  anchors.right: parent.right
                  anchors.rightMargin: 1
                  anchors.verticalCenter: parent.verticalCenter
                  checked: appsettings.getSystemSetting("browsingCookies", "true")
                  onClicked: {
                      if(appsettings.getSystemSetting("browsingCookies", "true")==="false"){appsettings.saveSystemSetting("browsingCookies", "true")}
                      else{ appsettings.saveSystemSetting("browsingCookies", "false")}
                  }
         }
   }
   ListItemer {
        id: cookiesclear
        enabled: true
        onClicked:{
            if (sensitiveMode=== true){banner.showText ("Access Denied, Private Mode Activated");}
            else{opencookies();}
        }
        ListItemText {
            role: "Title"
            text: "Clear Cookies"
            anchors.fill: cookiesclear.paddingItem
        }
        }


   ListHeader {
       id: headere
       z: 1
       headerText:"The following need a restart"
   }
   ListItemer {
              id: nam
              enabled: false
               Column { anchors.fill: parent.paddingItem
              ListItemText {
                  role: "Title"
                  text: "Web Cache"
                  anchors.fill: parent.paddingItem
              }
               }
              Switcher{
                  id:namsw
                  anchors.right: parent.right
                  anchors.rightMargin: 1
                  anchors.verticalCenter: parent.verticalCenter
                  checked: appsettings.getSystemSetting("diskCache", "true")
                  onClicked: {
                      if(appsettings.getSystemSetting("diskCache", "true")==="false"){appsettings.saveSystemSetting("diskCache", "true"); setrestart()}
                      else{ appsettings.saveSystemSetting("diskCache", "false"); setrestart()}
                  }
         }
   }
}
}
}
