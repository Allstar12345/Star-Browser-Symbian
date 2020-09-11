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
        titleText: "Custom User Agent"
        height: 50
        privateCloseIcon: true
        buttonTexts: ["Save"]
        onButtonClicked:{
            appsettings.saveUserAgent("Custom");
            appsettings.saveCustomUserAgent(urlua.text);
            UserAgent.update()
            banner.showText("Custom User Agent Set")
            uatext.text= "User Agent - Custom"
            appsettings.saveSystemSetting ("uatitle", "User Agent - Custom")
            openReloadPages();
        }
        content: Item {
            anchors.fill: parent
            TextField {
                focus: true
                objectName: "urltitle"
                id: urlua
                errorHighlight: urlua.text? false: true
                text: appsettings.getSystemSetting("customuastring", "") ===""? "": appsettings.getSystemSetting("customuastring", "")
                placeholderText: "Enter String Here"
                anchors.fill: parent
                width: parent.width - 20
}
}
}
