/**
Copyright (C) 2020 Allstar Software (Paul Wallace)
*/
import QtQuick 1.1
import "." 1.1
import com.nokia.symbian 1.1
import "AppManager.js" as Utils

Item {
    id: root

    // Common Public API
    property Item tab
    property bool checked: internal.tabGroup != null && internal.tabGroup.currentTab == tab
    property bool pressed: stateGroup.state == "Pressed" && mouseArea.containsMouse
    //property alias text: label.text
    property alias iconSource: imageLoader.source

    signal clicked

    // Symbian specific API
    property bool platformInverted: false

    implicitWidth: Math.max(2 * imageLoader.width, 2 * platformStyle.paddingMedium )
    implicitHeight: internal.portrait ? privateStyle.tabBarHeightPortrait : privateStyle.tabBarHeightLandscape

    QtObject {
        id: internal

        property Item tabGroup: Utils.findParent(tab, "currentTab")
        property bool portrait: screen.currentOrientation == Screen.Portrait || screen.currentOrientation == Screen.PortraitInverted

        function press() {
            privateStyle.play(Symbian.BasicButton)
        }
        function click() {
            root.clicked()
            privateStyle.play(Symbian.BasicButton)
            if (internal.tabGroup)
                internal.tabGroup.currentTab = tab
        }

        function isButtonRow(item) {
            return (item &&
                    item.hasOwnProperty("checkedButton") &&
                    item.hasOwnProperty("privateDirection") &&
                    item.privateDirection == Qt.Horizontal)
        }

        function imageName() {
            // If the parent of a TabButton is ButtonRow, segmented-style graphics
            // are used to create a seamless row of buttons. Otherwise normal
            // TabButton graphics are utilized.
            var mirror = root.LayoutMirroring.enabled // To create binding
            if (isButtonRow(parent))
                return parent.privateGraphicsName(root, 1)
            else
                return "qtg_fr_tab_"
        }

        function modeName() {
            if (isButtonRow(parent)) {
                return parent.privateModeName(root, 1)
            } else {
                return root.checked ? "active" : "passive_normal"
            }
        }

        function modeNamePressed() {
            if (isButtonRow(parent)) {
                return "pressed"
            } else {
                return "passive_pressed"
            }
        }
    }

    StateGroup {
        id: stateGroup

        states: [
            State {
                name: "Pressed"
                PropertyChanges { target: pressedGraphics; opacity: 1 }
            },
            State { name: "Canceled" }
        ]
        transitions: [
            Transition {
                to: "Pressed"
                ScriptAction { script: internal.press() }
            },
            Transition {
                from: "Pressed"
                to: ""
                NumberAnimation {
                    target: pressedGraphics
                    property: "opacity"
                    to: 0
                    duration: 150
                    easing.type: Easing.Linear
                }
                ScriptAction { script: internal.click() }
            }
        ]
    }

    BorderImage {
        id: background

        source: privateStyle.imagePath(internal.imageName() + internal.modeName(), root.platformInverted)
        anchors.fill: parent
        border {
            left: platformStyle.borderSizeMedium
            top: platformStyle.borderSizeMedium
            right: platformStyle.borderSizeMedium
            bottom: platformStyle.borderSizeMedium
        }
    }

    BorderImage {
        id: pressedGraphics

        source: privateStyle.imagePath(internal.imageName() + internal.modeNamePressed(), root.platformInverted)
        anchors.fill: parent
        opacity: 0

        border {
            left: platformStyle.borderSizeMedium
            top: platformStyle.borderSizeMedium
            right: platformStyle.borderSizeMedium
            bottom: platformStyle.borderSizeMedium
        }
    }

   /* Text {
        id: label

        objectName: "label"
        // hide in landscape if icon is present
        visible: !(iconSource.toString() && !internal.portrait)
        anchors {
            left: parent.left
            right: parent.right
            bottom: parent.bottom
            leftMargin: platformStyle.paddingMedium
            rightMargin: platformStyle.paddingMedium
            bottomMargin: iconSource.toString()
                ? platformStyle.paddingSmall
                : Math.ceil((parent.height - label.height) / 2.0)
        }
        elide: Text.ElideRight
        horizontalAlignment: Text.AlignHCenter
        font {
            family: platformStyle.fontFamilyRegular;
            pixelSize: platformStyle.fontSizeSmall
            weight: Font.Light
        }
        color: {
            if (root.pressed)
                root.platformInverted ? platformStyle.colorPressedInverted
                                      : platformStyle.colorPressed
            else if (root.checked)
                root.platformInverted ? platformStyle.colorNormalLightInverted
                                      : platformStyle.colorNormalLight
            else
                root.platformInverted ? platformStyle.colorNormalMidInverted
                                      : platformStyle.colorNormalMid
        }
    }*/

    Loader {
        // imageLoader acts as wrapper for Image and Icon items. The Image item is
        // shown when the source points to a image (jpg, png). Icon item is used for
        // locigal theme icons which are colorised.
        id: imageLoader

       // property url source
        //property string iconId: privateStyle.isTabBarIcon(source) ? source.toString() : ""

        width : platformStyle.graphicSizeSmall
        height : platformStyle.graphicSizeSmall

        anchors {
            top: parent.top
            topMargin :Math.floor((parent.height - imageLoader.height) / 2.0)

            horizontalCenter: parent.horizontalCenter
        }


            Image {
                id: image
                opacity: checked? 1:0.5
                width: sourceSize.width
                height: sourceSize.height
                objectName: "image"
                source: iconSource
                sourceSize.width:  internal.portrait ?largeQAButtons?45:30 : largeQAButtons?42:30
                sourceSize.height: internal.portrait ?largeQAButtons?45:30 : largeQAButtons?42:30
                //fillMode: Image.PreserveAspectFit
                smooth: true
                anchors.centerIn: parent
            }


   /* Component {
            id: iconComponent

            Icon {
                id: icon

                objectName: "icon"
                anchors.fill: parent
                iconColor: label.color
                iconName: imageLoader.iconId
            }
        }*/
    }

    MouseArea {
        id: mouseArea

        onPressed: stateGroup.state = "Pressed"
        onReleased: stateGroup.state = ""
        onCanceled: {
            // Mark as canceled
            stateGroup.state = "Canceled"
            // Reset state
            stateGroup.state = ""
        }
        onExited: {
            if (pressed)
                stateGroup.state = "Canceled"
        }

        anchors.fill: parent
    }
}
