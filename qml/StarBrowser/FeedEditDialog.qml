/**
Copyright (C) 2020 Allstar Software (Paul Wallace)
*/
import QtQuick 1.1
import com.nokia.symbian 1.1
import "feeds.js" as Feeds

CommonDialoger{
    Component.onCompleted: {
        open()}
    buttonTexts: ["Save Changes"]
    titleText: "Add Feed"
    height: 195
    privateCloseIcon: true
    onButtonClicked:{
        var itemnew = Feeds.defaultItem();
                    itemnew.title = title.text;
                    itemnew.url = url.text;
                    itemnew.creationdate = Qt.formatDateTime(new Date(), "dd/MM/yy");
                    Feeds.createFeed(itemnew);
                    updateList();
    }
    content: Item {
        anchors.fill: parent
       TextField{
        id: title
        placeholderText: "Title"
        anchors{right: parent.right;left: parent.left;top:parent.top}
    }
    TextField{
        placeholderText: "URL"
        anchors{right: parent.right;left: parent.left;top:title.bottom}
        id: url
}
    }
}
