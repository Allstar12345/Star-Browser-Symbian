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
        titleText: "Downloading A File"
        content:Label{
            width: parent.width-10;wrapMode: Text.Wrap;anchors.centerIn: parent;  color:"white"; text: "You're prompted if a file is trying to download, once you have chosen the save location a Download Manager will open, the manager will notify you when the download has started/completed or if there was a issue with downloading the file."
        }

}
