/**
Copyright (C) 2020 Allstar Software (Paul Wallace)
*/
import QtQuick 1.1
import com.nokia.symbian 1.1
import com.nokia.extras 1.1
import "../"

CommonDialoger{
id: root
titleText: "Homepage"
privateCloseIcon: true
buttonTexts: ["Choose"]
height: 350

property bool __isClosing: false
    onStatusChanged: {
        if (status === DialogStatus.Closing) __isClosing = true
        else if (status === DialogStatus.Closed && __isClosing) root.destroy()
    }

    Component.onCompleted: {col.selectedIndex=parseInt(appsettings.getSystemSetting("homepageChooserIndex", ""))?  parseInt(appsettings.getSystemSetting("homepageChooserIndex", "")):0; open()}

onButtonClicked: {
    appsettings.saveSystemSetting("homepageChooserIndex", col.selectedIndex)
    switch (col.selectedIndex) {
    case 0:{appsettings.saveSystemSetting("homepage",globalHomepage);appsettings.saveSystemSetting("StartRestore", ""); banner.showText("Default Homepage selected");  homepagesuber.text= globalHomepage}
    case 1:{ if(privateBrowsing===false){ if (appsettings.getSystemSetting("StartRestore", "")=== ""){appsettings.saveSystemSetting("StartRestore", "True"); homepagesuber.text= "Last Visited Page"}}else{banner.showText("Unable to change, Private Browsing is enabled.")}  }
    case 2:{appsettings.saveSystemSetting("StartRestore", "");close(); openhomepage(); }
   // case 3:{}


    }}

content: Item{anchors.fill: parent

    TumblerColumn{
        anchors.fill: parent

        id:col

        items: ListModel {
        ListElement {
            value: "Default Homepage"
        }
        ListElement {
            value: "Last Visited Page (Main Window)"

        }
        ListElement {
            value: "Custom Homepage"
        }

    }
    Tumbler {id: tumb
    anchors{top:parent.top; topMargin: 4; right:parent.right; left:parent.left; bottom:parent.bottom}
    columns: [col]}
}
}
}





