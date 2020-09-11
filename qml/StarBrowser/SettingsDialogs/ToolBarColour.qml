/**
Copyright (C) 2020 Allstar Software (Paul Wallace)
*/
import QtQuick 1.1
import com.nokia.symbian 1.1

import "../ComponentsSB"
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
        MenuItemer{
            id: defaulttool
            text: "Default"
            onClicked: {
                appsettings.saveSystemSetting ("toolbarcolour", "")
                appsettings.saveSystemSetting ("tooltitle", defaulttool.text)
                 toolcol.title= "Toolbar Colour: Default"
                 toolbar.color= "#0f0f0a"
            }
             ColourPeeker{colour:"#0f0f0a"}
        }
            MenuItemer{
                id: bluetool
                text: "Blue"
                onClicked: {
                    appsettings.saveSystemSetting ("toolbarcolour", "#0000FF")
                    appsettings.saveSystemSetting ("tooltitle", bluetool.text)
                 toolcol.title= "Toolbar Colour: Blue"
                     toolbar.color= "#0000FF"
               }
                ColourPeeker{colour:"#0000FF"}
        }
            MenuItemer{
                id: limetool
                text: "Lime"
                onClicked: {
                    appsettings.saveSystemSetting ("toolbarcolour", "#00FF00")
                    appsettings.saveSystemSetting ("tooltitle", limetool.text)
                 toolcol.title= "Toolbar Colour: Lime"
                     toolbar.color= "#00FF00"
                }
                 ColourPeeker{colour:"#00FF00"}
        }
            MenuItemer{
                id: redtool
                text: "Red"
                onClicked: {
                    appsettings.saveSystemSetting ("toolbarcolour", "#FF0000")
                    appsettings.saveSystemSetting ("tooltitle", redtool.text)
                 toolcol.title= "Toolbar Colour: Red"
                    toolbar.color= "#FF0000"
                }
                 ColourPeeker{colour:"#FF0000"}
        }
            MenuItemer{
                id: pinktool
                text: "Magenta"
                onClicked: {
                    appsettings.saveSystemSetting ("toolbarcolour", "#FF00FF")
                    appsettings.saveSystemSetting ("tooltitle", pinktool.text)
                 toolcol.title= "Toolbar Colour: Magenta"
                     toolbar.color= "#FF00FF"
                }
                 ColourPeeker{colour:"#FF00FF"}
        }
            MenuItemer{
                id: greentool
                text: "Green"
                onClicked: {
                    appsettings.saveSystemSetting ("toolbarcolour", "#008000")
                    appsettings.saveSystemSetting ("tooltitle", greentool.text)
                     toolcol.title= "Toolbar Colour: Green"
                     toolbar.color= "#008000"
               }
                 ColourPeeker{colour:"#008000"}
        }
            MenuItemer{
                id:cyantool
                text: "Cyan"
                onClicked: {
                    appsettings.saveSystemSetting ("toolbarcolour", "#00FFFF")
                    appsettings.saveSystemSetting ("tooltitle", cyantool.text)
                     toolcol.title= "Toolbar Colour: Cyan"
                     toolbar.color= "#00FFFF"
               }
                 ColourPeeker{colour:"#00FFFF"}
        }
            MenuItemer{
                id: purpletool
                text: "Purple"
                onClicked: {
                    appsettings.saveSystemSetting ("toolbarcolour", "#800080")
                    appsettings.saveSystemSetting ("tooltitle", purpletool.text)
                     toolcol.title= "Toolbar Colour: Purple"
                     toolbar.color= "#800080"
               }
                 ColourPeeker{colour:"#800080"}
        }
            MenuItemer{
                id: blacktool
                text: "Black"
                onClicked: {
                    appsettings.saveSystemSetting ("toolbarcolour", "#000000")
                    appsettings.saveSystemSetting ("tooltitle", blacktool.text)
                     toolcol.title= "Toolbar Colour: Black"
                     toolbar.color= "#000000"
               }
                 ColourPeeker{colour:"#000000"}
        }
            MenuItemer{
                id: dbluetool
                text: "Dark Blue"
                onClicked: {
                    appsettings.saveSystemSetting ("toolbarcolour", "#0000A0")
                    appsettings.saveSystemSetting ("tooltitle", dbluetool.text)
                    toolcol.title= "Toolbar Colour: Dark Blue"
                     toolbar.color= "#0000A0"
               }
                 ColourPeeker{colour:"#0000A0"}
        }
            MenuItemer{
                id: rbluetool
                text: "Royal Blue"
                onClicked: {
                    appsettings.saveSystemSetting ("toolbarcolour", "#2B60DE")
                    appsettings.saveSystemSetting ("tooltitle", rbluetool.text)
                   toolcol.title= "Toolbar Colour: Royal Blue"
                     toolbar.color= "#2B60DE"
               }
                 ColourPeeker{colour:"#2B60DE"}
        }
            MenuItemer{
                id: violettool
                text: "Violet"
                onClicked: {
                    appsettings.saveSystemSetting ("toolbarcolour", "#8D38C9")
                    appsettings.saveSystemSetting ("tooltitle", violettool.text)
                 toolcol.title= "Toolbar Colour: Violet"
                     toolbar.color= "#8D38C9"
               }
                 ColourPeeker{colour:"#8D38C9"}
        }
            MenuItemer{
                id: violetredtool
                text: "Violet Red"
                onClicked: {
                    appsettings.saveSystemSetting ("toolbarcolour", "#F6358A")
                    appsettings.saveSystemSetting ("tooltitle", violetredtool.text)
                     toolcol.title= "Toolbar Colour: Violet Red"
                     toolbar.color= "#F6358A"
               }
                 ColourPeeker{colour:"#F6358A"}
        }
            MenuItemer{
                id: darkviolettool
                text: "Dark Violet"
                onClicked: {
                    appsettings.saveSystemSetting ("toolbarcolour", "#842DCE")
                    appsettings.saveSystemSetting ("tooltitle", darkviolettool.text)
                 toolcol.title= "Toolbar Colour: Dark Violet"
                     toolbar.color= "#842DCE"
               }
                 ColourPeeker{colour:"#842DCE"}
        }
            MenuItemer{
                id: springgreentool
                text: "Spring Green"
                onClicked: {
                    appsettings.saveSystemSetting ("toolbarcolour", "#4AA02C")
                    appsettings.saveSystemSetting ("tooltitle", springgreentool.text)
                 toolcol.title= "Toolbar Colour: Spring Green"
                     toolbar.color= "#4AA02C"
               }
                 ColourPeeker{colour:"#4AA02C"}
        }

            MenuItemer{
                id: goldtool
                text: "Gold"
                onClicked: {
                    appsettings.saveSystemSetting ("toolbarcolour", "#D4A017")
                    appsettings.saveSystemSetting ("tooltitle", goldtool.text)
                     toolcol.title= "Toolbar Colour: Gold"
                     toolbar.color= "#D4A017"
               }
                 ColourPeeker{colour:"#D4A017"}
        }
            MenuItemer{
                id: darkorangetool
                text: "Dark Orange"
                onClicked: {
                    appsettings.saveSystemSetting ("toolbarcolour", "#F88017")
                    appsettings.saveSystemSetting ("tooltitle", darkorangetool.text)
                     toolcol.title= "Toolbar Colour: Dark Orange"
                     toolbar.color= "#F88017"
               }
                 ColourPeeker{colour:"#F88017"}
        }
            MenuItemer{
                id: coraltool
                text: "Coral"
                onClicked: {
                    appsettings.saveSystemSetting ("toolbarcolour", "#F76541")
                    appsettings.saveSystemSetting ("tooltitle", coraltool.text)
                   toolcol.title= "Toolbar Colour: Coral"
                     toolbar.color= "#F76541"
               }
                 ColourPeeker{colour:"#F76541"}
        }
            MenuItemer{
                id: seagreentool
                text: "Sea Green"
                onClicked: {
                    appsettings.saveSystemSetting ("toolbarcolour", "#4E8975")
                    appsettings.saveSystemSetting ("tooltitle", seagreentool.text)
                    toolcol.title= "Toolbar Colour: Sea Green"
                     toolbar.color= "#4E8975"
               }
                 ColourPeeker{colour:"#4E8975"}
        }
            MenuItemer{
                id: lightslatebluetool
                text: "Light Slate Blue"
                onClicked: {
                    appsettings.saveSystemSetting ("toolbarcolour", "#736AFF")
                    appsettings.saveSystemSetting ("tooltitle", lightslatebluetool.text)
                    toolcol.title= "Toolbar Colour: Light Slate Blue"
                     toolbar.color= "#736AFF"
               }
                 ColourPeeker{colour:"#736AFF"}
        }
            MenuItemer{
                id: darkorchidtool
                text: "Dark Orchid"
                onClicked: {
                    appsettings.saveSystemSetting ("toolbarcolour", "#B041FF")
                    appsettings.saveSystemSetting ("tooltitle", darkorchidtool.text)
                     toolcol.title= "Toolbar Colour: Dark Orchid"
                     toolbar.color= "#B041FF"
               }
                 ColourPeeker{colour:"#B041FF"}
        }
            MenuItemer{
                id: olivetool
                text: "Olive"
                onClicked: {
                    appsettings.saveSystemSetting ("toolbarcolour", "#808000")
                    appsettings.saveSystemSetting ("tooltitle", olivetool.text)
                    toolcol.title= "Toolbar Colour: Olive"
                     toolbar.color= "#808000"
               }
                 ColourPeeker{colour:"#808000"}
        }
}
}
