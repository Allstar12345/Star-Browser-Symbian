/**
Copyright (C) 2020 Allstar Software (Paul Wallace)
*/
import QtQuick 1.1
import com.nokia.symbian 1.1
import com.nokia.extras 1.1
import "../"

CommonDialoger{
id: root
titleText: "User Agent"
privateCloseIcon: true
buttonTexts: ["Choose"]
height: 350

property bool __isClosing: false
    onStatusChanged: {
        if (status === DialogStatus.Closing) __isClosing = true
        else if (status === DialogStatus.Closed && __isClosing) root.destroy()
    }

    Component.onCompleted: {col.selectedIndex=parseInt(appsettings.getSystemSetting("uaindex", ""))?  parseInt(appsettings.getSystemSetting("uaindex", "")):0; open()}

onButtonClicked: {
    appsettings.saveSystemSetting("uaindex", col.selectedIndex)
    switch (col.selectedIndex) {
    case 0:{ appsettings.saveUserAgent("Default");UserAgent.update();banner.showText("Default User Agent Selected"); appsettings.saveSystemSetting ("uatitle", "User Agent - Default"); uatext.text= "User Agent - Default";openReloadPages(); break;}
    case 1:{ appsettings.saveUserAgent("Symbian");UserAgent.update();banner.showText("Symbian User Agent Selected"); appsettings.saveSystemSetting ("uatitle", "User Agent - Symbian");uatext.text= "User Agent - Symbian" ;openReloadPages(); break;}
    case 2:{appsettings.saveUserAgent("Android");UserAgent.update();banner.showText("Android User Agent Selected"); appsettings.saveSystemSetting ("uatitle", "User Agent - Android");uatext.text= "User Agent - Android" ;openReloadPages(); break;}
    case 3:{appsettings.saveUserAgent("WindowsPhone");UserAgent.update();banner.showText("Windows Phone User Agent Selected"); appsettings.saveSystemSetting ("uatitle", "User Agent - Windows Phone"); uatext.text= "User Agent - Windows Phone" ;openReloadPages(); break;}
    case 4:{ appsettings.saveUserAgent("FireFox");UserAgent.update();banner.showText("Firefox (Desktop) User Agent Selected"); appsettings.saveSystemSetting ("uatitle", "User Agent - Firefox"); uatext.text= "User Agent - Firefox" ; openReloadPages();break;}
    case 5:{appsettings.saveUserAgent("BlackBerry10");UserAgent.update();banner.showText("BlackBerry 10 User Agent Selected"); appsettings.saveSystemSetting ("uatitle", "User Agent - BlackBerry 10"); uatext.text= "User Agent - BlackBerry 10";openReloadPages(); break;}
    case 6:{appsettings.saveUserAgent("SailFish");UserAgent.update();banner.showText("SailFish User Agent Selected"); appsettings.saveSystemSetting ("uatitle", "User Agent - SailFish"); uatext.text= "User Agent - SailFish"; openReloadPages();break;}
    case 7:{appsettings.saveUserAgent("AOSP");UserAgent.update();banner.showText("AOSP User Agent Selected"); appsettings.saveSystemSetting ("uatitle", "User Agent - AOSP"); uatext.text= "User Agent - AOSP"; openReloadPages();break;}
    case 8:{appsettings.saveUserAgent("OperaMini");UserAgent.update();banner.showText("Opera Mini User Agent Selected"); appsettings.saveSystemSetting ("uatitle", "User Agent - Opera Mini"); uatext.text= "User Agent - Opera Mini"; openReloadPages();break;}
    case 9:{appsettings.saveUserAgent("Edge");UserAgent.update();banner.showText("Microsoft Edge User Agent Selected"); appsettings.saveSystemSetting ("uatitle", "User Agent - Microsoft Edge"); uatext.text= "User Agent - Microsoft Edge"; openReloadPages();break;}
    case 10:{appsettings.saveUserAgent("KaiOS");UserAgent.update();banner.showText("KaiOS User Agent Selected"); appsettings.saveSystemSetting ("uatitle", "User Agent - KaiOS"); uatext.text= "User Agent - KaiOS"; openReloadPages();break;}

    case 11:{opencustomuadialog(); break;}


    }}

content: Item{anchors.fill: parent

    TumblerColumn{
        anchors.fill: parent

        id:col

        items: ListModel {
        ListElement {
            value: "Default (IOS13)"
        }
        ListElement {
            value: "Symbian"
        }
        ListElement {
            value: "Android"
        }
        ListElement {
            value: "Windows Phone"
        }ListElement {
            value: "Firefox"
        }
        ListElement {
            value: "BlackBerry 10"
        }
        ListElement {
            value: "Jolla SailFish"
        }
        ListElement {
            value: "Android Open Source Project"
        }
        ListElement {
            value: "Opera Mini"
        }
        ListElement {
            value: "Microsoft Edge"
        }
        ListElement {
            value: "KaiOS"
        }

        ListElement {
            value: "Custom"
        }
        }

    }
    Tumbler {id: tumb
    anchors{top:parent.top; topMargin: 4; right:parent.right; left:parent.left; bottom:parent.bottom}
    columns: [col]}
}
}



