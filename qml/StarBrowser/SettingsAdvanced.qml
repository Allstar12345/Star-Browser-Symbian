/**
Copyright (C) 2020 Allstar Software (Paul Wallace)
*/
import QtQuick 1.1
import com.nokia.symbian 1.1



AppPage{
QtObject { id: create; property Component com: null;function createComponent (qmlfile){com = Qt.createComponent(qmlfile);com.createObject(ad)} }
function closePage(){close();}
colour: "black"
Component.onCompleted: {show();listappear.start(); toolbar.appear();}
id: ad
Timer{interval: 430; id: listappear; onTriggered:{flickable.opacity=1}}
function openuseragent(){create.createComponent(Qt.resolvedUrl("SettingsDialogs/UserAgentChooser.qml"));}
function opencustomuadialog(){ create.createComponent(Qt.resolvedUrl("SettingsDialogs/CustomUAChooser.qml"));}
function externalAccessSettings(){create.createComponent(Qt.resolvedUrl("SettingsPages/ExternalAccessSettings.qml"));}
function developerSettings(){create.createComponent(Qt.resolvedUrl("SettingsPages/DeveloperSettings.qml"));}
function openProxySettings(){create.createComponent(Qt.resolvedUrl("SettingsPages/NetworkProxySettings.qml"));}
TopToolBar{
    setDuration: "400"
    id: toolbar
    ToolButtonSense {
        id: btnBac
        imgsource: "img/back_flat.svg"
        onClicked: {closePage();
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
    maximumFlickVelocity: 300
    flickDeceleration: 2000
    Decorator{flickableItem: flickable; lightColours: true; }

Column {
    id: columnsett
   spacing: 1

   ListHeader {
       id: header
       z: 1
       headerText:"Advanced Settings"
   }
   ListItemer{
       enabled: false

 ListItemer{
      enabled: true
      id: exter
      width: screen.width===640? 320:180
      anchors.left: parent.left
      onClicked:{externalAccessSettings()}
      ListItemText {
           role: "Title"
           text: "External Access"
          anchors.fill: exter.paddingItem
       }
   }
   ListItemer{
      enabled: true
      id: dev
      width:screen.width===640? 320:180
      anchors.right: parent.right
      onClicked:{developerSettings()}
      ListItemText {
           role: "Title"
           text: screen.width===640?  "Web Developer Settings":"Dev Settings"
          anchors.fill: dev.paddingItem
       }
   }
   }
   ListItemer {
       subItemIndicator: true
       enabled: true
       onClicked: openProxySettings();
        id: networkproxy
        Column { anchors.fill: parent.paddingItem
            ListItemText {
                 role: "Title"
                 text: "Network Proxy Settings"
                anchors.fill: parent.paddingItem
             }
       }
   }
   ListItemer {
       height: 88
       enabled: false
        id: networkcheck
        Column { anchors.fill: parent.paddingItem
            ListItemText {
                 role: "Title"
                 text: "Auto Check For Network"
                anchors.fill: parent.paddingItem
             }
             ListItemText {
                 role: "SubTitle"
                 mode: networkcheck.mode
                 text: screen.width===360? "Checks for a Network Connection\nevery 5 Minutes": "Checks for a Network Connection every 5 Minutes"
             }
       }

        Switcher{
            id: networkcheckbox
            anchors.right: parent.right
            anchors.rightMargin: 1
            anchors.verticalCenter: parent.verticalCenter
            checked: appsettings.getSystemSetting("autocheck", "false") === "false"? false: true
            onClicked: {
                if (appsettings.getSystemSetting("autocheck", "false")=== "false"){appsettings.saveSystemSetting("autocheck", "true"); console.log(appsettings.getSystemSetting("autocheck", "false")); autonetworkcheck.running=true}
                else if (appsettings.getSystemSetting("autocheck", "false")=== "true") {appsettings.saveSystemSetting("autocheck", "false"); console.debug(appsettings.getSystemSetting("autocheck", "false")); autonetworkcheck.running=false}
        }
   }
   }
   ListItemer {
        id: scroll
        enabled: false

        Column { anchors.fill: scroll.paddingItem
        ListItemText {
            role: "Title"
            text: "Show Scroll Button"
            anchors.fill: parent.paddingItem
        }
        ListItemText {
            role: "SubTitle"
            mode: scroll.mode
            text: "Floating Page Scrolling Button"
        }
        }
        Switcher{
             anchors.right: parent.right
            anchors.rightMargin: 1
            anchors.verticalCenter: parent.verticalCenter
            checked: set_scroll
            onClicked: {
               set_scroll = checked;
               appsettings.saveSystemSetting("scrollbut",checked)
            }
        }
   }
   ListItemer {
        id: nightcovercheck
        enabled: false
        height: 88
             Column { anchors.fill: nightcovercheck.paddingItem
        ListItemText {
            role: "Title"
            text: "Night Cover Time Checker"
            anchors.fill: parent.paddingItem
        }
        ListItemText {
            role: "SubTitle"
            mode: nightcovercheck.mode
            text:screen.width===360?  "Asks if you want to enable Night\nCover when it gets late": "Asks if you want to enable Night Cover when it gets late"
        }
             }
        Switcher{
            id: nightcovercheckbox
            anchors.right: parent.right
            anchors.rightMargin: 1
            anchors.verticalCenter: parent.verticalCenter
            Component.onCompleted: {console.log("Night Cover Auto"+ appsettings.getSystemSetting("nightcoverauto", "true"))}
            checked: appsettings.getSystemSetting("nightcoverauto", "true") === "false"? false: true
            onClicked: {
                if (appsettings.getSystemSetting("nightcoverauto", "true")=== "false"){appsettings.saveSystemSetting("nightcoverauto", "true"); console.log(appsettings.getSystemSetting("nightcoverauto", "true")); nightcovertimecheck.running=true}
                else if (appsettings.getSystemSetting("nightcoverauto", "true")=== "true") {appsettings.saveSystemSetting("nightcoverauto", "false"); console.debug( appsettings.getSystemSetting("nightcoverauto", "true")); nightcovertimecheck.running=false}
        }
   }
   }
   ListItemer {
                 id: tsk
                 enabled: false
                  Column { anchors.fill: tsk.paddingItem
                 ListItemText {
                     role: "Title"
                     text: "Show In Task Manager"
                     anchors.fill: parent.paddingItem
                 }
                 ListItemText {
                     role: "SubTitle"
                     mode: tsk.mode
                     text:"Whether to show in TaskSwapper"
                 }
                  }
                 Switcher{
                     id: tskbox
                     anchors.right: parent.right
                     anchors.rightMargin: 1
                     anchors.verticalCenter: parent.verticalCenter
                     checked: appsettings.getSystemSetting("tskm", "") === ""? true: false
                     onClicked: {
                         if (appsettings.getSystemSetting("tskm", "")=== ""){appsettings.saveSystemSetting("tskm", "false"); console.debug(appsettings.getSystemSetting("tskm", "")); QMLUtils.hideFromSight();}
                         else {appsettings.saveSystemSetting("tskm", ""); console.debug (appsettings.getSystemSetting("tskm", "")); QMLUtils.showToTask();}
                     }
                 }
            }

   ListItemer {
                 id: key
                 visible: screen.height===480?false:true
                 height: 88
                 enabled: false
                  Column { anchors.fill: key.paddingItem
                 ListItemText {
                     role: "Title"
                     text: "Page Keyboard Detection"
                     anchors.fill: parent.paddingItem
                 }
                 ListItemText {
                     role: "SubTitle"
                     mode: key.mode
                     text:screen.width===360?  "Moves Page when Keyboard is opened\nto fit a TextInput (Experimental)":"Moves Page when Keyboard is opened to fit a TextInput (Experimental)"
                 }
                  }
                 Switcher{
                     id: keybox
                     anchors.right: parent.right
                     anchors.rightMargin: 1
                     anchors.verticalCenter: parent.verticalCenter
                     checked: appsettings.getSystemSetting("keyboardTextFieldMoveExperimental", "") === ""?false:true
                     onClicked: {
                         if(appsettings.getSystemSetting("keyboardTextFieldMoveExperimental", "")===""){appsettings.saveSystemSetting("keyboardTextFieldMoveExperimental", "true")}

                         else{appsettings.saveSystemSetting("keyboardTextFieldMoveExperimental", "")}
                     }

                 }
            }
   ListItemer {
        id: autoreload
        enabled: true
        subItemIndicator: true
        onClicked:{
                autoreloadduration()
        }
           Column { anchors.fill: autoreload.paddingItem
        ListItemText {
            role: "Title"
            text: "Auto Reload Duration"
            anchors.fill: parent.paddingItem
        }
        ListItemText {
            role: "SubTitle"
            mode: autoreload.mode
            text:"Page Auto Reload Period"
        }
           }
        }
   ListItemer {
       id: useragent
       subItemIndicator: true
       anchors.horizontalCenter: parent.horizontalCenter
       onClicked: openuseragent()
       Column { anchors.fill: useragent.paddingItem
    ListItemText {
        role: "Title"
        id: uatext
        text: appsettings.getSystemSetting("uatitle", "")== "" ? "Select a User Agent":appsettings.getSystemSetting("uatitle", "")
        anchors.fill: parent.paddingItem
    }
    ListItemText{
           role: "SubTitle"
           mode: useragent.mode
           text: "How StarBrowser identifies to the web"
       }

       }

   }
   ListItemer {
                 id: jsb
                 height: 88
                 enabled: false
                  Column { anchors.fill: jsb.paddingItem
                 ListItemText {
                     role: "Title"
                     text: "Ask on JS Error"
                     anchors.fill: parent.paddingItem
                 }
                 ListItemText {
                     role: "SubTitle"
                     mode: jsb.mode
                     text: screen.width===360? "Asks if you want to stop JavaScript\non Error": "Ask if you want to stop JavaScript on Error"
                 }
                  }
                 Switcher{
                     id:jsbox
                     anchors.right: parent.right
                     anchors.rightMargin: 1
                     anchors.verticalCenter: parent.verticalCenter
                     checked:appsettings.getSystemSetting("interruptJS", "")? false:true
                     onClicked: {
                         if(appsettings.getSystemSetting("interruptJS", "") ==="false"){appsettings.saveSystemSetting("interruptJS", "")}
                         else if(appsettings.getSystemSetting("interruptJS", "")=== "" ) {appsettings.saveSystemSetting("interruptJS", "false")}
                     }
                 }
            }
   ListHeader {
       id: restartneedehead
       headerText:"The following need a restart"
   }

   ListItemer {
        id: volumescrolling
        enabled: false
         Column { anchors.fill: volumescrolling.paddingItem
        ListItemText {
            role: "Title"
            text: "Volume Key Scrolling"
            anchors.fill:parent.paddingItem
        }
        ListItemText {
            role: "SubTitle"
            mode: volumescrolling.mode
            text:"Scroll Pages with your Volume Keys"
        }
         }
        Switcher{
            id: mediabox
            anchors.right: parent.right
            anchors.rightMargin: 1
            anchors.verticalCenter: parent.verticalCenter
            checked: appsettings.getSystemSetting("mediakeys", "") === ""? true: false
            onClicked: {
                if (appsettings.getSystemSetting("mediakeys", "")=== ""){appsettings.saveSystemSetting("mediakeys", false); console.debug(appsettings.getSystemSetting("mediakeys", "")); setrestart()}
                else {appsettings.saveSystemSetting("mediakeys", ""); console.debug (appsettings.getSystemSetting("mediakeys", "")); setrestart()}
            }
        }
   }
   ListItemer {
              id: navibuttons
              enabled: false
               Column { anchors.fill: navibuttons.paddingItem
              ListItemText {
                  role: "Title"
                  text: "On Screen Navigation"
                  anchors.fill: parent.paddingItem
              }
              ListItemText {
                  role: "SubTitle"
                  mode: navibuttons.mode
                  text:"On screen page navigation buttons"
              }
               }
              Switcher{
                  id: navibuttonsbox
                  anchors.right: parent.right
                  anchors.rightMargin: 1
                  anchors.verticalCenter: parent.verticalCenter
                  checked:appsettings.getSystemSetting("onscreennavi", "") === ""? false:true
                  onClicked: {
                      if (appsettings.getSystemSetting("onscreennavi","")=== ""){appsettings.saveSystemSetting("onscreennavi", "true"); console.debug(appsettings.getSystemSetting("onscreennavi", "")); setrestart()}
                      else {appsettings.saveSystemSetting("onscreennavi", ""); console.debug (appsettings.getSystemSetting("onscreennavi", ""));setrestart()}
                  }
              }
         }

   ListItemer {
              id: longpress
              enabled: false
               Column { anchors.fill: longpress.paddingItem
              ListItemText {
                  role: "Title"
                  text: "Hide Long Press Menus"
                  anchors.fill: parent.paddingItem
              }
              ListItemText {
                  role: "SubTitle"
                  mode: longpress.mode
                  text:"Long Press Context Menus"
              }
               }
              Switcher{
                  id: longpressbox
                  anchors.right: parent.right
                  anchors.rightMargin: 1
                  anchors.verticalCenter: parent.verticalCenter
                  checked:appsettings.getSystemSetting("killContext", "false")
                  onClicked: {
                      if(appsettings.getSystemSetting("killContext", "false")==="false"){appsettings.saveSystemSetting("killContext", "true");setrestart();}
                      else{ appsettings.saveSystemSetting("killContext", "false");setrestart();}
                  }
              }
         }

}
}
}
