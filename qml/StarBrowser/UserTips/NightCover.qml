/**
Copyright (C) 2020 Allstar Software (Paul Wallace)
*/

import QtQuick 1.1
import com.nokia.symbian 1.1
import "../"
CommonDialoger{  property bool __isClosing: false
    onStatusChanged: {
        if (status === DialogStatus.Closing) __isClosing = true
        else if (status === DialogStatus.Closed && __isClosing) root.destroy()
    }
Component.onCompleted: {
    open()
}
        id: root
        buttonTexts: ["Ok"]
        onButtonClicked: {close()}
        titleText: "Night Cover"
        content:Label{
          width: parent.width-10;wrapMode: Text.Wrap;  anchors.centerIn: parent;color:"white"; text: "Star Browser has a feature called NightCover, this places a dark layer over the Application which reduces the brightness.\nIt is adjustable by Long Pressing the Toggle Button on the Menu."
        }

}
