/**
Copyright (C) 2020 Allstar Software (Paul Wallace)
*/
import QtQuick 1.1
import "." 1.1
import com.nokia.symbian 1.1
Item {
id: root
// Common Public API
property bool checked: false
property bool pressed: stateGroup.state == "Pressed" || stateGroup.state == "KeyPressed"
|| stateGroup.state == "Dragging"
// Symbian specific API
property bool platformInverted: false
signal clicked
QtObject {
id: internal
objectName: "internal"
function toggle() {
root.checked = !root.checked
root.clicked()
}
}
StateGroup {
id: stateGroup
states: [
State { name: "Pressed" },
State { name: "Released" },
State { name: "KeyPressed" },
State { name: "Dragging" },
State { name: "Canceled" }
]
transitions: [
Transition {
to: "Pressed"
ScriptAction { script: privateStyle.play(Symbian.BasicItem) }
},
Transition {
from: "Released, Dragging"
to: ""
ScriptAction { script: privateStyle.play(Symbian.CheckBox) }
ScriptAction { script: internal.toggle() }
},
Transition {
from: "KeyPressed"
to: ""
ScriptAction { script: internal.toggle() }
}
]
}
implicitWidth: track.width
implicitHeight: privateStyle.switchButtonHeight
Image {
id: track
function trackPostfix() {
if (!root.enabled && root.checked)
return "img/Switch/qtg_graf_switchbutton_disabled_on.svg"
else if (!root.enabled && !root.checked)
return "img/Switch/qtg_graf_switchbutton_disabled_off.svg"
else
return "img/Switch/qtg_graf_switchbutton_track.svg"
}
source: track.trackPostfix()
anchors.left: parent.left
anchors.verticalCenter: parent.verticalCenter
sourceSize {
width: Math.round(privateStyle.switchButtonHeight * 3/2)
height: privateStyle.switchButtonHeight
}
scale: root.LayoutMirroring.enabled ? -1 : 1
}
MouseArea {
id: mouseArea
property real lastX
function isChecked() {
if (root.LayoutMirroring.enabled)
return (handle.x + handle.width / 2 < track.x + (track.width / 2))
else
return (handle.x + handle.width / 2 > track.x + (track.width / 2))
}
function updateHandlePos() {
// The middle of the handle follows mouse, the handle is bound to the track
handle.x = Math.max(track.x, Math.min(mouseArea.lastX - handle.width / 2,
track.x + track.width - handle.width))
//factoring the handle position on the track to a sensible opacity value
if (root.LayoutMirroring.enabled)
fill.opacity = 1 - (3 * handle.x/track.width)
else
fill.opacity = 3 * handle.x/track.width
}
anchors.fill: track
onPressed: stateGroup.state = "Pressed"
onReleased: stateGroup.state = "Released" // releasing doesn't toggle yet, it is intermediate state
onClicked: stateGroup.state = ""
onCanceled: stateGroup.state = "Canceled"
onPositionChanged: {
mouseArea.lastX = mouse.x
if (mouseArea.drag.active)
updateHandlePos()
}
drag {
// The handle is moved manually but MouseArea can be used to decide when dragging
// should start (QApplication::startDragDistance). A dummy target needs to be bound or
// dragging won't get activated.
target: Item { visible: false }
axis: Drag.XandYAxis
minimumY: 0; maximumY: 0 // keep dragging active eventhough only x axis switches
minimumX: track.x; maximumX: mouseArea.drag.minimumX + track.width - handle.width
onActiveChanged: {
if (mouseArea.drag.active) {
updateHandlePos()
stateGroup.state = "Dragging"
}
else {
stateGroup.state = (root.checked != isChecked()) ? "" : "Canceled"
}
}
}
}
Image {
id: fill
anchors.centerIn: parent
//fill source
source: switchSource
sourceSize {
width: Math.round(privateStyle.switchButtonHeight * 3/2)
height: privateStyle.switchButtonHeight
}
visible: root.enabled
opacity: 0
states: [
State {
name: "Off"
when: !mouseArea.drag.active && !checked
PropertyChanges { target: fill; opacity: 0 }
},
State {
name: "on"
when: !mouseArea.drag.active && checked
PropertyChanges { target: fill; opacity: 1 }
}
]
Behavior on opacity { PropertyAnimation { duration: 200 } }
}
Image {
id: handle
source: (root.pressed ? "img/Switch/qtg_graf_switchbutton_handle_pressed.svg" : "img/Switch/qtg_graf_switchbutton_handle_normal.svg")
anchors.verticalCenter: root.verticalCenter
sourceSize {
width: privateStyle.switchButtonHeight
height: privateStyle.switchButtonHeight
}
visible: root.enabled
states: [
State {
name: "Off"
when: !mouseArea.drag.active && !checked
PropertyChanges {
target: handle
restoreEntryValues: false
x: root.LayoutMirroring.enabled ? mouseArea.drag.maximumX : mouseArea.drag.minimumX
}
},
State {
name: "On"
when: !mouseArea.drag.active && checked
PropertyChanges {
target: handle
restoreEntryValues: false
x: root.LayoutMirroring.enabled ? mouseArea.drag.minimumX : mouseArea.drag.maximumX
}
}
]
transitions: [
Transition {
to: "Off"
SmoothedAnimation { properties: "x"; easing.type: Easing.InOutQuad; duration: 200 }
},
Transition {
to: "On"
SmoothedAnimation { properties: "x"; easing.type: Easing.InOutQuad; duration: 200 }
}
]
}
Keys.onPressed: {
if (!event.isAutoRepeat && (event.key == Qt.Key_Select
|| event.key == Qt.Key_Return
|| event.key == Qt.Key_Enter)) {
stateGroup.state = "KeyPressed"
event.accepted = true
}
}
Keys.onReleased: {
if (!event.isAutoRepeat && (event.key == Qt.Key_Select
|| event.key == Qt.Key_Return
|| event.key == Qt.Key_Enter)) {
stateGroup.state = ""
event.accepted = true
}
}
}
