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
       /* MenuItemer{
            text:"Play Video"
            onClicked: {openVideoPlayer();}
        }*/
        MenuItemer{
            text:"Download Video"
            onClicked: {var name; name= "video" + ".mp4"; downloadBackend.addFromQML(requestedVideoURL, name)}
        }
    }

}
