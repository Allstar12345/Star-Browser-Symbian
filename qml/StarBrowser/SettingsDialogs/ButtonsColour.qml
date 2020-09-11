/**
Copyright (C) 2020 Allstar Software (Paul Wallace)
*/
import QtQuick 1.1
import com.nokia.symbian 1.1
import "../"
import"../ComponentsSB"


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
            id: cus
            text:"Custom Colour"
            onClicked:{
                openCustomColour();
            }
            ColourPeeker{visible:appsettings.getSystemSetting("colourtitleqa", "")==="Custom"? true:false; color:popupbutton.colour}
        }

        MenuItemer{
            id: defaultc
            text: "Default"
            onClicked: {
                appsettings.saveSystemSetting ("newfloatingsource", "#00aaff")
                appsettings.saveSystemSetting ("colourtitleqa", defaultc.text)
                appsettings.saveSystemSetting("switchsource", "img/Switch/qtg_graf_switchbutton_fill_default.svg")
                switchSource= "img/Switch/qtg_graf_switchbutton_fill_default.svg"
                butcol.title= "QA Colour: Default"
                popupbutton.colour= "#00aaff"
            }
             ColourPeeker{colour:"#00aaff"}
        }
        MenuItemer{
            id: orange
            text: "Orange"
            onClicked: {
                appsettings.saveSystemSetting ("newfloatingsource", "Orange")
                appsettings.saveSystemSetting ("colourtitleqa", orange.text)
                appsettings.saveSystemSetting("switchsource", "img/Switch/qtg_graf_switchbutton_fill_orange.svg")
                switchSource= "img/Switch/qtg_graf_switchbutton_fill_orange.svg"
                butcol.title= "QA Colour: Orange"
                popupbutton.colour= "Orange"
            }
             ColourPeeker{colour:"Orange"}
        }
            MenuItemer{
                id: blue
                text: "Blue"
                onClicked: {
                    appsettings.saveSystemSetting ("newfloatingsource", "Blue")
                    appsettings.saveSystemSetting ("colourtitleqa", blue.text)
                    appsettings.saveSystemSetting("switchsource", "img/Switch/qtg_graf_switchbutton_fill_blue.svg")
                    switchSource= "img/Switch/qtg_graf_switchbutton_fill_blue.svg"
                 butcol.title= "QA Colour: Blue"
                    popupbutton.colour= "Blue"
               }
                 ColourPeeker{colour:"blue"}
        }
            MenuItemer{
                id: lime
                text: "Lime"
                onClicked: {
                    appsettings.saveSystemSetting ("newfloatingsource", "lime")
                    appsettings.saveSystemSetting ("colourtitleqa", lime.text)
                    appsettings.saveSystemSetting("switchsource", "img/Switch/qtg_graf_switchbutton_fill_lime.svg")
                    switchSource= "img/Switch/qtg_graf_switchbutton_fill_lime.svg"
                 butcol.title= "QA Colour: Lime"
                    popupbutton.colour= "lime"
                }
                 ColourPeeker{colour:"lime"}
        }
            MenuItemer{
                id: red
                text: "Red"
                onClicked: {
                    appsettings.saveSystemSetting ("newfloatingsource", "red")
                    appsettings.saveSystemSetting ("colourtitleqa", red.text)
                    appsettings.saveSystemSetting("switchsource", "img/Switch/qtg_graf_switchbutton_fill_red.svg")
                    switchSource= "img/Switch/qtg_graf_switchbutton_fill_red.svg"
                 butcol.title= "QA Colour: Red"
                    popupbutton.colour= "red"
                }
                 ColourPeeker{colour:"red"}
        }
            MenuItemer{
                id: pink
                text: "Magenta"
                onClicked: {
                    appsettings.saveSystemSetting ("newfloatingsource", "#FF00FF")
                    appsettings.saveSystemSetting ("colourtitleqa", pink.text)
                    appsettings.saveSystemSetting("switchsource", "img/Switch/qtg_graf_switchbutton_fill_Magenta.svg")
                    switchSource= "img/Switch/qtg_graf_switchbutton_fill_Magenta.svg"
                 butcol.title= "QA Colour: Magenta"
                    popupbutton.colour= "#FF00FF"

                }
                 ColourPeeker{colour:"#FF00FF"}
        }
            MenuItemer{
                id: green
                text: "Green"
                onClicked: {
                    appsettings.saveSystemSetting ("newfloatingsource", "green")
                    appsettings.saveSystemSetting ("colourtitleqa", green.text)
                    appsettings.saveSystemSetting("switchsource", "img/Switch/qtg_graf_switchbutton_fill_green.svg")
                    switchSource= "img/Switch/qtg_graf_switchbutton_fill_green.svg"
                 butcol.title= "QA Colour: Green"
                    popupbutton.colour= "green"
               }
                 ColourPeeker{colour:"green"}
        }

            MenuItemer{
                id: purple
                text: "Purple"
                onClicked: {
                    appsettings.saveSystemSetting ("newfloatingsource", "purple")
                    appsettings.saveSystemSetting ("colourtitleqa", purple.text)
                    appsettings.saveSystemSetting("switchsource", "img/Switch/qtg_graf_switchbutton_fill_purple.svg")
                    switchSource= "img/Switch/qtg_graf_switchbutton_fill_purple.svg"
                 butcol.title= "QA Colour: Purple"
                    popupbutton.colour= "purple"
               }
                 ColourPeeker{colour:"purple"}
        }
            MenuItemer{
                id: black
                text: "Black"
                onClicked: {
                    appsettings.saveSystemSetting ("newfloatingsource", "black")
                    appsettings.saveSystemSetting ("colourtitleqa", black.text)
                    appsettings.saveSystemSetting("switchsource", "")
                    switchSource= "img/Switch/qtg_graf_switchbutton_fill.svg";
                 butcol.title= "QA Colour: Black"
                    popupbutton.colour= "black"
               }
                 ColourPeeker{colour:"black"}
        }

}
}
