/**
Copyright (C) 2020 Allstar Software (Paul Wallace)
*/
import QtQuick 1.1
import com.nokia.symbian 1.1
import "dbcore.js" as DBcore

CommonDialoger {
        id: rooter
        Component.onCompleted: { open(); }
    property bool __isClosing: false
        onStatusChanged: {
            if (status === DialogStatus.Closing) __isClosing = true
            else if (status === DialogStatus.Closed && __isClosing) rooter.destroy()
        }
        titleText: "Delete Bookmarks"
        privateCloseIcon: false
        buttonTexts: ["Yes", qsTr("Cancel")]
        content: Label {  anchors.centerIn: parent; text: "All Bookmarks will be deleted\nThis cannot be reversed";}
        onButtonClicked: {
            if (index === 0)  {
                deleteall();
                root.close();
                webViewHidden=false;
            }

            else if (index === 1) close();

    }
}



