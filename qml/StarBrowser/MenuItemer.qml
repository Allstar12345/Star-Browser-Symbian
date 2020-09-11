/**
Copyright (C) 2020 Allstar Software (Paul Wallace)
*/
import QtQuick 1.1
import "." 1.1
import com.nokia.symbian 1.1

Item {
    id: root

    property alias text: textArea.text

    // Symbian specific API
    property bool platformInverted: false
    property bool platformSubItemIndicator: false
    property real platformLeftMargin: platformStyle.paddingLarge

    signal clicked

    width: parent.width; height: privateStyle.menuItemHeight

    QtObject {
        id: internal

        function bg_postfix() {
            if (activeFocus && symbian.listInteractionMode == Symbian.KeyNavigation)
                return "highlighted"
            else if (mouseArea.pressed && mouseArea.containsMouse && !mouseArea.canceled)
                return "pressed"
            else
                return "popup_normal"
        }

        function textColor() {
            if (!enabled)
                return root.platformInverted ? platformStyle.colorDisabledLightInverted
                                             : platformStyle.colorDisabledLight
            else if (activeFocus && symbian.listInteractionMode == Symbian.KeyNavigation)
                return root.platformInverted ? platformStyle.colorHighlightedInverted
                                             : platformStyle.colorHighlighted
            else if (mouseArea.pressed && mouseArea.containsMouse)
                return root.platformInverted ? platformStyle.colorPressedInverted
                                             : platformStyle.colorPressed
            else
                return root.platformInverted ? platformStyle.colorNormalLightInverted
                                             : platformStyle.colorNormalLight
        }
    }

    BorderImage {
        source: privateStyle.imagePath("qtg_fr_list_" + internal.bg_postfix(), root.platformInverted)
        border { left: 20; top: 20; right: 20; bottom: 20 }
        anchors.fill: parent
    }

    Text {
        id: textArea
        anchors {
            verticalCenter: parent.verticalCenter
            left: parent.left
            leftMargin: platformLeftMargin
            right: iconLoader.status == Loader.Ready ? iconLoader.left : parent.right
            rightMargin: iconLoader.status == Loader.Ready ? platformStyle.paddingMedium : privateStyle.scrollBarThickness
        }
        font { family: platformStyle.fontFamilyRegular; pointSize: largeQAButtons? 10:8 }
        color: internal.textColor()
        horizontalAlignment: Text.AlignLeft
        elide: Text.ElideRight
    }

    Loader {
        id: iconLoader
        sourceComponent: root.platformSubItemIndicator ? subItemIcon : undefined
        anchors {
            right: parent.right
            rightMargin: privateStyle.scrollBarThickness
            verticalCenter: parent.verticalCenter
        }
    }

    Component {
        id: subItemIcon

        Image {
            source: privateStyle.imagePath("qtg_graf_drill_down_indicator", platformInverted)
            sourceSize.width: platformStyle.graphicSizeSmall
            sourceSize.height: platformStyle.graphicSizeSmall
            mirror: LayoutMirroring.enabled
        }
    }


    MouseArea {
        id: mouseArea

        property bool canceled: false

        anchors.fill: parent

        onPressed: {
            canceled = false
            symbian.listInteractionMode = Symbian.TouchInteraction
            privateStyle.play(Symbian.BasicItem)
        }
        onClicked: {
            if (!canceled)
                root.clicked()
        }
        onReleased: {
            if (!canceled)
                privateStyle.play(Symbian.PopupClose)
        }
        onExited: canceled = true
    }

    Keys.onPressed: {
        event.accepted = true
        switch (event.key) {
            case Qt.Key_Select:
            case Qt.Key_Enter:
            case Qt.Key_Return: {
                if (!event.isAutoRepeat) {
                    if (symbian.listInteractionMode != Symbian.KeyNavigation)
                        symbian.listInteractionMode = Symbian.KeyNavigation
                    else
                        root.clicked()
                }
                break
            }

            case Qt.Key_Up: {
                if (symbian.listInteractionMode != Symbian.KeyNavigation) {
                    symbian.listInteractionMode = Symbian.KeyNavigation
                    if (ListView.view != null)
                        ListView.view.positionViewAtIndex(index, ListView.Beginning)
                } else {
                    if (ListView.view != null)
                        ListView.view.decrementCurrentIndex()
                    else
                        event.accepted = false
                }
                break
            }

            case Qt.Key_Down: {
                if (symbian.listInteractionMode != Symbian.KeyNavigation) {
                    symbian.listInteractionMode = Symbian.KeyNavigation
                    if (ListView.view != null)
                        ListView.view.positionViewAtIndex(index, ListView.Beginning)
                } else {
                    if (ListView.view != null)
                        ListView.view.incrementCurrentIndex()
                    else
                        event.accepted = false
                }
                break
            }
            case Qt.Key_Left:
            case Qt.Key_Right: {
                // If this MenuItem belongs to Menu invoke highlight
                // in other cases consume event but do nothing
                if (ListView.view == null && symbian.listInteractionMode != Symbian.KeyNavigation)
                    symbian.listInteractionMode = Symbian.KeyNavigation
                break
            }
            default: {
                event.accepted = false
                break
            }
        }
    }
}
