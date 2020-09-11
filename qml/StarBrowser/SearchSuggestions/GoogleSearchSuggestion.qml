/**
Copyright (C) 2020 Allstar Software (Paul Wallace)
*/

import QtQuick 1.1
import com.nokia.symbian 1.1

Rectangle {
    id: googleSuggest
    property string textToSugget
    property string dsParam
    property bool timeToDie: false
    property int rowHeight: 40
    signal itemChoosen(string suggestion);
    width: if(nE6===true){480} else if (screen.width===360){360} else {640}
    height: rowHeight*listView.count+listView.count-1
    anchors.top: parent.bottom
    anchors.topMargin: 1
    color: "gray"
    border.color: "gray"
    border.width: 1
    onTimeToDieChanged: googleSuggest.destroy();

    XmlListModel {
        id: xmlModel
        source: "http://suggestqueries.google.com/complete/search?output=toolbar"+
                (dsParam!=="" ? "&ds="+dsParam : "") +
                "&q="+textToSugget

        query: "/toplevel/CompleteSuggestion"
        XmlRole { name: "suggestion";  query: "suggestion/@data/string()" }
        XmlRole { name: "num_queries"; query: "num_queries/@int/string()" }
    }

    ListView {
        id: listView
        anchors.fill: parent
        cacheBuffer: 10
        highlight: Rectangle { color: popupbutton.color; z: listView.z+10 }
        highlightFollowsCurrentItem: true
        currentIndex: -1
        model: xmlModel
        spacing: 1
        interactive: false

        delegate: Rectangle {
            anchors.horizontalCenter: parent.horizontalCenter
            id: resultRow
            color: "white"
            width: parent.width
            height: rowHeight
            Text {
                anchors.left: parent.left
                anchors.leftMargin: 8
                anchors.top: parent.top
                anchors.topMargin: 6
                id: result
                text: suggestion
                font.pointSize: largeQAButtons?9:7
                font.bold: true;
                color: "black"
            }
        }

        MouseArea {
            anchors.fill: listView
            onMouseYChanged: {listView.currentIndex = Math.floor((mouseY+rowHeight) / rowHeight) - 1;}
            onReleased: {
                if(listView.currentIndex != -1)
                googleSuggest.itemChoosen(xmlModel.get(listView.currentIndex).suggestion)

            }
        }
    }
}
