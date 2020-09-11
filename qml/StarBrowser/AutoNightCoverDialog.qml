/**
Copyright (C) 2020 Allstar Software (Paul Wallace)
*/
import QtQuick 1.1
import com.nokia.symbian 1.1
CommonDialoger {
        id: root
        Component.onCompleted: {  open(); }
    property bool __isClosing: false
        onStatusChanged: {
            if (status === DialogStatus.Closing) __isClosing = true
            else if (status === DialogStatus.Closed && __isClosing) root.destroy()
        }
        titleText: "Night Cover"
        privateCloseIcon: false
        buttonTexts: ["Yes", qsTr("No")]
        content: Label {  anchors.centerIn: parent; text: "It's getting late,\nWould you like to turn on Night Cover ?";}
        onButtonClicked: {
            if (index === 0)  {
                nightcover.visible=true
                banner.showText ("Night Cover Enabled")
                ncqueryopen= "false"
            }

            else if (index === 1) nightcovertimecheck.running=false; ncqueryopen="false"; close()

    }
}



