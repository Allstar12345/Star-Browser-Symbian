/**
Copyright (C) 2020 Allstar Software (Paul Wallace)
*/
import QtQuick 1.1
import "../"

AppPage{
    Component.onCompleted: {showCustomOpacity(0.9)}
    colour:"black"
    MouseArea{anchors.fill: parent; enabled:true}

    Image{
        id: img
        anchors{horizontalCenter: parent.horizontalCenter; top:parent.top; topMargin: 30}
        sourceSize.height: 200
        sourceSize.width: 200
        width: sourceSize.width
        height:sourceSize.height
        source:"../img/toolbox.svg"
    }
    Text{
        color: "#ffffff"
        wrapMode: Text.Wrap
        elide: Text.ElideRight
        maximumLineCount:3
        width: parent.width-35
        anchors{horizontalCenter: parent.horizontalCenter; top:img.bottom; topMargin: 30}
        text:screen.height===480? "Double Tap A Web Page to Open the Extra Tool Menu":"Double Tap A Web Page to Open the Extra Tool Menu, Landscape will reveal more Options."

    }

    ButtonSenseFloat{
        anchors{bottom:parent.bottom; bottomMargin:2;horizontalCenter: parent.horizontalCenter}
        buttonText: "Dismiss"
        buttonBackground: true
        onClicked: {close();}
    }
}
