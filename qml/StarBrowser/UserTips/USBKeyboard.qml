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
        titleText: "USB Keyboard Support"
        content:Label{
          width: parent.width-10;wrapMode: Text.Wrap;anchors.centerIn: parent;  color:"white"; text: "Symbian^3 devices support USB On The Go features, Star Browser now utilises these features with its own set of USB Keyboard Shortcuts:\nHome Key\nEnd Key\nPage Up/Down Keys\nF5 = Reload\nF3 = Open Tips\nF4 = Fullscreen Toggle\nF6 = Source Code Menu"
        }

}
