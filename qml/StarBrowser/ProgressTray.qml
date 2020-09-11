/**
Copyright (C) 2020 Allstar Software (Paul Wallace)
*/
import QtQuick 1.1
    ProgressBaredit{
        function close(){progressdissapear.start()}
        function open(){progressappear.start()}
            PropertyAnimation{
                id: progressappear
                targets: [progressbar]
                property: "anchors.topMargin"
                to: 0
            }
            PropertyAnimation{
                id: progressdissapear
                targets: [progressbar]
                property: "anchors.topMargin"
                to: -20
            }
     id: progressbar
     property alias progressValue: progressbar.value
     anchors{top:parent.top; topMargin: -20; right: parent.right;left: parent.left}
     maximumValue: 1.0
     visible: true
     minimumValue: 0.0
     z:1
    }

