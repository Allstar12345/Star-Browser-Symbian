/**
Copyright (C) 2020 Allstar Software (Paul Wallace)
*/
import QtQuick 1.1
import com.nokia.symbian 1.1
import "../"
ContextMenuer{
    id: roote
    property bool __isClosing: false
        onStatusChanged: {
            if (status === DialogStatus.Closing) __isClosing = true
            else if (status === DialogStatus.Closed && __isClosing) roote.destroy()
        }
        Component.onCompleted: { open()}
MenuLayout{

    MenuItemer{
        text:"Open In Current Window"
        onClicked: {webViewHidden=false;web_view1.url=link;root1.destroy();root.destroy(); }
    }
    MenuItemer{
        text:"Open In New Window"
        onClicked: {
            if(windowserver.w1open===false)windowserver.openWindowIntoURL(1, link)
            else if(windowserver.w2open===false)windowserver.openWindowIntoURL(2, link)
            else if(windowserver.w3open===false)windowserver.openWindowIntoURL(3, link)
            else if(windowserver.w4open===false)windowserver.openWindowIntoURL(4, link)
            else if(windowserver.w5open===false)windowserver.openWindowIntoURL(5, link)
            else if(windowserver.w6open===false)windowserver.openWindowIntoURL(6, link)

            root1.destroy();
            root.destroy();
             }
    }

}
}
