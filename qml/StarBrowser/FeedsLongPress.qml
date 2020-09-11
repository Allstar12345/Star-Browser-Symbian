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
          text: "Delete Feed"
          onClicked:{
              opendeletedialog()
          }
      }
      MenuItemer{
          text:"Edit Feed"
          onClicked:{openeditfeed();}
      }
      MenuItemer{
          text:"Open in Symbian browser"
          onClicked:{QMLUtils.openBrowser(bmView.currentItem.myData.url)}
      }

    }
}



