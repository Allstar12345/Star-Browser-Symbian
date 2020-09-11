/**
Copyright (C) 2020 Allstar Software (Paul Wallace)
*/
import QtQuick 1.1
import "." 1.1
import com.nokia.symbian 1.1

Item {
    id: root

    property alias content: contentArea.children

    signal itemClicked()

    height: flickableArea.height

    QtObject {
        id: internal
       property int clipMargin: platformStyle.paddingSmall
        property int preferredHeight: privateStyle.menuItemHeight * ((screen.width < screen.height) ? 7 : 5)
    }

    BorderImage {
        source: "img/qtg_fr_popup_black.svg"
        border { left: 20; top: 20; right: 20; bottom: 20 }
        anchors.fill: parent
    }

    Item {
        id: clipItem
        y: internal.clipMargin
        height: flickableArea.height - 2 * internal.clipMargin
        width: root.width
        clip: true
        Flickable {
            id: flickableArea

            property int index: 0
            property bool itemAvailable: (contentArea.children[0] != undefined) && (contentArea.children[0].children[0] != undefined)
            property int itemHeight: itemAvailable ? Math.max(1, contentArea.children[0].children[0].height) : 1
            property int itemsHidden: Math.floor(contentY / itemHeight)
            property int interactionMode: symbian.listInteractionMode

            y: -internal.clipMargin
            height: contentArea.height; width: root.width
            clip: true
            contentHeight: (contentArea.children[0] != undefined) ? contentArea.children[0].height : 0
            contentWidth: width

            Item {
                id: contentArea

                width: flickableArea.width
                height: flickableArea.contentHeight > internal.preferredHeight
                    ? internal.preferredHeight - (internal.preferredHeight % flickableArea.itemHeight)
                    : flickableArea.contentHeight

                function setChildrenWidths() {
                    for (var i = 0; i < children.length; ++i)
                        children[i].width = width
                }

                function connectChildren() {
                    for (var i = 0; i < children.length; ++i) {
                        if (children[i].clicked != undefined)
                            children[i].clicked.connect(root.itemClicked)
                    }
                }

                onWidthChanged: setChildrenWidths()
                onChildrenChanged: {
                    setChildrenWidths()
                    connectChildren()
                }
            }

            onVisibleChanged: {
                enabled = visible
                if (itemAvailable)
                    contentArea.children[0].children[0].focus = visible
                contentY = 0
                index = 0
            }


            onInteractionModeChanged: {
                if (symbian.listInteractionMode == Symbian.KeyNavigation) {
                    contentY = 0
                    scrollBar.flash(Symbian.FadeOut)
                    if (itemAvailable)
                        contentArea.children[0].children[index].focus = true
                } else if (symbian.listInteractionMode == Symbian.TouchInteraction) {
                    index = 0
                }
            }

            Keys.onPressed: {
                if (itemAvailable && (event.key == Qt.Key_Down || event.key == Qt.Key_Up)) {
                    if (event.key == Qt.Key_Down && index < contentArea.children[0].children.length - 1) {
                        index++
                        if (index * itemHeight > contentY + height - itemHeight) {
                            contentY = index * itemHeight - height + itemHeight
                        }
                    } else if (event.key == Qt.Key_Up && index > 0) {
                        index--
                        if (index * itemHeight < contentY) {
                            contentY = index * itemHeight
                        }
                    }
                    scrollBar.flash(Symbian.FadeOut)
                    contentArea.children[0].children[index].focus = true
                    event.accepted = true
                }
            }
        }
    }

    ScrollBar {
        id: scrollBar
        objectName: "scrollBar"
        flickableItem: flickableArea
        interactive: false
        visible: flickableArea.height < flickableArea.contentHeight
        anchors {
            top: clipItem.top
            bottom: clipItem.bottom
            right: clipItem.right
        }
    }

}
