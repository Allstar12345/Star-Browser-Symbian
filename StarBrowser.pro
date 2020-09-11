# Copyright (C) Allstar Software 2020 (Paul Wallace)

#folder_01.source = qml/StarBrowser
#folder_01.target = qml
DEPLOYMENTFOLDERS = folder_01
QML_IMPORT_PATH =

symbian:TARGET.UID3 = 0xE0324338
#0x20070763
symbian {
    TARGET.CAPABILITY += NetworkServices Location
 TARGET.EPOCHEAPSIZE = 0x90000 0x9999999
    my_deployment.pkg_prerules += vendorinfo
VERSION = 1.75
ICON= StarBrowser.svg
    DEPLOYMENT += my_deployment

    vendorinfo += "%{\"Allstar Software\"}" ":\"Allstar Software\""
    LIBS += -L\epoc32\release\armv5\lib -lremconcoreapi\
    LIBS += -L\epoc32\release\armv5\lib -lremconinterfacebase\
    LIBS += -letel3rdparty \
               -lapgrfx \
               -lfeatdiscovery \
               -lws32 \
               -lsysutil \
               -lefsrv \
               -lavkon\
               -lhal \
               -lapparc\
               -lcommondialogs\
               -leiksrv \
               -lcone\
                 -leikcore\
-lapgrfx \-lswinstcli\
-leikcdlg \
-leikdlg\
-lcommonui\
 -leikctl \
-leikcdlg\
-lapmime\
-lws32\
-laknnotify
DEFINES += QT_USE_FAST_CONCATENATION \
           QT_USE_FAST_OPERATOR_PLUS\
VERSION=\"$$VERSION\"


 crml.sources =Starbrowserkeydefs.qcrml sbdm.qcrml
 crml.path = c:/resource/qt/crml
DEPLOYMENT += crml
include(qmlapplicationviewer/qmlapplicationviewer.pri)
qtcAddDeployment()
    DEPLOYMENT.display_name += Star Browser
}

 CONFIG += mobility
 MOBILITY += systeminfo
 MOBILITY += multimedia
MOBILITY += systeminfo feedback multimedia
MOBILITY += publishsubscribe
MOBILITY += connectivity

CONFIG += qt-components

SOURCES += main.cpp \
    qmlutils.cpp \
    networkaccessmanagerinteractor.cpp \
    networkmonitor.cpp \
    qdeclarativewebview.cpp \
    mediakeysobserver.cpp \
    useragent.cpp \
    qtdownload.cpp\
    qsymbianapplication.cpp \
    downloadbackend.cpp \
    settings.cpp\
    downloadmanager.cpp \
    downloadmanager2.cpp\
 customnetworkmanagerfactory.cpp



QT += network
QT += webkit
QT += declarative network script
QT += xml

HEADERS += \
    qmlutils.h \
    networkaccessmanagerinteractor.h \
    networkmonitor.h \
    mediakeysobserver.h \
    useragent.h \
    qdeclarativewebview.h \
    qtdownload.h\
    qsymbianapplication.h \
    downloadbackend.h \
    settings.h\
    downloadmanager.h \
    downloadmanager2.h\
   customnetworkmanagerfactory.h

RESOURCES += \
    symbian-res.qrc


DEPLOYMENT += addFiles
addFiles.pkg_postrules += "\"DownloadManager\StarBrowserDownloadManager_reg.rsc\" - \"!:\private\10003a3f\import\apps\StarBrowserDownloadManager_reg.rsc\""
addFiles.pkg_postrules += "\"DownloadManager\StarBrowserDownloadManager.exe\" - \"!:\sys\bin\StarBrowserDownloadManager.exe\""
addFiles.pkg_postrules += "\"DownloadManager\StarBrowserDownloadManager.rsc\" - \"!:/resource/apps/StarBrowserDownloadManager.rsc\""
#addFiles.pkg_postrules += "\"DownloadManager\StarBrowserDownloadManager.mif\" - \"!:/resource/apps/StarBrowserDownloadManager.mif\""






crml.pkg_postrules = "\"sbdm.qcrml\" - \"c:/resource/qt/crml/sbdm_$${TARGET}.qcrml\""
crml.pkg_postrules = "\"Starbrowserkeydefs.qcrml\" - \"c:/resource/qt/crml/Starbrowserkeydefs_$${TARGET}.qcrml\""
#crml.pkg_postrules = "\"externalaccesssb.qcrml\" - \"c:/resource/qt/crml/externalaccesssb_$${TARGET}.qcrml\""




gccOption = "OPTION gcce -fpermissive"
MMP_RULES += gccOption\
 "EPOCPROCESSPRIORITY high"

#rssresources =      "SOURCEPATH	." \
#"START RESOURCE StarBrowser_0E0324339.rss" \
#"HEADER" \
#"TARGETPATH resource\apps" \
#"END" \
#MMP_RULES += rssresources

#OTHER_FILES += nativesymbiandlg.hrh StarBrowser_0E0324339.rss

#OTHER_FILES += Starbrowserkeydefs.qcrml

