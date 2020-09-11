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
            id: google
            text: "Google"
            platformSubItemIndicator: true
            onClicked: {openglobalgoogle();}
        }
            MenuItemer{
                id: bing
                text: "Bing"
                onClicked: {
                    appsettings.saveSystemSetting ("searchengine", "http://www.bing.com/search?q=")
                      appsettings.saveSystemSetting ("enginetitle", bing.text)
                    engsub.text= "Search Engine: Bing"
                }
        }
            MenuItemer{
                id: yahoo
                text: "Yahoo"
                onClicked: {
                    appsettings.saveSystemSetting ("searchengine", "http://search.yahoo.com/search?p=")
                      appsettings.saveSystemSetting ("enginetitle", yahoo.text)
                    engsub.text= "Search Engine: Yahoo"
                }
        }
            MenuItemer{
                id: ask
                text: "Ask"
                onClicked: {
                    appsettings.saveSystemSetting ("searchengine", "http://www.ask.com/web?q=")
                      appsettings.saveSystemSetting ("enginetitle", ask.text)
                     engsub.text= "Search Engine: Ask"
                }
        }
            MenuItemer{
                id: duck
                text: "DuckDuckGo"
                onClicked: {
                    appsettings.saveSystemSetting ("searchengine", "https://duckduckgo.com/?q=")
                      appsettings.saveSystemSetting ("enginetitle", duck.text)
                     engsub.text= "Search Engine: DuckDuckGo"
                }
        }


}


}
