/**
Copyright (C) 2020 Allstar Software (Paul Wallace)
*/
import QtQuick 1.1
import com.nokia.symbian 1.1
ContextMenuer{
    id: root
    property bool __isClosing: false
        onStatusChanged: {
            if (status === DialogStatus.Closing) __isClosing = true
            else if (status === DialogStatus.Closed && __isClosing) root.destroy()
        }
        Component.onCompleted: { open(); }
MenuLayout{
    MenuItemer{
        text:"Save Page Source Code"
        onClicked: exportSourceCode();
    }
    MenuItemer{
        text:"Copy Page Source Code"
        onClicked:copydelay.start();
    }
}
}
