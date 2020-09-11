/**
Copyright (C) 2020 Allstar Software (Paul Wallace)
*/
import QtQuick 1.1
import com.nokia.symbian 1.1
import "../"


ContextMenuer{
    id: root

    property bool __isClosing: false
        onStatusChanged: {
            if (status === DialogStatus.Closing) __isClosing = true
            else if (status === DialogStatus.Closed && __isClosing) root.destroy()
        }
    Component.onCompleted: {
        open()
    }

    MenuLayout{
        MenuItemer{
            id: googleuk
            text: "Google UK"
            onClicked: {
                appsettings.saveSystemSetting ("searchengine", "http://www.google.co.uk/?gws_rd=ssl#q=")
                appsettings.saveSystemSetting ("enginetitle", googleuk.text)
                engsub.text= "Search Engine: Google UK"

            }
        }
            MenuItemer{
                id: googlein
                text: "Google International"
                onClicked: {
                    appsettings.saveSystemSetting ("searchengine", "http://www.google.com/m?q=")
                      appsettings.saveSystemSetting ("enginetitle", googlein.text)
                    engsub.text= "Search Engine: Google Inter"
                }
        }
            MenuItemer{
                id: googleger
                text: "Google Germany"
                onClicked: {
                    appsettings.saveSystemSetting ("searchengine", "https://www.google.de/?gws_rd=ssl#q=")
                      appsettings.saveSystemSetting ("enginetitle", googleger.text)
                     engsub.text= "Search Engine: Google Germany"
                }
        }
            MenuItemer{
                id: googlesp
                text: "Google Spain"
                onClicked: {
                    appsettings.saveSystemSetting ("searchengine", "https://www.google.es/?gws_rd=ssl#q=")
                      appsettings.saveSystemSetting ("enginetitle", googlesp.text)
                    engsub.text= "Search Engine: Google Spain"
                }
        }
            MenuItemer{
                id: googlefr
                text: "Google France"
                onClicked: {
                    appsettings.saveSystemSetting ("searchengine", "https://www.google.fr/?gws_rd=ssl#q=")
                      appsettings.saveSystemSetting ("enginetitle", googlefr.text)
                    engsub.text= "Search Engine: Google France"
                }
        }
            MenuItemer{
                id: googleinf
                text: "Google India"
                onClicked: {
                    appsettings.saveSystemSetting ("searchengine", "https://www.google.co.in/?gws_rd=ssl#q=")
                      appsettings.saveSystemSetting ("enginetitle", googleind.text)
                     engsub.text= "Search Engine: Google India"
                }
        }
            MenuItemer{
                id: googlepol
                text: "Google Poland"
                onClicked: {
                    appsettings.saveSystemSetting ("searchengine", "https://www.google.pl/?gws_rd=ssl#q=")
                      appsettings.saveSystemSetting ("enginetitle", googlepol.text)
                     engsub.text= "Search Engine: Google Poland"
                }
        }


}
}
