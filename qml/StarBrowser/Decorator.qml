/**
Copyright (C) 2020 Allstar Software (Paul Wallace)
*/
import QtQuick 1.1
import "." 1.1
import com.nokia.symbian 1.1

Item {
    id: root

    //Common Public API
    property bool lightColours: false
    property Flickable flickableItem: null


    Item {
        id: decorators
        property bool completed: false

        Loader {
            sourceComponent: decorators.completed ? vertical : undefined
        }
        Loader {
            sourceComponent: decorators.completed ? horizontal : undefined
        }
        Component {
            id: horizontal
            ScrollBarer {
                lightColour: lightColours
                parent: flickableItem
                flickableItem: root.flickableItem
                orientation: Qt.Horizontal
                interactive: true
                height: largeQAButtons?25: 20
                smooth: true
                anchors {
                    left: flickableItem.left
                    bottom: flickableItem.bottom
                    rightMargin: height
                }
            }
        }
        Component {
            id: vertical
            ScrollBarer {
                lightColour: lightColours
                id: scrollvertical
                parent: flickableItem
                flickableItem: root.flickableItem
                orientation: Qt.Vertical
                interactive: true
                width: largeQAButtons?25: 20
                smooth: true
                anchors { top: flickableItem.top; right: flickableItem.right }
            }
        }
        Component.onDestruction: {
            decorators.completed = false
        }
    }
    onFlickableItemChanged: {
        decorators.completed = flickableItem ? true : false
    }
}
