/**
Copyright (C) 2020 Allstar Software (Paul Wallace)
*/
import QtQuick 1.1
import com.nokia.symbian 1.1

ContextMenuer{
    id: root
    Component.onCompleted: {open() }
property bool __isClosing: false
    onStatusChanged: {
        if (status === DialogStatus.Closing) __isClosing = true
        else if (status === DialogStatus.Closed && __isClosing) root.destroy()
    }
    MenuLayout{
      MenuItemer{
          text: "Delete Bookmark"
          onClicked:{
              opendeletedialog()
          }
      }
      MenuItemer{
          text: "Edit Bookmark"
          onClicked:{
              openedit()
          }
          }
      MenuItemer{text:"Export Bookmark"
          onClicked:exportBook();
      }
      MenuItemer{
          text: "Share Bookmark"
          onClicked:{sharebookmark()}
      }
      MenuItemer{
          text: "Open In Default Browser"
          onClicked: {openindefault()}
    }
      MenuItemer{
          text: "Set As Homepage"
          onClicked:{sethomepage()}
      }
      MenuItemer{
          text: "Copy Bookmark To Clipboard"
          onClicked:{copytoclip();banner.showText("URL Copied To Clipboard")}
      }
    }
}



