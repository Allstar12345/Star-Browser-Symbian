/**
Copyright (C) 2020 Allstar Software (Paul Wallace)
*/
import Qt 4.7
Rectangle {
    id: nightcover
    visible: false
    anchors.fill: parent
    color: "black"
    opacity: appsettings.getSystemSetting("nightcoveropa", "0.6")
    z: Infinity
}
