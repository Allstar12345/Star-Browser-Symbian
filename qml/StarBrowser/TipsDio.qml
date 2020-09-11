/**
Copyright (C) 2020 Allstar Software (Paul Wallace)
*/
import QtQuick 1.1
import com.nokia.symbian 1.1
Rectangle{
    anchors.fill: parent
    z: 2
    id: root
    opacity: 0
    clip: true
    Behavior on opacity {NumberAnimation{} }
    color: "black"
    MouseArea{
        anchors.fill: parent
        onClicked: close()
    }

    Component.onCompleted: {open();}
    Timer{
        id: destroydelay
        running: false; interval: 300
        onTriggered: {
            root.destroy()
        }
    }
   SmoothedAnimation{
        property: "anchors.topMargin"
        target: box
        duration: 200
        to: 0
        id: appear
    }

   SmoothedAnimation{
        property: "anchors.topMargin"
        target: box
        duration: 200
        to: -250
        id: disappear

    }
    function open(){
        root.opacity=0.800
            appear.start()}
    function close(){
        disappear.start()
        root.opacity= 0
        destroydelay.start()
        console.log ("Closed")
    }
Item{
    id: box
    visible: true
    z: 2
    anchors{
        right: parent.right
        left: parent.left
        top: parent.top
    }
    Rectangle{
        id: tips
        z: 1
        visible: true
        color: "black"
        height: if (screen.height=== 480){210} else{170}
        anchors.right:  parent.right
        anchors.left: parent.left
        anchors.top: parent.top
        anchors.topMargin: 0

        ButtonRow{
            id: but4
            anchors.top: text2.bottom
            anchors.topMargin: 17
            anchors.right:  parent.right
            anchors.left: parent.left
            ToolButton{
                text: "Okay"
                onClicked:{
                    opentipspopup();
                    appsettings.saveSystemSetting("tipsdio","off");
                    close();
               }
            }
        }
        ButtonRow{
            id: but3
            anchors.top: but4.bottom
            anchors.topMargin: 4
            anchors.right:  parent.right
            anchors.left: parent.left
            ToolButton{
                text: "No Thanks"
                onClicked:{
                    appsettings.saveSystemSetting("tipsdio","off");
                    close();
                    creator.createComponent("UserTips/StartupToolMenu.qml")
                }

            }
        }


        Text {
            id: text2
            x: 169
            y: 16
            width: 173
            height: 28
            anchors.top: parent.top
            anchors.topMargin: 20
            color: "white"
            text: qsTr("Check Out Tips To Make Your experience\neven better!")
            styleColor: "#ffffff"
            verticalAlignment: Text.AlignTop
            anchors.horizontalCenter: parent.horizontalCenter
            horizontalAlignment: Text.AlignHCenter
            font.pixelSize: 19
        }

    }
}

}
