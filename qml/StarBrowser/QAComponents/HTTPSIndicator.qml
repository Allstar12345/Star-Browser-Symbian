/**
Copyright (C) 2020 Allstar Software (Paul Wallace)
*/
import QtQuick 1.1

Image{
    sourceSize.height: 23
    sourceSize.width: 23
    width: sourceSize.width
    height: sourceSize.height
    source:"../img/lock_flat.svg"
    visible:true
    opacity:0
    z: 10
    id: img
    Connections {target:root
        onHidehttpsIcon:{img.opacity=0; img.destroy()}
    }
    Component.onCompleted: {starter.start();}
    Behavior on opacity{NumberAnimation{}}
    Timer{id: starter; interval:1000; onTriggered:{opacity=1}}
    anchors{top:parent.top; right:parent.right; rightMargin: 1; topMargin: 1}
}

