/**
Copyright (C) 2020 Allstar Software (Paul Wallace)
*/
import QtQuick 1.1
import com.nokia.symbian 1.1
import "../"
AppPage {
    Component.onDestruction: {console.debug ("Security Destroyed")}
colour: "black"
id: otheruserarea
QtObject { id: create; property Component com: null;function createComponent (qmlfile){com = Qt.createComponent(qmlfile);com.createObject(otheruserarea)} }

function openSecurityReset(){create.createComponent(Qt.resolvedUrl("SecurityResetDialog.qml"));}

    Component.onCompleted: {
        console.debug("Security Opened")
        show();
        toolbar.appear()
        contentappear.start();
        }
    Timer{id: contentappear; interval:550; onTriggered: {flick1.opacity=1}}


TopToolBar{
    id: toolbar
    setDuration: "500"
            ToolButtonSense {
                id: btnBack
                imgsource: "../img/back_flat.svg"
                onClicked: {close()
             }
          }
            }
   Flickable{
       id: flick1
       visible: true
       opacity: 0
       Behavior on opacity {NumberAnimation{}}
       anchors.left: parent.left
       anchors.right: parent.right
       anchors.top: toolbar.bottom
       anchors.bottom: parent.bottom
       contentHeight: col.height
       contentWidth: col.width

       Column{
           id: col
           ListItemer {
                id: rm
                enabled: false
                 Column { anchors.fill: rm.paddingItem

                  ListItemText {
                    role: "Title"
                    text: "Restricted Mode"
                    anchors.fill: rm.paddingItem
                }
                  ListItemText {
                      role: "SubTitle"
                      mode: rm.mode
                      text:"Disables sensitive options"
                  }
                 }

                Switcher{
                     anchors.right: parent.right
                    anchors.rightMargin: 1
                    anchors.verticalCenter: parent.verticalCenter
                    checked: appsettings.getSystemSetting("pm", "")?true: false
                    onClicked: {
                        if(appsettings.getSystemSetting("pm", "")===""){appsettings.saveSystemSetting("pm", "enabled"); sensitiveMode=true;}
                        else{if(appsettings.getSystemSetting("pm", "")==="enabled"){appsettings.saveSystemSetting ("pm", ""); sensitiveMode=false;}}
                    }
                }
           }
           ListItemer {
                id: askp
                enabled: false
                 Column { anchors.fill:  askp.paddingItem

                  ListItemText {
                    role: "Title"
                    text: "Ask For Password"
                    anchors.fill:  askp.paddingItem
                }
                  ListItemText {
                      role: "SubTitle"
                      mode:  askp.mode
                      text:"Asks for password on startup"
                  }
                 }

                Switcher{
                     anchors.right: parent.right
                    anchors.rightMargin: 1
                    anchors.verticalCenter: parent.verticalCenter
                    checked:  appsettings.saveSystemSetting("spa", "")===""?true:false
                    onClicked: {
                        if(appsettings.getSystemSetting("spa", "")===""){appsettings.saveSystemSetting("spa", "enabled")}
                        else{if(appsettings.getSystemSetting("spa", "")==="enabled"){appsettings.saveSystemSetting ("spa", "")}}
                    }
                }
           }
        /*   ListItem {
                id: tml
                enabled: false
                 Column { anchors.fill: tml.paddingItem

                  ListItemText {
                    role: "Title"
                    text: "Usage Time Limit"
                    anchors.fill:  tml.paddingItem
                }
                  ListItemText {
                      role: "SubTitle"
                      mode: tml.mode
                      text:"Disable the App after a set time"
                  }
                 }

                Switcher{
                     anchors.right: parent.right
                    anchors.rightMargin: 1
                    anchors.verticalCenter: parent.verticalCenter
                    checked: Setting.get("utl")?true: false
                    onClicked: {
                        if(Setting.get("utl")===""){Setting.set("utl", "enabled")}
                        else{if(Setting.get("utl")==="enabled"){Setting.clear("utl")}}
                    }
                }
           }
           ListItem{
               id: killintervalbox
               onClicked:{}
                 Column { anchors.fill: killintervalbox.paddingItem

               ListItemText {
                 role: "Title"
                 text: "Usage Time Limit Duration"
                 anchors.fill:  killintervalbox.paddingItem
             }
               ListItemText {
                   role: "SubTitle"
                   mode: killintervalbox.mode
                   text:"Duration to disable App"
               }
                 }

           }*/
           ListItemer {
                id: cp
                enabled: true
                subItemIndicator: true
                onClicked:{
                    openPassChange()
                }

              ListItemText {
                    role: "Title"
                    text: "Change Password"
                    anchors.fill: cp.paddingItem
                }
                }

       }

   }


}
