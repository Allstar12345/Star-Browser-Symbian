/**
Copyright (C) 2020 Allstar Software (Paul Wallace)
*/
import QtQuick 1.1
import "../"
ListItemer{
    Behavior on opacity {NumberAnimation{}}
    height: 50
    id: item
    property alias text: itemtext.text

    Text {
        id: itemtext
          color: "white"
          elide: Text.ElideRight
          font.pixelSize: 19
          width: parent.width-35
          wrapMode: Text.Wrap
          maximumLineCount: 1
          anchors{left: parent.left; horizontalCenter: parent.horizontalCenter; leftMargin: 5}
    }
}
