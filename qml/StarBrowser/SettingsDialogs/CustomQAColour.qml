/**
Copyright (C) 2020 Allstar Software (Paul Wallace)
*/
import QtQuick 1.1
import com.nokia.symbian 1.1
import "../"
CommonDialoger{
    height: screen.height-50
    id: root
    property string bob:""
    Component.onCompleted: {open()}
property bool __isClosing: false
    onStatusChanged: {if (status === DialogStatus.Closing) __isClosing = true ; else if (status === DialogStatus.Closed && __isClosing) root.destroy()}
    titleText: "Custom QA Colour"
    buttonTexts: ["Save"]
    privateCloseIcon: true
    onButtonClicked:{
        appsettings.saveSystemSetting ("newfloatingsource", bob);
        appsettings.saveSystemSetting ("colourtitleqa", "Custom");
        appsettings.saveSystemSetting("switchsource", "img/Switch/qtg_graf_switchbutton_fill_default.svg");
        switchSource= "img/Switch/qtg_graf_switchbutton_fill_default.svg" ;
        butcol.title= "QA Colour: Custom";
        popupbutton.colour= bob;
    }

    QtObject {
        id: internal
        property bool portrait: screen.currentOrientation == Screen.Portrait || screen.currentOrientation == Screen.PortraitInverted

    }
    content:[

    Rectangle{
    id: rect
    visible: internal.portrait ?true:false
    Behavior on color {ColorAnimation {}}
    width: parent.width-20
    height: 150
    anchors{top:parent.top;topMargin: 10; horizontalCenter: parent.horizontalCenter}
    color:"white"
},

    TextField{
        id: colourInput
        anchors.bottom: parent.bottom
        width: parent.width
        inputMethodHints: Qt.ImhNoAutoUppercase| Qt.ImhNoPredictiveText
        placeholderText: "Enter Colour Code Here, HTML ONLY!"
        onTextChanged: {bob=colourInput.text; rect.color=bob}
    }]



}
