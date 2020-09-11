/**
Copyright (C) 2020 Allstar Software (Paul Wallace)
*/
import QtQuick 1.1
import com.nokia.symbian 1.1
import "../"
import "../ComponentsSB"

ContextMenuer{
    id: root
    Component.onCompleted: { open();}
property bool __isClosing: false
    onStatusChanged: {
        if (status === DialogStatus.Closing) __isClosing = true
        else if (status === DialogStatus.Closed && __isClosing) root.destroy()
    }
    MenuLayout{
        MenuItemer{
            id: red
            text: "Red (default)"
            onClicked: {
                appsettings.saveSystemSetting ("progresscolour", "red")
                appsettings.saveSystemSetting ("pctitle", red.text)
             progressList.title= " Progress Bar Colour: Red"
                progressColour="red"
            }
                 ColourPeeker{colour:"red"}
        }
        MenuItemer{
            id: blue
            text: "Blue"
            onClicked: {
                appsettings.saveSystemSetting ("progresscolour", "blue")
                appsettings.saveSystemSetting ("pctitle", blue.text)
             progressList.title= " Progress Bar Colour: Blue"
                progressColour="blue"
            }
                 ColourPeeker{colour:"blue"}
        }

        MenuItemer{
            id: green
            text: "Green"
            onClicked: {
                appsettings.saveSystemSetting ("progresscolour", "green")
                appsettings.saveSystemSetting ("pctitle", green.text)
             progressList.title= " Progress Bar Colour: Green"
                progressColour="green"
            }
                 ColourPeeker{colour:"green"}
        }
        MenuItemer{
            id: orange
            text: "Orange"
            onClicked: {
                appsettings.saveSystemSetting ("progresscolour", "orange")
                appsettings.saveSystemSetting ("pctitle", orange.text)
             progressList.title= " Progress Bar Colour: Orange"
                progressColour="orange"
            }
                 ColourPeeker{colour:"orange"}
        }
        MenuItemer{
            id: yellow
            text: "Yellow"
            onClicked: {
                appsettings.saveSystemSetting ("progresscolour", "yellow")
                appsettings.saveSystemSetting ("pctitle", yellow.text)
             progressList.title= " Progress Bar Colour: Yellow"
                progressColour="yellow"
            }
                 ColourPeeker{colour:"yellow"}
        }
        MenuItemer{
                    id: pink
                    text: "Pink"
                    onClicked: {
                        appsettings.saveSystemSetting ("progresscolour", "pink")
                        appsettings.saveSystemSetting ("pctitle", pink.text)
                     progressList.title= " Progress Bar Colour: Pink"
                        progressColour="pink"
                    }
                         ColourPeeker{colour:"pink"}
                }
        MenuItemer{
                    id: violet
                    text: "Violet"
                    onClicked: {
                        appsettings.saveSystemSetting ("progresscolour", "#8D38C9")
                        appsettings.saveSystemSetting ("pctitle", violet.text)
                     progressList.title= " Progress Bar Colour: Violet"
                        progressColour="#8D38C9"
                    }
                    ColourPeeker{colour:"#8D28C9"}
                }
        MenuItemer{
            id: darkb
            text: "Dark Blue"
            onClicked: {
                appsettings.saveSystemSetting ("progresscolour", "#0000A0")
                appsettings.saveSystemSetting ("pctitle", darkb.text)
             progressList.title= " Progress Bar Colour: Dark Blue"
                progressColour="#0000A0"
            }
                 ColourPeeker{colour:"#0000A0"}
        }
        MenuItemer{
            id: qablue
            text: "Star Browser Blue"
            onClicked: {
                appsettings.saveSystemSetting ("progresscolour", "#00aaff")
                appsettings.saveSystemSetting ("pctitle", qablue.text)
             progressList.title= " Progress Bar Colour: Star Browser Blue"
                progressColour="#00aaff"
            }
                 ColourPeeker{colour:"#00aaff"}
        }
        MenuItemer{
            id:  white
            text: "White"
            onClicked: {
                appsettings.saveSystemSetting ("progresscolour", "white")
                appsettings.saveSystemSetting ("pctitle", white.text)
             progressList.title= " Progress Bar Colour: White"
                progressColour="white"
            }
                 ColourPeeker{colour:"white"}
        }
        MenuItemer{
            id: purple
            text: "Purple"
            onClicked: {
                appsettings.saveSystemSetting ("progresscolour", "#800080")
                appsettings.saveSystemSetting ("pctitle", darkb.text)
             progressList.title= " Progress Bar Colour: Purple"
                progressColour="#800080"
            }
                 ColourPeeker{colour:"#800080"}
        }
        MenuItemer{
            id: cyan
            text: "Cyan"
            onClicked: {
                appsettings.saveSystemSetting ("progresscolour", "#00FFFF")
                appsettings.saveSystemSetting ("pctitle", cyan.text)
             progressList.title= " Progress Bar Colour: Cyan"
                progressColour="#00FFFF"
            }
                 ColourPeeker{colour:"#00FFFF"}
        }
        MenuItemer{
            id: mag
            text: "Magenta"
            onClicked: {
                appsettings.saveSystemSetting ("progresscolour", "#FF00FF")
                appsettings.saveSystemSetting ("pctitle", mag.text)
             progressList.title= " Progress Bar Colour: Magenta"
                progressColour="#FF00FF"
            }
                 ColourPeeker{colour:"#FF00FF"}
        }
    }
}
