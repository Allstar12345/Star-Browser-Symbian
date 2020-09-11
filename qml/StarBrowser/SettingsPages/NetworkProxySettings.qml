/**
Copyright (C) 2020 Allstar Software (Paul Wallace)
*/
import QtQuick 1.1
import com.nokia.symbian 1.1
import "../"

AppPage{
    Connections {
           target: QApp
        onKeyboardEventChanged:{ if(val===1){console.debug("Keyboard open")}
            else if (val===0){ console.debug("Keyboard Closed"); bob.forceActiveFocus()}
    }
    }
    Component.onDestruction: { console.debug ("Proxy Settings Destroyed")}
    function closePage(){
        appsettings.setNetworkProxyPort(portfield.text);
        appsettings.saveSystemSetting("proxyHostName", hostfield.text);
        appsettings.saveSystemSetting("proxyUser", userfield.text);
         appsettings.saveSystemSetting("proxyPassword", passwordfield.text);
        close();
    }
    onWidthChanged: {if(screen.width===360) {
            if(portfield.focus===true){toolbar.appear()}}
        if(screen.width===640){
            if(portfield.focus===true){
            toolbar.disappear();}
        }
        if(screen.width===360) {
                    if(hostfield.focus===true){toolbar.appear()}}
                if(screen.width===640){
                    if(hostfield.focus===true){toolbar.disappear();}
                }
                if(screen.width===360) { if(userfield.focus===true){}}

    }
colour: "black"
Component.onCompleted: {show();listappear.start(); toolbar.appear();}
id: proxset
Timer{interval: 430; id: listappear; onTriggered:{flickable.opacity=1}}
TopToolBar{
    setDuration: "400"
    id: toolbar
    ToolButtonSense {
        id: btnBac
        imgsource: "../img/back_flat.svg"
        onClicked: {closePage();
     }
  }
}


ListHeader {
    id: header
    z: 1
    anchors.top: toolbar.bottom
    headerText:"Network Proxy Settings"
}
Flickable {
    Behavior on opacity {NumberAnimation{}}
    id: flickable
    opacity: 0
    anchors.bottom: parent.bottom
    anchors.right: parent.right
    anchors.left: parent.left
    anchors.top:header.bottom
    contentHeight: parent.height
    flickableDirection: Flickable.VerticalFlick
    contentWidth: parent.width
    ListItemer {
        enabled: false
        id: proxen
         Column { anchors.fill: parent.paddingItem
             ListItemText {
                  role: "Title"
                  text: "Network Proxy"
                 anchors.fill: parent.paddingItem
              }
        }
         Switcher{
             id: proxCheck
             anchors.right: parent.right
             anchors.rightMargin: 1
             anchors.verticalCenter: parent.verticalCenter
             checked: appsettings.getSystemSetting("proxyEnabled", "false");
             onClicked: {
               if(appsettings.getSystemSetting("proxyEnabled", "false")==="true"){
                   appsettings.saveSystemSetting("proxyEnabled", "false"); appsettings.setNetworkProxyPort(portfield.text);
                   appsettings.saveSystemSetting("proxyHostName", hostfield.text);
                   appsettings.saveSystemSetting("proxyUser", userfield.text);
                    appsettings.saveSystemSetting("proxyPassword", passwordfield.text);setrestart()
               }
               else{appsettings.saveSystemSetting("proxyEnabled", "true"); appsettings.setNetworkProxyPort(portfield.text);
                   appsettings.saveSystemSetting("proxyHostName", hostfield.text);
                   appsettings.saveSystemSetting("proxyUser", userfield.text);
                    appsettings.saveSystemSetting("proxyPassword", passwordfield.text);setrestart()}
       }
    }
    }
   TextField{
       id:portfield
       anchors{ top:proxen.bottom;topMargin: 5;right:parent.right}
       placeholderText: "port";
       width: screen.width===640? 115:75
       errorHighlight: !text
       inputMethodHints: Qt.ImhDigitsOnly
       text: appsettings.getnetworkProxyPort();
       onActiveFocusChanged: {
           if(screen.height===480){}
           else{
           if(screen.height===360){
               if(portfield.focus===true){toolbar.disappear();}
               else if (portfield.focus===false){toolbar.appear();}
           }
           }
       }
   }
   TextField{
       id:hostfield
       width: screen.width===640? 510: 280
       anchors{top:proxen.bottom; topMargin: 5;  left:parent.left}
       placeholderText: "Host";
       errorHighlight: !text
       inputMethodHints: Qt.ImhNoPredictiveText
       text:appsettings.getSystemSetting("proxyHostName", "")
       onActiveFocusChanged: {
           if(screen.height===480){}
           else{         if(screen.height===360){
               if(hostfield.focus===true){toolbar.disappear();}
               else if (hostfield.focus===false){toolbar.appear();}
           }
           }
       }
   }
   TextField{
       id:userfield
       anchors{top:hostfield.bottom;topMargin: 5;  left:parent.left; }
       placeholderText: "User";
       inputMethodHints: Qt.ImhNoPredictiveText
       errorHighlight: !text
       width: screen.width===640? 320:180
       text:appsettings.getSystemSetting("proxyUser", "")
       onActiveFocusChanged: {
           if(screen.height===480){}
           else{
           if(screen.height===360){
               if(userfield.focus===true){toolbar.disappear();}
               else if (userfield.focus===false){toolbar.appear();}
           }
           }
       }

   }
   TextField{
       id:passwordfield
       inputMethodHints: Qt.ImhNoPredictiveText || Qt.ImhNoAutoUppercase
       anchors{top:hostfield.bottom; topMargin: 5; right:parent.right}
       placeholderText: "Password";
       echoMode: TextInput.Password
       errorHighlight: !text
       width: screen.width===640? 320:180
       text:appsettings.getSystemSetting("proxyPassword", "") 
       onActiveFocusChanged: {
           if(screen.height===480){}
           else{
           if(screen.height===360){
               if(passwordfield.focus===true){toolbar.disappear();}
               else if (passwordfield.focus===false){toolbar.appear();}
           }
           }
       }
   }

   Item{
       id: bob
   }
}

}
