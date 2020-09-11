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
            else if (status === DialogStatus.Closed && __isClosing) root.destroy()
        }
    Component.onCompleted: {
        open()
    }

    MenuLayout{

        MenuItemer{
            id: black
            text: "Black (default)"
            onClicked: {
                appsettings.saveSystemSetting ("bannercolour", "black")
                appsettings.saveSystemSetting ("bantitle", black.text)
             bannerList.title= "Banner Colour: Black"
                banner.color= "black"
            }
             ColourPeeker{colour:"black"}
        }
        MenuItemer{
            id: red
            text: "Red"
            onClicked: {
                appsettings.saveSystemSetting ("bannercolour", "red")
                appsettings.saveSystemSetting ("bantitle", red.text)
             bannerList.title= "Banner Colour: Red"
                 banner.color= "red"
            }
            ColourPeeker{colour:"red"}
        }
        MenuItemer{
            id: green
            text: "Green"
            onClicked: {
                appsettings.saveSystemSetting ("bannercolour", "green")
                appsettings.saveSystemSetting ("bantitle", green.text)
             bannerList.title= "Banner Colour: Green"
                 banner.color= "green"
            }
             ColourPeeker{colour:"green"}
        }
        MenuItemer{
            id: blue
            text: "Blue"
            onClicked: {
                appsettings.saveSystemSetting ("bannercolour", "blue")
                appsettings.saveSystemSetting ("bantitle", blue.text)
             bannerList.title= "Banner Colour: Blue"
                 banner.color= "blue"
            }
             ColourPeeker{colour:"blue"}
        }
        MenuItemer{
            id: sbb
            text: "Star Browser Blue"
            onClicked: {
                appsettings.saveSystemSetting ("bannercolour", "#00aaff")
                appsettings.saveSystemSetting ("bantitle", sbb.text)
             bannerList.title= "Banner Colour: Star Browser Blue"
                 banner.color= "#00aaff"
            }
             ColourPeeker{colour:"#00aaff"}
        }

        MenuItemer{
            id: purple
            text: "Purple"
            onClicked: {
                appsettings.saveSystemSetting ("bannercolour", "#800080")
                appsettings.saveSystemSetting ("bantitle", purple.text)
             bannerList.title= "Banner Colour: Purple"
                 banner.color= "#800080"
            }
             ColourPeeker{colour:"#800080"}
        }
        MenuItemer{
            id: gold
            text: "Gold"
            onClicked: {
                appsettings.saveSystemSetting ("bannercolour", "#D4A023")
                appsettings.saveSystemSetting ("bantitle", gold.text)
             bannerList.title= "Banner Colour: Gold"
                 banner.color= "#D4A023"
            }
             ColourPeeker{colour:"#D4A023"}
        }
    }
}
