/**
Copyright (C) 2020 Allstar Software (Paul Wallace)
*/
import QtQuick 1.1
import com.nokia.symbian 1.1
import "../"

CommonDialoger {
        id: root
            property bool __isClosing: false
                onStatusChanged: {
                    if (status === DialogStatus.Closing) __isClosing = true
                    else if (status === DialogStatus.Closed && __isClosing) root.destroy()
                }
            Component.onCompleted: {
                open()
            }
        titleText: "Change Password"
        height: 50
        privateCloseIcon: true
        buttonTexts: ["Save"]
        onButtonClicked:{
            if (passhome.text=== ""){
                banner.showText ("No Value Entered")
            }
            else{
            appsettings.saveSystemSetting ("ap", passhome.text)
            banner.showText ("Password Updated")
            }
        }
        content: Item {
            anchors.fill: parent
            TextField {
                focus: true
                errorHighlight: passhome.text? false: true
                echoMode: TextInput.Password
                id: passhome
                inputMethodHints: Qt.ImhNoAutoUppercase
                placeholderText: "Enter Your New Password Here"
                anchors.fill: parent
                width: parent.width - 20
}
}

}
