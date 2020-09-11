/**
Copyright (C) 2020 Allstar Software (Paul Wallace)
*/
import QtQuick 1.1
import com.nokia.symbian 1.1

AppPage {
    Component.onCompleted: {show(); welcomeimage.opacity= 1.0; welcometext.opacity=1.0;welcometext2.opacity=1.0;webViewHidden=true; textslide.start();imageslide.start();tabanim1.start();toolbar.appear();}
    property string switchSource: appsettings.getSystemSetting("switchsource", "") ? appsettings.getSystemSetting("switchsource", ""): "img/Switch/qtg_graf_switchbutton_fill.svg";
    PropertyAnimation{id: tabanim1; duration:470; target: tab1; to:1; property: "opacity";onCompleted:{tabanim2.start();}}
    PropertyAnimation{id: tabanim2; duration:470; target: tab2; to:1; property: "opacity";onCompleted:{tabanim3.start();}}
    PropertyAnimation{id: tabanim3; duration:470; target: tab3; to:1; property: "opacity";onCompleted:{tabanim4.start();}}
    PropertyAnimation{id: tabanim4; duration:470;target: tab4; to:1; property: "opacity"}
    Component.onDestruction: {
        console.debug ("Settings Destroyed")
    }
    QtObject { id: create; property Component com: null;function createComponent (qmlfile){com = Qt.createComponent(qmlfile);com.createObject(settingsbrowsingpage)} }

colour: "black"
z: Infinity
    id: settingsbrowsingpage


    function openCustomColour(){create.createComponent(Qt.resolvedUrl("SettingsDialogs/CustomQAColour.qml"));}
    function openPassChange(){create.createComponent(Qt.resolvedUrl("SecurityComponents/ChangePasswordDialog.qml"));}
    function openAdvancedSettings(){create.createComponent(Qt.resolvedUrl("SettingsAdvanced.qml"));}
    function openPrivacy(){create.createComponent(Qt.resolvedUrl("PrivacySettings.qml"));}
    function opentbuttoncolour(){create.createComponent(Qt.resolvedUrl("SettingsDialogs/ToolButtonSenseColour.qml")); }
    function openfontsize(){create.createComponent(Qt.resolvedUrl("SettingsDialogs/FontSizeDialog.qml"));}
    function openaboutpage(){create.createComponent(Qt.resolvedUrl("About.qml"));}
    function setrestart(){create.createComponent(Qt.resolvedUrl("SettingsDialogs/SettingRestartPopup.qml"));}
    function openglobalgoogle(){create.createComponent(Qt.resolvedUrl("SettingsDialogs/GlobalGoogleSearch.qml"));}
    function opencolourchange(){ create.createComponent(Qt.resolvedUrl("SettingsDialogs/ColourChangePopup.qml"));}
    function openprogress(){ create.createComponent(Qt.resolvedUrl("SettingsDialogs/ProgressBar.qml"));}
    function opentoolbarcolour(){create.createComponent(Qt.resolvedUrl("SettingsDialogs/ToolBarColour.qml"));}
    function openbuttonscolour(){ create.createComponent(Qt.resolvedUrl("SettingsDialogs/ButtonsColour.qml"));}
    function openenginechooser(){create.createComponent(Qt.resolvedUrl("SettingsDialogs/SearchEngineChooser.qml"));}
    function opencookies(){create.createComponent(Qt.resolvedUrl("SettingsDialogs/ClearCookies.qml")); }
    function openreset(){create.createComponent(Qt.resolvedUrl("SettingsDialogs/ResetAll.qml"));}
    function openhomepageChooser(){create.createComponent(Qt.resolvedUrl("SettingsDialogs/HomePageChooser.qml"));}
    function openhomepage(){create.createComponent(Qt.resolvedUrl("SettingsDialogs/Homepage.qml"));}
    function openbanner(){ create.createComponent(Qt.resolvedUrl("SettingsDialogs/BannerColour.qml"));}
    function openccoc(){create.createComponent(Qt.resolvedUrl("SettingsDialogs/CookiesAtClose.qml"));}
    function openabout(){
        tab1.enabled=true;
        tab2.enabled=true;
        tab3.enabled=true;
        openaboutpage();
        killOpeningImg();
        showsetdelay.start();
    }
    Timer{id: showsetdelay; interval: 300; onTriggered:{showsettings();}}
    function opentips(){create.createComponent(Qt.resolvedUrl("Help.qml"));}
    function openSecurityMain(){
        tab1.enabled=true
        tab2.enabled=true
        tab3.enabled=true
        tab4.enabled=true
        create.createComponent(Qt.resolvedUrl("SecurityComponents/OtherUserArea.qml"));
        killOpeningImg()
       showsetdelay.start();
    }

   function opensecurity(){
        tab1.enabled=true
        tab2.enabled=true
        tab3.enabled=true
        tab4.enabled=true
        if (appsettings.getSystemSetting("ap", "")=== ""){openNewPassword()}
        else{create.createComponent(Qt.resolvedUrl("SecurityComponents/PasswordEnter.qml"));}
       killOpeningImg()
      showsetdelay.start();
   }

    function openNewPassword(){create.createComponent(Qt.resolvedUrl("SecurityComponents/CreateNewCredentials.qml"));}
    function openforgotpassword(){ create.createComponent(Qt.resolvedUrl("SecurityComponents/ForgotPasswordArea.qml"));}
        function autoreloadduration(){create.createComponent(Qt.resolvedUrl("SettingsDialogs/AutoReloadDuration.qml")); }
    function showsettings(){
        tab1.enabled=false
        tab2.enabled=true
        tab3.enabled=true
        tab4.enabled=true
        flickablesettings.opacity=1
        flickablecustom.opacity= 0
        tab1.checked=true
        tab2.checked=false
        killOpeningImg();
        welcometext.opacity=0
        welcometext2.opacity=0
        welcomeimage.opacity=0
    }
    function showcustom(){
        tab1.enabled=true
        tab2.enabled=false
        tab3.enabled=true
        tab4.enabled=true
        tab2.checked=true
        tab1.checked=false
        flickablesettings.opacity=0
        flickablecustom.opacity= 1
        welcometext.opacity=0
        welcometext2.opacity=0
        welcomeimage.opacity=0
        killOpeningImg();
    }
    function killOpeningImg(){welcometext.destroy(); welcometext2.destroy(); welcomeimage.destroy();}
TopToolBar{
    id: toolbar
            ToolButtonSense {
                id: btnBack
                imgsource: "img/back_flat.svg"
                onClicked: {
                    webViewHidden=false;
                    close();
             }
          }

            ButtonSense{anchors.centerIn:parent;
                buttonText: "Donate";
                onClicked:{QMLUtils.openBrowser("https://www.paypal.com/cgi-bin/webscr?cmd=_s-xclick&hosted_button_id=PZZP6QDKVSN9A")}
            }
            ToolButtonSense{
                id: btnTips
                anchors{right:parent.right; rightMargin:5;verticalCenter: parent.verticalCenter}
                imgsource:"img/help.svg"
                onClicked:{opentips();}
            }
            }
    Text{
        color: "grey"
        anchors.centerIn: parent
        text: "Settings"
        font.pointSize: 11
        id: welcometext
        anchors.verticalCenterOffset: -110
        anchors.horizontalCenterOffset: 640
        opacity: 0
        Behavior on opacity{NumberAnimation{duration: 100}}
    }
    Text{
        color: "grey"
        anchors.centerIn: parent
        text: "Press A Tab To Begin"
        font.pointSize: 11
        id: welcometext2
        anchors.verticalCenterOffset: screen.height===480? -70: -74
        anchors.horizontalCenterOffset: 640
        opacity: 0
        Behavior on opacity{NumberAnimation{duration: 100}}
    }
    Image{
        opacity: 0.5
        smooth: true
        id: welcomeimage
        height: sourceSize.height
        width: sourceSize.width
        sourceSize.height: 170
        sourceSize.width: 170
        source: "img/settings_flat.svg"
        Behavior on opacity {NumberAnimation{}}
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.horizontalCenterOffset: -800
        anchors.top: welcometext.bottom
        anchors.topMargin: 40
        RotationAnimation{
            target: welcomeimage
            to: 360
            id: rotation
            running: false
            direction: RotationAnimation.Clockwise
            loops: Animation.Infinite
            property: "rotation"
            from: 0
            duration: 20000
        }
    }
    SmoothedAnimation{id: imageslide; property: "anchors.horizontalCenterOffset"; target: welcomeimage; to:0; duration: 1000; onCompleted: {rotation.start()}}
    SmoothedAnimation{id: textslide; property: "anchors.horizontalCenterOffset"; targets: [welcometext, welcometext2]; to:0; duration: 1000}
    Rectangle{
    id: toptabbar; anchors.bottom: parent.bottom; z: 2; opacity: 1
    anchors.left: parent.left
    anchors.right: parent.right
    color: if (appsettings.getSystemSetting("toolbarcolour", "")=== ""){"#0f0f0a"}else{appsettings.getSystemSetting("toolbarcolour", "")}
    implicitWidth: Math.max(50, screen.width)
    implicitHeight: (screen.width < screen.height)? privateStyle.toolBarHeightPortrait: privateStyle.toolBarHeightLandscape
    Row{
        anchors.fill: parent
        TabButtoner{id: tab1; opacity:0; anchors{top: parent.top;bottom: parent.bottom}width: if(screen.height===640){90}else if (screen.height=== 360){160}else if (screen.height=== 480) 160; iconSource: "img/settings_flat.svg"; onClicked: {showsettings(); tab1.checked=true ;tab2.checked=false;tab3.checked=false; tab4.checked=false}}
        TabButtoner{id: tab2; opacity:0;anchors{top: parent.top;bottom: parent.bottom}width: if(screen.height===640){90}else if (screen.height=== 360){160}else if (screen.height=== 480) 160; iconSource: "img/personalise_flat.svg"; onClicked:{showcustom(); tab1.checked=false ;tab2.checked=true;tab3.checked=false; tab4.checked=false}}
        TabButtoner{id: tab3; opacity:0;anchors{top: parent.top;bottom: parent.bottom}width: if(screen.height===640){90}else if (screen.height=== 360){160}else if (screen.height=== 480) 160; iconSource: "img/lock_flat.svg"; onClicked: {opensecurity(); tab1.checked=true ;tab2.checked=false;tab3.checked=false; tab4.checked=false}}
        TabButtoner{id: tab4; opacity:0; anchors{top: parent.top;bottom: parent.bottom} width: if(screen.height===640){90}else if (screen.height=== 360){160} else if (screen.height=== 480) 160; iconSource: "img/information_userguide_flat.svg"; onClicked: {openabout(); tab1.checked=true;tab2.checked=false;tab3.checked=false; tab4.checked=false}}
        }
    }

    Flickable {
        z: 1
        Behavior on opacity {NumberAnimation{}}
        id: flickablesettings
        opacity: 0
        anchors.bottom: toptabbar.top
        anchors.right: parent.right
        anchors.left: parent.left
        anchors.top: toolbar.bottom
        contentHeight: columnsett.height
          Decorator{flickableItem: flickablesettings; lightColours: true}
        contentWidth: columnsett.width

    Column {
        id: columnsett
       spacing: 1
       ListItemer {
            id: pinch
            enabled: false
            height: screen.height===480? 62: 51
            ListItemText {
                role: "Title"
                text: "Pinch To Zoom"
                anchors.fill: pinch.paddingItem
            }
            Switcher{
                 anchors.right: parent.right
               anchors.rightMargin: 1
                anchors.verticalCenter: parent.verticalCenter
                checked: set_pinch
                onClicked: {
                   set_pinch = checked;
                  appsettings.saveSystemSetting("pinchenabled",checked)
                }
            }
       }
       ListItemer {
            id: images
            enabled: false
            height:  screen.height===480? 62: 51
            ListItemText {
                role: "Title"
                text: "Show Images"
                anchors.fill: images.paddingItem
            }
            Switcher{
                 anchors.right: parent.right
               anchors.rightMargin: 1
                anchors.verticalCenter: parent.verticalCenter
                checked: set_img
                onClicked: {
                    if(set_img===true){set_img=false; appsettings.getSystemSetting("images", "d") }
                    else{set_img=true; appsettings.getSystemSetting("images", "") }
                }
            }
       }
       ListItemer {
            id: js
            enabled: false
            height:  screen.height===480? 62: 51

            ListItemText {
                role: "Title"
                text: "Use Javascript"
                anchors.fill: js.paddingItem
            }

            Switcher{
                 anchors.right: parent.right
               anchors.rightMargin: 1
                anchors.verticalCenter: parent.verticalCenter
                checked: set_js
                onClicked: {
                    if(set_js===true){set_js=false; appsettings.getSystemSetting("javaScript", "d") }
                    else{set_js=true; appsettings.getSystemSetting("javaScript", "") }
                }
            }
       }
       ListItemer {
            id: privacysettingslist
            enabled: true
            height: 51
            subItemIndicator: true
            onClicked: {
                if (sensitiveMode=== true){
                    banner.showText ("Access Denied, Restricted Mode Activated")
                }
                else{
                    openPrivacy();
                }
            }
            ListItemText {
                role: "Title"
                text: "Privacy Settings"
                anchors.fill: privacysettingslist.paddingItem
            }
              }
       ListItemer {
            id: adsetlist
            enabled: true
            height: 51
            subItemIndicator: true
            onClicked: {
                if (sensitiveMode=== true){
                    banner.showText ("Access Denied, Restricted Mode Activated")
                }
                else{
                     openAdvancedSettings();
                }

            }
            ListItemText {
                role: "Title"
                text: "Advanced Settings"
                anchors.fill: adsetlist.paddingItem
            }
              }
       ListItemer {
            id: homelist
            enabled: true
            subItemIndicator: true
            onClicked: {
                if (sensitiveMode=== true){
                    banner.showText ("Access Denied, Restricted Mode Activated")
                }
                else{
                    openhomepageChooser()
                }
            }
            Column { anchors.fill: homelist.paddingItem
            ListItemText {
                role: "Title"
                text: "Homepage"
                mode: homelist.mode
            }
            ListItemText {
                id: homepagesuber
                role: "SubTitle"
                mode: homelist.mode
                text:  appsettings.getSystemSetting("homepage", "")===""? "Homepage Not Set":appsettings.getSystemSetting("homepage", "");
            }  }
   }
       ListItemer {
           id: engineList
           subItemIndicator: true
           anchors.horizontalCenter: parent.horizontalCenter
           onClicked: openenginechooser();
           Column { anchors.fill: engineList.paddingItem
           ListItemText {
               role: "Title"
               text: "Search Engine"
               mode: engineList.mode
           }
           ListItemText {
               id: engsub
               role: "SubTitle"
               mode: engineList.mode
               text: appsettings.getSystemSetting ("enginetitle", "")== "" ? "Choose a Search Engine to use": appsettings.getSystemSetting("enginetitle", "")

           }  }
       }
       ListItemer {
            id: fs
            enabled: true
            subItemIndicator: true
            onClicked: {openfontsize();}
            Column { anchors.fill: fs.paddingItem
            ListItemText {
                role: "Title"
                text: "Font Size"
                 mode: fs.mode

            }
            ListItemText {
                id: fs2
                role: "SubTitle"
                mode: fs.mode
                text: appsettings.getSystemSetting("fontsize", "")===""? "Current Size: 16": "Current Size: " +Math.round(appsettings.getSystemSetting("fontsize", "")*1);
            }  }
   }

       ListItemer {
            id: resetall
            enabled: true
            height: 51
            onClicked:{
                if (sensitiveMode=== true){
                    banner.showText ("Access Denied, Restricted Mode Activated")
                }
                else{
                    openreset()
                }
            }
            ListItemText {
                role: "Title"
                text: "Reset Star Browser"
                anchors.fill: resetall.paddingItem
            }
            }

       }
       }
 Flickable {
        z: 1
        Behavior on opacity {NumberAnimation{}}
        id: flickablecustom
        opacity: 0
        anchors.bottom: toptabbar.top
        anchors.right: parent.right
        anchors.left: parent.left
        anchors.top: toolbar.bottom
        contentHeight: columncustom.height
        contentWidth: columncustom.width

    Column {
        id: columncustom
        spacing: 1

       SelectionListItem {
           id: butcol
           anchors.horizontalCenter: parent.horizontalCenter
           title: appsettings.getSystemSetting ("colourtitleqa", "")== "" ? "Select a QA Colour": "QA Colour: " +appsettings.getSystemSetting("colourtitleqa", "")
           onClicked: openbuttonscolour()
       }
       SelectionListItem {
           id: tbutcol
           anchors.horizontalCenter: parent.horizontalCenter
           title: appsettings.getSystemSetting("tbutcol", "")== "" ? "Select a ToolButton Colour": "ToolButton Colour: " +appsettings.getSystemSetting("tbutcol", "")
           onClicked: opentbuttoncolour();
       }
       SelectionListItem {
           id: toolcol
           anchors.horizontalCenter: parent.horizontalCenter
           title: appsettings.getSystemSetting("tooltitle", "")== "" ? "Select a Toolbar Colour": "ToolBar Colour: " +appsettings.getSystemSetting("tooltitle", "")
           onClicked: opentoolbarcolour()
       }
       SelectionListItem{
           id: progressList
           anchors.horizontalCenter: parent.horizontalCenter
           title: appsettings.getSystemSetting("pctitle", "")== "" ? "Select Progress Bar Colour": "Progress Bar Colour: " +appsettings.getSystemSetting("pctitle", "")
           onClicked: {
               openprogress()
           }
       }
       SelectionListItem {
           id: bannerList
           anchors.horizontalCenter: parent.horizontalCenter
           title: appsettings.getSystemSetting("bantitle", "")== "" ? "Select Banner Colour": "Banner Colour: " +appsettings.getSystemSetting("bantitle", "")
           onClicked: {
               openbanner()
           }
       }

           ListItemer {
                id: vi
                enabled: false
                height:  screen.height===480? 62: 51

                ListItemText {
                    role: "Title"
                    text: "Visually Impaired Mode"
                    anchors.fill: vi.paddingItem
                }

                Switcher{
                     anchors.right: parent.right
                   anchors.rightMargin: 1
                    anchors.verticalCenter: parent.verticalCenter
                    checked: appsettings.getSystemSetting("visualImpaired", "false");
                    onClicked: {
                        if(appsettings.getSystemSetting("visualImpaired", "false")==="true"){ largeQAButtons=false; appsettings.saveSystemSetting("visualImpaired", "false");}
                        else{
                            appsettings.saveSystemSetting("visualImpaired", "true");
                      largeQAButtons=true;
                        }
                    }
                }

       }
           ListItemer {
                id: windows
                enabled: false
                height: 51
                ListItemText {
                    role: "Title"
                    text: "Use Old Window Switcher"
                    anchors.fill: windows.paddingItem
                }

                Switcher{
                     anchors.right: parent.right
                    anchors.rightMargin: 1
                    anchors.verticalCenter: parent.verticalCenter
                    checked: appsettings.getSystemSetting("switcherType", "")===""? false:true
                    onClicked: {
                        if(appsettings.getSystemSetting("switcherType", "")===""){appsettings.saveSystemSetting("switcherType", "old")}
                        else{appsettings.saveSystemSetting("switcherType", "")}
                    }
                }

       }
           ListItemer {
                id: downloadma
                enabled: false
                height: 51
                ListItemText {
                    role: "Title"
                    text: "Use Old Download Manager"
                    anchors.fill:downloadma.paddingItem
                }

                Switcher{
                     anchors.right: parent.right
                    anchors.rightMargin: 1
                    anchors.verticalCenter: parent.verticalCenter
                    checked: appsettings.getSystemSetting("DownloadManagerType", "")===""? false:true
                    onClicked: {
                        if(appsettings.getSystemSetting("DownloadManagerType", "")===""){appsettings.saveSystemSetting("DownloadManagerType", "old")}
                        else{appsettings.saveSystemSetting("DownloadManagerType", "")}
                    }
                }

       }
    }
    }
}
