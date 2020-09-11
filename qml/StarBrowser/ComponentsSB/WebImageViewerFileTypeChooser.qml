/**
Copyright (C) 2020 Allstar Software (Paul Wallace)
*/
import QtQuick 1.1
import "../"
import com.nokia.symbian 1.1
SelectionDialoger {
    property bool __isClosing: false

        onStatusChanged: {
            if (status === DialogStatus.Closing) __isClosing = true
            else if (status === DialogStatus.Closed && __isClosing) {name="image"+decide(); root.destroy(); download.addFromQML(requestedImageURL, name);closePage();}
        }

        function decide(){
            if(selectedIndex===0) return ".jpg"
            else if (selectedIndex===1) return ".png"
            else if (selectedIndex===2) return ".gif"
        }
    id: selectionDialog
    titleText: "Choose A File Type"
    selectedIndex: null
   model:    ListModel {
       id: listModel
       ListElement {name: "JPG"}
       ListElement { name: "PNG" }
       ListElement { name: "GIF" }
   }
    Component.onCompleted: open();
}
