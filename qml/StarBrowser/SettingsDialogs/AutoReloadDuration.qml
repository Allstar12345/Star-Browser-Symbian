/**
Copyright (C) 2020 Allstar Software (Paul Wallace)
*/
import QtQuick 1.1
import com.nokia.symbian 1.1
import com.nokia.extras 1.1
import "../"

CommonDialoger{
id: root
titleText: "Auto Reload Timeout"
privateCloseIcon: true
buttonTexts: ["Choose"]
height: 350

property bool __isClosing: false
    onStatusChanged: {
        if (status === DialogStatus.Closing) __isClosing = true
        else if (status === DialogStatus.Closed && __isClosing) root.destroy()
    }

    Component.onCompleted: {col.selectedIndex=parseInt(appsettings.getSystemSetting("autoreloadindex", ""))?  parseInt(appsettings.saveSystemSetting("autoreloadindex", "")):0 ;open()}

onButtonClicked: {
   appsettings.saveSystemSetting("autoreloadindex", col.selectedIndex)
    switch (col.selectedIndex) {
    case 0:{ appsettings.saveSystemSetting ("timerduration", 30000 )
        banner.showText ("Duration Set To 30 Seconds")
        autoreload.interval="30000"; break;}
    case 1:{appsettings.saveSystemSetting ("timerduration", 600000)
        banner.showText ("Duration Set To 1 Minute")
      autoreload.interval="600000";break;}
    case 2:{appsettings.saveSystemSetting ("timerduration", 3000000 )
        banner.showText ("Duration Set To 5 Minutes")
      autoreload.interval="3000000";break;}
    case 3:{appsettings.saveSystemSetting ("timerduration", 6000000 )
        banner.showText ("Duration Set To 10 Minutes")
       autoreload.interval="600000";break;}
    case 4:{appsettings.saveSystemSetting ("timerduration", 900000 )
        banner.showText ("Duration Set To 15 Minutes")
       autoreload.interval="900000";break;}
    case 5:{appsettings.saveSystemSetting ("timerduration", 1200000 )
        banner.showText ("Duration Set To 20 Minutes")
       autoreload.interval="1200000";break;}
    case 6:{appsettings.saveSystemSetting ("timerduration", 1500000  )
        banner.showText ("Duration Set To 25 Minutes")
       autoreload.interval="1500000";break;}

    case 7: {appsettings.saveSystemSetting ("timerduration", 1800000  )
        banner.showText ("Duration Set To 30 Minutes")
       autoreload.interval="1800000";break;}
    }

}

content: Item{anchors.fill: parent

    TumblerColumn{
        anchors.fill: parent

        id:col

        items: ListModel {
        ListElement {
            value: "30 Seconds"
        }
        ListElement {
            value: "1 Minute"
        }
        ListElement {
            value: "5 Minutes"
        }
        ListElement {
            value: "10 Minutes"
        }ListElement {
            value: "15 Minutes"
        }
        ListElement {
            value: "20 Minutes"
        }
        ListElement {
            value: "25 Minutes"
        }
        ListElement{
            value: "30 Minutes"
        }
        }

    }
    Tumbler {id: tumb
    anchors{top:parent.top; topMargin: 4; right:parent.right; left:parent.left; bottom:parent.bottom}
    columns: [col]}
}
}




