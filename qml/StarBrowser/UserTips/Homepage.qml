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
        titleText: "Homepage"
        buttonTexts: ["Ok"]
        onButtonClicked: {close()}
        content:Label{
         width: parent.width-10;wrapMode: Text.Wrap;  anchors.centerIn: parent; color:"white"; text: "To set the Homepage either long press on the Home Button on the Menu or go to Settings-Homepage"
        }


}
