/**
Copyright (C) 2020 Allstar Software (Paul Wallace)
*/
import QtQuick 1.1
import com.nokia.symbian 1.1


AppPage{
    Component.onDestruction: { console.debug ("Privacy Destroyed")}
colour: "black"
Component.onCompleted: {show(); listappear.start();toolbar.appear();}
id: privacy
Timer{interval: 430; id: listappear; onTriggered:{flickable.opacity=1}}
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

QtObject { id: create; property Component com: null;function createComponent (qmlfile){com = Qt.createComponent(qmlfile);com.createObject(privacy)} }

function openCacheSettings(){create.createComponent(Qt.resolvedUrl("SettingsPages/CacheSettings.qml"));}

function openGeoSet(){create.createComponent(Qt.resolvedUrl("SettingsPages/GeoLocationSettings.qml"));}


Flickable {
    Behavior on opacity {NumberAnimation{}}
    id: flickable
    opacity: 0
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
       headerText:"Privacy Settings"
   }
   ListItemer {
        id: cachesett
        enabled: true
        subItemIndicator: true
        onClicked:{
            if (sensitiveMode=== true){
                banner.showText ("Access Denied, Private Mode Activated")
            }
            else{
                openCacheSettings();
            }
        }
        ListItemText {
            role: "Title"
            text: "Cache Settings"
            anchors.fill: parent.paddingItem
        }
        }
   ListItemer {
        id: geoset
        enabled: true
        subItemIndicator: true
        onClicked:{
            if (sensitiveMode=== true){
                banner.showText ("Access Denied, Private Mode Activated")
            }
            else{
                openGeoSet();
            }
        }
        ListItemText {
            role: "Title"
            text: "GeoLocation Settings"
            anchors.fill: parent.paddingItem
        }
        }

// Non working safe browsing feature

  /* ListItemer {
        enabled: true
        subItemIndicator: true
        onClicked:{
            if (sensitiveMode=== true){
                banner.showText ("Access Denied, Private Mode Activated")
            }
            else{
                creator.createComponent(Qt.resolvedUrl("SafeBrowsingSettings.qml"))
            }
        }
        ListItemText {
            role: "Title"
            text: "Safe Browsing"
            anchors.fill: parent.paddingItem
        }
        }*/


   ListItemer {
              id: hist
              enabled: false

              Column { anchors.fill: hist.paddingItem
                  ListItemText {
                       role: "Title"
                       text: "Save Browsing History"
                      anchors.fill: hist.paddingItem
                   }
                   ListItemText {
                       role: "SubTitle"
                       mode: hist.mode
                       text: "Save the pages visited"
                   }
             }
              Switcher{
                  id: histbox
                  anchors.right: parent.right
                 anchors.rightMargin: 1
                  anchors.verticalCenter: parent.verticalCenter
                  checked: appsettings.getSystemSetting("webhistorytoggle", "") === ""? true: false
                  onClicked: {
                      if (appsettings.getSystemSetting("webhistorytoggle", "")=== ""){appsettings.saveSystemSetting("webhistorytoggle", "false"); console.debug(appsettings.getSystemSetting("webhistorytoggle", ""))}
                      else {appsettings.saveSystemSetting("webhistorytoggle", ""); console.debug (appsettings.getSystemSetting("webhistorytoggle", ""))}
                  }
              }
         }
   ListItemer {
              id: cookatclose
              enabled: false
              Column { anchors.fill: cookatclose.paddingItem
                  ListItemText {
                       role: "Title"
                       text: "Clear Cookies On Close"
                      anchors.fill: cookatclose.paddingItem
                   }
                   ListItemText {
                       role: "SubTitle"
                       mode: cookatclose.mode
                       text: "Clear All Cookies when Closing"
                   }
             }
              Switcher{
                  id: cookbox
                  anchors.right: parent.right
                 anchors.rightMargin: 1
                  anchors.verticalCenter: parent.verticalCenter
                  checked: appsettings.getSystemSetting("cookonclose", "") === "true"? true: false
                  onClicked: {
                      if (appsettings.getSystemSetting("cookonclose", "")=== ""){appsettings.saveSystemSetting("cookonclose", "true"); console.debug(appsettings.getSystemSetting("cookonclose", ""))}
                      else {appsettings.saveSystemSetting("cookonclose", ""); console.debug (appsettings.getSystemSetting("cookonclose", ""))}
                  }
              }
         }
   ListItemer {
              id: histatclose
              enabled: false
              Column { anchors.fill: histatclose.paddingItem
                  ListItemText {
                       role: "Title"
                       text: "Clear History On Close"
                      anchors.fill: histatclose.paddingItem
                   }
                   ListItemText {
                       role: "SubTitle"
                       mode: histatclose.mode
                       text: "Clear All History when Closing"
                   }
             }
              Switcher{
                  id: historybox
                  anchors.right: parent.right
                 anchors.rightMargin: 1
                  anchors.verticalCenter: parent.verticalCenter
                  checked: appsettings.getSystemSetting("historyonclose", "") === "true"? true: false
                  onClicked: {
                      if (appsettings.getSystemSetting("historyonclose", "")=== ""){appsettings.saveSystemSetting("historyonclose", "true"); console.debug(appsettings.getSystemSetting("historyonclose", ""))}
                      else {appsettings.saveSystemSetting("historyonclose", ""); console.debug (appsettings.getSystemSetting("historyonclose", ""))}
                  }
              }
         }
   ListItemer {
        id: jsclip
        enabled: false
        Column { anchors.fill: jsclip.paddingItem
            ListItemText {
                 role: "Title"
                 text: "JS Access Clipboard"
                anchors.fill: jsclip.paddingItem
             }
             ListItemText {
                 role: "SubTitle"
                 mode: jsclip.mode
                 text: "JavaScript access to the Clipboard"
             }
       }
        Switcher{
            anchors.right: parent.right
           anchors.rightMargin: 1
            anchors.verticalCenter: parent.verticalCenter
            checked:  appsettings.getSystemSetting("jsclip", "") === ""? false:true
            onClicked: {
                if(appsettings.getSystemSetting("jsclip", "")===""){appsettings.saveSystemSetting("jsclip", true); web_view1.settings.javascriptCanAccessClipboard=true; console.log(web_view1.settings.javascriptCanAccessClipboard)}
                else{appsettings.saveSystemSetting("jsclip", ""); web_view1.settings.javascriptCanAccessClipboard=false; console.log(web_view1.settings.javascriptCanAccessClipboard)}
            }
        }
   }
   ListItemer{
        id: pb
        enabled: false
        Column { anchors.fill: pb.paddingItem
            ListItemText {
                 role: "Title"
                 text: "Private Browsing"
                anchors.fill: pb.paddingItem
             }
             ListItemText {
                 role: "SubTitle"
                 mode: pb.mode
                 text: "Leave no trace of browsing"
             }
       }
        Switcher{
            anchors.right: parent.right
           anchors.rightMargin: 1
            anchors.verticalCenter: parent.verticalCenter
            checked:  appsettings.getSystemSetting("pb", "") === ""? false:true
            onClicked: {
                if(appsettings.getSystemSetting("pb", "")===""){appsettings.getSystemSetting("pb", true); web_view1.settings.privateBrowsingEnabled=true; privateBrowsing=true;appsettings.saveSystemSetting("browsingCookies", "false"); appsettings.saveSystemSetting("geoLocation", "false")}
                else{appsettings.savetSystemSetting("pb", ""); web_view1.settings.privateBrowsingEnabled=false; privateBrowsing=false;appsettings.saveSystemSetting("browsingCookies", "true");appsettings.saveSystemSetting("geoLocation", "")}
            }
        }
   }

   ListItemer{
       id: dataused

             Column { anchors.fill: dataused.paddingItem

                 ListItemText {
                     function bytesToSize() {
                          var bytes= appsettings.getSystemSetting("totalBytes", "")

                          var sizes = ['Bytes', 'KB', 'MB', 'GB', 'TB'];
                          if (bytes == 0) return 'n/a';
                          var i = parseInt(Math.floor(Math.log(bytes) / Math.log(1024)));
                          return Math.round(bytes / Math.pow(1024, i), 2) + ' ' + sizes[i];
                      }


                     function bytesTosize() {
                         var bytes= appsettings.getSystemSetting("totalBytes", "")

                        if(bytes == 0) return 'No Data Used';
                        var k = 1000;
                        var sizes = ['Bytes', 'KB', 'MB', 'GB', 'TB', 'PB', 'EB', 'ZB', 'YB'];
                        var i = Math.floor(Math.log(bytes) / Math.log(k));
                        return (bytes / Math.pow(k, i)).toPrecision(3) + ' ' + sizes[i]+ " Used";
                     }
                      role: "Title"
                      text: bytesTosize()
                     anchors.fill: dataused.paddingItem
                  }
                  ListItemText {
                      role: "SubTitle"
                      mode: dataused.mode
                      text: "Data Sent and Received since install"
                  }
            }
       }


}

}
}
