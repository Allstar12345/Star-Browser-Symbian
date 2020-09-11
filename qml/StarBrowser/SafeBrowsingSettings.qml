/**
Copyright (C) 2020 Allstar Software (Paul Wallace)
*/
import QtQuick 1.1
import com.nokia.symbian 1.1

AppPage{
    Component.onCompleted:{show();toolbar.appear();}
    colour: "black"
    property string switchSource: appsettings.getSystemSetting("switchsource", "") ? appsettings.getSystemSetting("switchsource", ""): "img/Switch/qtg_graf_switchbutton_fill.svg";

    TopToolBar{
        id: toolbar
        setDuration: "400"
        ToolButtonSense {
            id: btnBac
            imgsource: "img/back_flat.svg"
            onClicked: {close()
         }
      }
    }

    Flickable {
        Behavior on opacity {NumberAnimation{}}
        id: flickable
        opacity: 1
        anchors.bottom: parent.bottom
        anchors.right: parent.right
        anchors.left: parent.left
        anchors.top: toolbar.bottom
        contentHeight: columnsett.height
        contentWidth: columnsett.width
        Decorator{flickableItem: flickable; lightColours: true; }

    Column {
        id: columnsett
       spacing: 1
       ListHeader {
           id: header
           z: 1
           headerText:"Safe Browsing"
       }


       ListItemer {
           id: swit
                  enabled: false
                  Column { anchors.fill: swit.paddingItem
                      ListItemText {
                           role: "Title"
                           text: "Safe Browsing"
                          anchors.fill: swit.paddingItem
                       }
                       ListItemText {
                           role: "SubTitle"
                           mode: swit.mode
                           text: "Check for suspicious websites"
                       }
                 }
                  Switcher{
                      anchors.right: parent.right
                     anchors.rightMargin: 1
                      anchors.verticalCenter: parent.verticalCenter
                      checked: appsettings.getSystemSetting("safeBrowsing", "") === ""? true: false
                      onClicked: {
                          if (appsettings.getSystemSetting("safeBrowsing", "")=== ""){appsettings.saveSystemSetting("safeBrowsing", "false"); console.debug(appsettings.getSystemSetting("safeBrowsing", ""))}
                          else {appsettings.saveSystemSetting("safeBrowsing", "");console.debug (appsettings.getSystemSetting("safeBrowsing", ""))}
                      }
                  }
             }
    }
    }

}
