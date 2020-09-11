/**
Copyright (C) 2020 Allstar Software (Paul Wallace)
*/
import QtQuick 1.1
import com.nokia.symbian 1.1
import "../"

CommonDialoger {
        id: root
        property string address: ""
        property bool __isClosing: false
            onStatusChanged: {
                if (status === DialogStatus.Closing) __isClosing = true
                else if (status === DialogStatus.Closed && __isClosing) root.destroy()
            }
        Component.onCompleted: {
            open()
        }
        titleText: "Homepage"
        height: 50
        privateCloseIcon: true
        buttonTexts: ["Save"]
        onButtonClicked:{
            appsettings.saveSystemSetting("homepage",urlhome.text)
            homepagesuber.text= urlhome.text
        }
        content: Item {
            anchors.fill: parent
            TextField {
                focus: true
                objectName: "urltitle"
                id: urlhome
                inputMethodHints: Qt.ImhLowercaseOnly
                text: appsettings.getSystemSetting("homepage", "") ===""? "http://": appsettings.getSystemSetting("homepage", "")
                placeholderText: "Enter URL Here"
                anchors.fill: parent
                width: parent.width - 20
}
}

}
