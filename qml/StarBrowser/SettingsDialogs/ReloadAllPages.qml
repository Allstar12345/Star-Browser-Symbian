/**
Copyright (C) 2020 Allstar Software (Paul Wallace)
*/
import QtQuick 1.1
import com.nokia.symbian 1.1
import "../"

CommonDialoger {
        id: root
        Component.onCompleted: {open();}
    property bool __isClosing: false
        onStatusChanged: {
            if (status === DialogStatus.Closing) __isClosing = true
            else if (status === DialogStatus.Closed && __isClosing) root.destroy()
        }
        titleText: "Reload All Pages"
        privateCloseIcon: false
        buttonTexts: ["Ok", "Cancel"]
        content: Label {  width: parent.width-10;wrapMode: Text.Wrap; anchors.centerIn: parent;  text: "Reload all open Pages to apply the new Browser UserAgent?"}
        onButtonClicked: {
            if (index === 0) {
                windowserver.reloadAllWindows();
            }

            else if (index === 1) root.close()
    }
}
