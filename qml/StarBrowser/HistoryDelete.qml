/**
Copyright (C) 2020 Allstar Software (Paul Wallace)
*/
import QtQuick 1.1
import com.nokia.symbian 1.1

CommonDialoger {
        id: root
        Component.onCompleted: {
            open()
        }
    property bool __isClosing: false
        onStatusChanged: {
            if (status === DialogStatus.Closing) __isClosing = true
            else if (status === DialogStatus.Closed && __isClosing) root.destroy()
        }
        titleText: "Delete History Item"
        privateCloseIcon: false
        buttonTexts: ["Yes", qsTr("Cancel")]
        content: Label {  anchors.centerIn: parent; text: "Are you sure you want to Delete?";}
        onButtonClicked: {
            if (index === 0)  {
                deleteHistoryItem();
            }

            else if (index === 1) close();

    }
}



