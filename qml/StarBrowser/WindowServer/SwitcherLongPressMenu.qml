/**
Copyright (C) 2020 Allstar Software (Paul Wallace)
*/
import QtQuick 1.1
import com.nokia.symbian 1.1
import "../"
import "../dbcore.js" as DBcore
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
        text: "Bookmark Window"
        function title(){  if(selectedWindow===0){return windowserver.w0Title}
            else if(selectedWindow===1){return windowserver.w1Title}
            else if(selectedWindow===2){return windowserver.w2Title}
            else if(selectedWindow===3){return windowserver.w3Title}
            else if(selectedWindow===4){return windowserver.w4Title}
            else if(selectedWindow===5){return windowserver.w5Title}
            else if(selectedWindow===6){return windowserver.w6Title}
        }
        function url(){  if(selectedWindow===0){return windowserver.w0Url}
            else if(selectedWindow===1){return windowserver.w1Url}
            else if(selectedWindow===2){return windowserver.w2Url}
            else if(selectedWindow===3){return windowserver.w3Url}
            else if(selectedWindow===4){return windowserver.w4Url}
            else if(selectedWindow===5){return windowserver.w5Url}
            else if(selectedWindow===6){return windowserver.w6Url}

        }
        onClicked:{
        var itemnew = DBcore.defaultItem();
            itemnew.title = title();
            itemnew.url = url();
            itemnew.creationdate = Qt.formatDateTime(new Date(), "dd/MM/yy");
            DBcore.createBookmark(itemnew);
            banner.showText("Bookmark Saved "+title())
        }
    }

    MenuItemer{
        text:"Reload All Windows"
        onClicked: windowserver.reloadAllWindows();
    }
    MenuItemer{
        visible:windowserver.openWindows? 1:0
        text:"Close All Windows"
        onClicked: windowserver.closeAllWindows();
    }

}
}
