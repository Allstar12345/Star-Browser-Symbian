/**
Copyright (C) 2020 Allstar Software (Paul Wallace)
*/
import QtQuick 1.1

Text {
    id: root
    font {
        family: platformStyle.fontFamilyRegular
        pixelSize: platformStyle.fontSizeLarge
        weight: Font.Normal
    }
    color: "white"
    elide: Text.ElideRight
    horizontalAlignment:Text.AlignLeft
}
