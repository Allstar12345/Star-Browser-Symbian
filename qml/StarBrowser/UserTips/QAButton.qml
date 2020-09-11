/**
Copyright (C) 2020 Allstar Software (Paul Wallace)
*/
import QtQuick 1.1
import com.nokia.symbian 1.1
import "../"

CommonDialoger{
    id: root
    property bool __isClosing: false
        onStatusChanged: {
            if (status === DialogStatus.Closing) __isClosing = true
            else if (status === DialogStatus.Closed && __isClosing) root.destroy()
        }
    Component.onCompleted: {
        open()
    }

        buttonTexts: ["Ok"]
        onButtonClicked: {close()}
        titleText: "Menu Button"
        content:Label{
           width: parent.width-10;wrapMode: Text.Wrap;anchors.centerIn: parent;color:"white"; text: "Press once to open the Menu, hold to Reload the page and also to Stop Page loading."
        }

}
