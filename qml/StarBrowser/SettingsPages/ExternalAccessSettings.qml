/**
Copyright (C) 2020 Allstar Software (Paul Wallace)
*/
import QtQuick 1.1
import com.nokia.symbian 1.1
import "../"


AppPage{
    Component.onDestruction: { console.debug ("external Destroyed")}
color: "black"
Component.onCompleted: {show();listappear.start(); toolbar.appear();}
id: external
Timer{interval: 430; id: listappear; onTriggered:{flickable.opacity=1}}
TopToolBar{
    setDuration: "400"
    id: toolbar
    ToolButtonSense {
        id: btnBac
        imgsource: "../img/back_flat.svg"
        onClicked: {close()
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
       headerText:"External Access Settings"
   }
   ListItemer {
              id: ext
              height: 80
              enabled: false
               Column { anchors.fill: ext.paddingItem
              ListItemText {
                  role: "Title"
                  text: "Incoming URL Dialog"
                  anchors.fill: parent.paddingItem
              }
              ListItemText {
                  role: "SubTitle"
                  mode: ext.mode
                  text: screen.width===640?  "Ask permission when incoming URL is detected": "Ask permission when incoming URL\nis detected"
              }
               }
              Switcher{
                  id: extbox
                  anchors.right: parent.right
                  anchors.rightMargin: 1
                  anchors.verticalCenter: parent.verticalCenter
                  checked: appsettings.getSetting()? true: false
                  onClicked: {
                      if(appsettings.getSetting()=== true){appsettings.saveSetting(false);}
                      else {if(appsettings.getSetting()=== false){appsettings.saveSetting(true);}
                      }


                  }
         }
   }
}
}
}
