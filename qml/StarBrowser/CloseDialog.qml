/**
Copyright (C) 2020 Allstar Software (Paul Wallace)
*/
import QtQuick 1.1
import com.nokia.symbian 1.1
Rectangle{
    anchors.fill: parent
    z: 10
    id: root
    opacity: 0
    clip: true
    Behavior on opacity {NumberAnimation{} }
    color: "black"
    MouseArea{
        anchors.fill: parent
        onClicked: close()
    }
    Component.onCompleted: {
        open()
    }
    function open(){
        root.opacity=0.850
            appear.start()}
    function close(){
        disappear.start()
        root.opacity= 0
        root.destroy(320)
    }
Rectangle{
    id: box
    z: 5
    color: popupbutton.color
    height: 150
    anchors.right: parent.right
    anchors.left: parent.left
    anchors.top: parent.top
    anchors.topMargin: -150


   SmoothedAnimation{
        property: "anchors.topMargin"
        target: box
        duration: 400
        to: 0
        id: appear
    }

   SmoothedAnimation{
        property: "anchors.topMargin"
        target: box
        duration: 350
        to: -150
        id: disappear
    }
    Text {
        id: text
        anchors.top: parent.top;anchors.topMargin: 10
        color: "white"
        text: qsTr("Exit Star Browser?")
        verticalAlignment: Text.AlignTop
        anchors.horizontalCenter: parent.horizontalCenter
        horizontalAlignment: Text.AlignHCenter
        font.pointSize: 9
    }

    ButtonSenseFloat{
buttonBackground: false
        anchors{left:parent.left; leftMargin:3; bottom:parent.bottom; bottomMargin:5}
        buttonText:"Cancel"
        onClicked:{close();}
    }
    ButtonSenseFloat{
        buttonBackground: false
        anchors{horizontalCenter: parent.horizontalCenter; bottom:parent.bottom; bottomMargin:5}
        buttonText:"Minimise"
        onClicked:{QMLUtils.minimizeApp(); close();}
    }
    ButtonSenseFloat{
        buttonBackground: false
        anchors{right:parent.right; rightMargin:3; bottom:parent.bottom; bottomMargin:5}
        buttonText:"Exit"
        onClicked:{quitStarbrowser();}
    }
}

}
