/**
Copyright (C) 2020 Allstar Software (Paul Wallace)
*/
import QtQuick 1.1
import com.nokia.symbian 1.1
import "../"

Rectangle {

    Component.onDestruction: {
        console.debug ("Security Destroyed")
    }
    Timer{id: contentappear; interval:450; onTriggered: {passfield.opacity=1; row.opacity=1}}

    Timer{
        id: killtimer
        interval: 400
        onTriggered: {
        root.destroy()
        }
    }
    function close(){
        root.opacity=0
        killtimer.start();
    }
Behavior on opacity { NumberAnimation {} }
color: "black"
anchors.fill: parent
z: 10
opacity: 0
id: root

    Component.onCompleted: {
        console.debug("Security Opened")
        root.opacity=1;
        toolbar.appear();
        contentappear.start();
    }
  TopToolBar{
      id:toolbar
      setDuration: "400"
            ToolButtonSense {
                id: btnBack
                imgsource: "../img/back_flat.svg"
                onClicked: {close()
             }

          }
            }
  ListHeader{
      id: listheading2
      z: 1
      anchors.top: toolbar.bottom
      headerText:"Please Enter Your Passphrase"
}

               TextField{
                   opacity: 0
                   Behavior on opacity { NumberAnimation {} }
                   id: passfield
                    inputMethodHints: Qt.ImhNoAutoUppercase
                   errorHighlight: passfield.text? false: true
                   echoMode: TextInput.Password
                   anchors{left: parent.left; right:parent.right;top: listheading2.bottom; topMargin: 2}
                   placeholderText: "Enter Your Secret Passphrase Here"

               }

               ButtonRow{
                   opacity: 0
                   Behavior on opacity { NumberAnimation {} }
                   id:row
                   anchors.left: parent.left
                   anchors.right: parent.right
                   anchors.top: passfield.bottom
                   ToolButton{
                       text: "Reset My Password"

                       onClicked:{
                           if (passfield.text=== appsettings.getSystemSetting ("fpa", "")){
                               banner.showText ("Password Reset")
                               appsettings.saveSystemSetting ("ap", "")
                               close()
                           }
                           else{
                               banner.showText ("Passphrase Incorrect")
                           }
                       }
                   }

           }
}






