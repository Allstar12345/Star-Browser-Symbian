/**
Copyright (C) 2020 Allstar Software (Paul Wallace)
*/
import QtQuick 1.1
import "../"

AppPage{
    colour:"black"
    TopToolBar{
        setDuration: "400"
        id: toolbar
        ToolButtonSense {
            id: btnBac
            imgsource: "../img/back_flat.svg"
            onClicked: {close();
         }
      }
    }
    function bytesToSize(downloadedbytes) {
        var sizes = ['Bytes', 'KB', 'MB', 'GB', 'TB'];
        if (downloadedbytes == 0) return 'n/a';
        var i = parseInt(Math.floor(Math.log(downloadedbytes) / Math.log(1024)));
        if (i == 0) return downloadedbytes + ' ' + sizes[i];
        return (downloadedbytes / Math.pow(1024, i)).toFixed(1) + ' ' + sizes[i];
    }
    Component.onCompleted: {show();toolbar.appear();}


    Column {
        anchors.top: toolbar.bottom
        id: columnsett
       spacing: 1
       ListHeader{id:header;headerText: "Downloads"}

    ProgressListItem{
        visible: downloadActive? true:false
        downloadActive: downloadActiveSlot1
        downloadPaused:  downloadPausedSlot1
        id: slot1
        downloadProgress: downloadProgressSlot1
        text:downloadURLSlot1
        subText: bytesToSize(downloadedbytesSlot1)+ " - " +downloadPercentageSlot1 +"%"
        onStopClicked: {downloadManager.cancel();}
        onPauseStartClicked: {if(downloadPaused===true){downloadManager.pause();}
            else{downloadManager.resume();}
        }
    }
    ProgressListItem{
        visible: downloadActive? true:false
        downloadActive: downloadActiveSlot2
        downloadPaused:  downloadPausedSlot2
        id: slot2
        downloadProgress: downloadProgressSlot2
        text:downloadURLSlot2
        subText: bytesToSize(downloadedbytesSlot2)+ " - " +downloadPercentageSlot2 +"%"
        onStopClicked: {downloadManager2.cancel();}
        onPauseStartClicked: {if(downloadPaused===true){downloadManager2.pause();}
            else{downloadManager2.resume();}
        }


    }
    }

}
