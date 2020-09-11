/**
Copyright (C) 2020 Allstar Software (Paul Wallace)
*/
import QtQuick 1.1
import com.nokia.symbian 1.1
import "../"
import "../ComponentsSB"


ContextMenuer{
    id: root
    property bool __isClosing: false
        onStatusChanged: {
            if (status === DialogStatus.Closing) __isClosing = true
            else if (status === DialogStatus.Closed && __isClosing) root.destroy()}
    Component.onCompleted: {open()}
    MenuLayout{
        MenuItemer{
            id: blue
            text: "Default"
            onClicked: {
            appsettings.saveSystemSetting("toolbuttonsource", "qrc:/qml/StarBrowser/img/ToolButton/blue.svg")
            appsettings.saveSystemSetting("buttonsource", "qrc:/qml/StarBrowser/img/Button/blue.svg")
            btnBack.highlightSource= "qrc:/qml/StarBrowser/img/ToolButton/blue.svg";
            btnTips.highlightSource= "qrc:/qml/StarBrowser/img/Button/blue.svg";
            tbutcol.title="ToolButton Colour: Default";
            appsettings.saveSystemSetting("tbutcol", "Default" )
            }
             ColourPeeker{colour:"blue"}
        }
                MenuItemer{
                    id: red
                    text: "Red"
                    onClicked: {
                    appsettings.saveSystemSetting("toolbuttonsource", "qrc:/qml/StarBrowser/img/ToolButton/red.svg")
                    btnBack.highlightSource= "qrc:/qml/StarBrowser/img/ToolButton/red.svg";
                    appsettings.saveSystemSetting("buttonsource", "qrc:/qml/StarBrowser/img/Button/red.svg")
                    btnTips.highlightSource= "qrc:/qml/StarBrowser/img/Button/red.svg";
                    tbutcol.title="ToolButton Colour: Red";
                    appsettings.saveSystemSetting("tbutcol", "Red" )
                    }
                     ColourPeeker{colour:"red"}
                }
                MenuItem{
                    id: green
                    text: "Green"
                    onClicked: {
                    appsettings.saveSystemSetting("toolbuttonsource", "qrc:/qml/StarBrowser/img/ToolButton/green.svg")
                    btnBack.highlightSource= "qrc:/qml/StarBrowser/img/ToolButton/green.svg";
                        appsettings.saveSystemSetting("buttonsource", "qrc:/qml/StarBrowser/img/Button/green.svg")
                        btnTips.highlightSource= "qrc:/qml/StarBrowser/img/Button/green.svg";
                         tbutcol.title="ToolButton Colour: Green";
                        appsettings.saveSystemSetting("tbutcol", "Green" )
                    }
                     ColourPeeker{colour:"green"}
                }
                MenuItemer{
                    id: magenta
                    text: "Magenta"
                    onClicked: {
                    appsettings.saveSystemSetting("toolbuttonsource", "qrc:/qml/StarBrowser/img/ToolButton/magenta.svg")
                    btnBack.highlightSource= "qrc:/qml/StarBrowser/img/ToolButton/magenta.svg";
                        appsettings.saveSystemSetting("buttonsource", "qrc:/qml/StarBrowser/img/Button/magenta.svg")
                        btnTips.highlightSource= "qrc:/qml/StarBrowser/img/Button/magenta.svg";
                         tbutcol.title="ToolButton Colour: Magenta";
                        appsettings.saveSystemSetting("tbutcol", "Magenta" )
                    }
                     ColourPeeker{colour:"#FF00FF"}
                }
                MenuItemer{
                    id: purple
                    text: "Purple"
                    onClicked: {
                    appsettings.saveSystemSetting("toolbuttonsource", "qrc:/qml/StarBrowser/img/ToolButton/purple.svg")
                    btnBack.highlightSource= "qrc:/qml/StarBrowser/img/ToolButton/purple.svg";
                        appsettings.saveSystemSetting("buttonsource", "qrc:/qml/StarBrowser/img/Button/purple.svg")
                        btnTips.highlightSource= "qrc:/qml/StarBrowser/img/Button/purple.svg";
                         tbutcol.title="ToolButton Colour: Purple";
                        appsettings.saveSystemSetting("tbutcol", "Purple" )
                    }
                     ColourPeeker{colour:"#800080"}
                }
                MenuItemer{
                    id: orange
                    text: "Orange"
                    onClicked: {
                    appsettings.saveSystemSetting("toolbuttonsource", "qrc:/qml/StarBrowser/img/ToolButton/orange.svg")
                    btnBack.highlightSource= "qrc:/qml/StarBrowser/img/ToolButton/orange.svg";
                        appsettings.saveSystemSetting("buttonsource", "qrc:/qml/StarBrowser/img/Button/orange.svg")
                        btnTips.highlightSource= "qrc:/qml/StarBrowser/img/Button/orange.svg";
                    tbutcol.title="ToolButton Colour: Orange";
                        appsettings.saveSystemSetting("tbutcol", "Orange" )
                    }
                     ColourPeeker{colour:"orange"}
                }
    }
}
