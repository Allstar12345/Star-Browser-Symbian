/**
Copyright (C) 2020 Allstar Software (Paul Wallace)
*/
import QtQuick 1.1
import com.nokia.symbian 1.1

ContextMenuer{
    id: root
    Component.onCompleted: {
        open()
    }
property bool __isClosing: false
    onStatusChanged: {
        if (status === DialogStatus.Closing) __isClosing = true
        else if (status === DialogStatus.Closed && __isClosing) root.destroy()
    }
    MenuLayout{
      MenuItemer{
          text: "Delete History Item"
          onClicked:{
              opendeletedialog()
          }
      }
      MenuItemer{
          text: "Open In Default Browser"
          onClicked: {openindefault()}
    }
      MenuItemer{
          text: "Copy URL To Clipboard"
          onClicked:{copytoclip();banner.showText("URL Copied To Clipboard")}
      }
      MenuItemer{
          text: "Set As Homepage"
          onClicked:{sethomepage()}
      }
      MenuItemer{
          text: "Save To Bookmarks"
          onClicked:{saveHToB()}
      }
    }
}



