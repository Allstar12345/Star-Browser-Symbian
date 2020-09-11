/**
Copyright (C) 2020 Allstar Software (Paul Wallace)
*/
import QtQuick 1.1
import Qt.labs.components 1.1

Item {
    id: root
    height: 10
    // Common Public API
    property alias minimumValue: model.minimumValue
    property alias maximumValue: model.maximumValue
    property alias value: model.value

    implicitWidth: Math.max(50, screen.width / 2) // TODO: use screen.displayWidth
    Loader {
        id: progressBarContent
        LayoutMirroring.enabled: false
        LayoutMirroring.childrenInherit: true

        states: [
            State {
                name: "determinate"
                when: !root.indeterminate
                PropertyChanges { target: progressBarContent; sourceComponent: determinateContent }
                AnchorChanges {
                    target: progressBarContent
                    anchors.top: parent.top
                    anchors.bottom: parent.bottom
                    anchors.left: parent.left
                }
            }
        ]
    }
    Component {
        id: determinateContent
        Item {
            id: progressMask
            width: model.position
            clip: true

            Rectangle {
                id: progress
                color: progressColour
                smooth: true
                height: parent.height
                width: root.width
            }
        }
    }

    RangeModel {
        id: model
        minimumValue: 0.0
        maximumValue: 1.0
        positionAtMinimum: 0.0
        positionAtMaximum: root.width
    }
}
