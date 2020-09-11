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
        titleText: "HTML5 Video Player"
        content:Label{
          width: parent.width-10;wrapMode: Text.Wrap;anchors.centerIn: parent;  color:"white"; text: "Star Browser has a video player for HTML5 content, but the players controls are hidden.\nPress on the bottom right corner to toggle mute, long press to open volume slider.\nPress on the bottom Left corner to toggle play/pause and finally press the top right corner to close the player."
        }

}
