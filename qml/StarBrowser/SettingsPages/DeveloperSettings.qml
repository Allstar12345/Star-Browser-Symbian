/**
Copyright (C) 2020 Allstar Software (Paul Wallace)
*/
import QtQuick 1.1
import com.nokia.symbian 1.1
import AppSettings 1.0
import "../"
import "../ComponentsSB"


AppPage{
    property string switchSource: appsettings.getSystemSetting("switchsource", "") ? appsettings.getSystemSetting("switchsource", ""): "img/Switch/qtg_graf_switchbutton_fill.svg";

    Component.onDestruction: { console.debug ("webdev Destroyed")}
color: "black"
Component.onCompleted: {show();listappear.start(); toolbar.appear();}
id: webdev
Timer{interval: 430; id: listappear; onTriggered:{flickable.opacity=1}}
AppSettings{id: appsettings}
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
       headerText:"Web Developer Settings"
   }

   ExtendingOptionsDialog{
       id: ext
       title:"JS Console Options"
       onClicked: {
           if(ext.open){h.opacity=0;open.opacity=0;ext.close();}
           else{
           ext.paneHeight=180; drillRotate();h.opacity=1;open.opacity=1; ext.open=true}
       }
       ListItemer{
           id: open
           enabled: QMLUtils.checkJSLog();
           height: 70
           opacity: 0
           anchors{top: parent.top; topMargin: 41; left: parent.left; right: parent.right}
           Behavior on opacity {NumberAnimation{duration: 300}}
           onClicked: {
               QMLUtils.openJSLog();
           }
           ListItemText {
               role: "Title"
               id: opent
               text:QMLUtils.checkJSLog()? "Open Log File": "No Log File Present"
               anchors.fill: open.paddingItem
           }

       }
       ListItemer{
           id: h
           height: 70
           enabled: QMLUtils.checkJSLog();
           opacity: 0
           anchors{top: parent.top; topMargin: 110; left: parent.left; right: parent.right}
           Behavior on opacity {NumberAnimation{duration: 300}}
           onClicked: {QMLUtils.removeJSLog(); banner.showText("Log Removed"); removeT.text=QMLUtils.checkJSLog()? "Remove Log File":  "No Log File Present"; opent.text=QMLUtils.checkJSLog()? "Open Log File": "No Log File Present";h.opacity=0;open.opacity=0;h.enabled=QMLUtils.checkJSLog();open.enabled=QMLUtils.checkJSLog(); ext.close();}
           ListItemText {
               role: "Title"
               id: removeT
               text:QMLUtils.checkJSLog()? "Remove Log File":  "No Log File Present"
               anchors.fill: parent.paddingItem
           }

       }
   }

   ListItemer {
              id: jsc
              visible: true
              height: 80
              enabled: false
               Column { anchors.fill: jsc.paddingItem
              ListItemText {
                  role: "Title"
                  text: "JavaScript Console Output"
                  anchors.fill: parent.paddingItem
              }
              ListItemText {
                  role: "SubTitle"
                  mode: jsc.mode
                  text: screen.width===640?  "JS Console Messages to File": "JS Console Messages to File"
              }
               }
              Switcher{
                  id: jscbox
                  anchors.right: parent.right
                  anchors.rightMargin: 1
                  anchors.verticalCenter: parent.verticalCenter
                  checked: appsettings.getJSSetting()? true: false
                  onClicked: {
                      if(appsettings.getJSSetting()=== true){appsettings.saveJSSetting(false);}
                      else {if(appsettings.getJSSetting()=== false){appsettings.saveJSSetting(true);}
                      }
                  }
         }
   }


}
}
}
