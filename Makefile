#############################################################################
# Makefile for building: StarBrowser
# Generated by qmake (2.01a) (Qt 4.7.4) on: Fri 15. May 22:41:59 2020
# Project:  StarBrowser.pro
# Template: app
# Command: c:\qtsdk\symbian\sdks\symbiansr1qt474\bin\qmake.exe -spec ..\..\..\..\QtSDK\Symbian\SDKs\SymbianSR1Qt474\mkspecs\symbian-sbsv2 CONFIG+=release -after  OBJECTS_DIR=obj MOC_DIR=moc UI_DIR=ui RCC_DIR=rcc -o bld.inf StarBrowser.pro
#############################################################################

MAKEFILE          = Makefile
QMAKE             = c:\qtsdk\symbian\sdks\symbiansr1qt474\bin\qmake.exe
DEL_FILE          = del /q 2> NUL
DEL_DIR           = rmdir
CHK_DIR_EXISTS    = if not exist
MKDIR             = mkdir
MOVE              = move
DEBUG_PLATFORMS   = winscw gcce armv5 armv6
RELEASE_PLATFORMS = gcce armv5 armv6
MAKE              = make
SBS               = sbs

DEFINES	 = -DSYMBIAN -DUNICODE -DQT_KEYPAD_NAVIGATION -DQT_SOFTKEYS_ENABLED -DQT_USE_MATH_H_FLOATS -DQT_USE_FAST_CONCATENATION -DQT_USE_FAST_OPERATOR_PLUS -DVERSION="1.75" -DQ_COMPONENTS_SYMBIAN -DHAVE_MOBILITY -DQT_NO_DEBUG -DQT_DECLARATIVE_LIB -DQT_WEBKIT_LIB -DQT_SCRIPT_LIB -DQT_XML_LIB -DQT_OPENGL_LIB -DQT_GUI_LIB -DQT_NETWORK_LIB -DQT_CORE_LIB
INCPATH	 =  -I"C:/QtSDK/Symbian/SDKs/SymbianSR1Qt474/include/QtCore"  -I"C:/QtSDK/Symbian/SDKs/SymbianSR1Qt474/include/QtNetwork"  -I"C:/QtSDK/Symbian/SDKs/SymbianSR1Qt474/include/QtGui"  -I"C:/QtSDK/Symbian/SDKs/SymbianSR1Qt474/include/QtOpenGL"  -I"C:/QtSDK/Symbian/SDKs/SymbianSR1Qt474/include/QtXml"  -I"C:/QtSDK/Symbian/SDKs/SymbianSR1Qt474/include/QtScript"  -I"C:/QtSDK/Symbian/SDKs/SymbianSR1Qt474/include/QtWebKit"  -I"C:/QtSDK/Symbian/SDKs/SymbianSR1Qt474/include/QtDeclarative"  -I"C:/QtSDK/Symbian/SDKs/SymbianSR1Qt474/include"  -I"C:/QtSDK/Symbian/SDKs/SymbianSR1Qt474/mkspecs/common/symbian"  -I"C:/QtSDK/Symbian/SDKs/SymbianSR1Qt474/epoc32/include"  -I"C:/QtSDK/Symbian/SDKs/SymbianSR1Qt474/epoc32/include/stdapis"  -I"C:/QtSDK/Symbian/SDKs/SymbianSR1Qt474/epoc32/include/stdapis/sys"  -I"C:/Users/Unknown/Desktop/StarBrowser/qmlapplicationviewer"  -I"C:/QtSDK/Symbian/SDKs/SymbianSR1Qt474/epoc32/include/mw"  -I"C:/QtSDK/Symbian/SDKs/SymbianSR1Qt474/epoc32/include/platform/mw"  -I"C:/QtSDK/Symbian/SDKs/SymbianSR1Qt474/epoc32/include/platform"  -I"C:/QtSDK/Symbian/SDKs/SymbianSR1Qt474/epoc32/include/platform/loc"  -I"C:/QtSDK/Symbian/SDKs/SymbianSR1Qt474/epoc32/include/platform/mw/loc"  -I"C:/QtSDK/Symbian/SDKs/SymbianSR1Qt474/epoc32/include/platform/loc/sc"  -I"C:/QtSDK/Symbian/SDKs/SymbianSR1Qt474/epoc32/include/platform/mw/loc/sc"  -I"C:/QtSDK/Symbian/SDKs/SymbianSR1Qt474/epoc32/include/stdapis/stlportv5"  -I"C:/QtSDK/Symbian/SDKs/SymbianSR1Qt474/include/QtXmlPatterns"  -I"C:/Users/Unknown/Desktop/StarBrowser/moc"  -I"C:/Users/Unknown/Desktop/StarBrowser"  -I"C:/Users/Unknown/Desktop/StarBrowser/rcc"  -I"C:/Users/Unknown/Desktop/StarBrowser/ui" 
first: default

all: debug release

default: debug-winscw
qmake:
	$(QMAKE) "C:/Users/Unknown/Desktop/StarBrowser/StarBrowser.pro"  -spec ..\..\..\..\QtSDK\Symbian\SDKs\SymbianSR1Qt474\mkspecs\symbian-sbsv2 CONFIG+=release -after  OBJECTS_DIR=obj MOC_DIR=moc UI_DIR=ui RCC_DIR=rcc

bld.inf: C:/Users/Unknown/Desktop/StarBrowser/StarBrowser.pro
	$(QMAKE) "C:/Users/Unknown/Desktop/StarBrowser/StarBrowser.pro"  -spec ..\..\..\..\QtSDK\Symbian\SDKs\SymbianSR1Qt474\mkspecs\symbian-sbsv2 CONFIG+=release -after  OBJECTS_DIR=obj MOC_DIR=moc UI_DIR=ui RCC_DIR=rcc

c:\Users\Unknown\Desktop\StarBrowser\StarBrowser.loc: 
	$(QMAKE) "C:/Users/Unknown/Desktop/StarBrowser/StarBrowser.pro"  -spec ..\..\..\..\QtSDK\Symbian\SDKs\SymbianSR1Qt474\mkspecs\symbian-sbsv2 CONFIG+=release -after  OBJECTS_DIR=obj MOC_DIR=moc UI_DIR=ui RCC_DIR=rcc

debug: c:\Users\Unknown\Desktop\StarBrowser\StarBrowser.loc bld.inf
	$(SBS) -c winscw_udeb.mwccinc -c arm.v5.udeb.gcce4_4_1 -c arm.v6.udeb.gcce4_4_1
clean-debug: bld.inf
	$(SBS) reallyclean --toolcheck=off -c winscw_udeb.mwccinc -c arm.v5.udeb.gcce4_4_1 -c arm.v6.udeb.gcce4_4_1
freeze-debug: bld.inf
	$(SBS) freeze -c winscw_udeb.mwccinc -c arm.v5.udeb.gcce4_4_1 -c arm.v6.udeb.gcce4_4_1
release: c:\Users\Unknown\Desktop\StarBrowser\StarBrowser.loc bld.inf
	$(SBS) -c arm.v5.urel.gcce4_4_1 -c arm.v6.urel.gcce4_4_1
clean-release: bld.inf
	$(SBS) reallyclean --toolcheck=off -c arm.v5.urel.gcce4_4_1 -c arm.v6.urel.gcce4_4_1
freeze-release: bld.inf
	$(SBS) freeze -c arm.v5.urel.gcce4_4_1 -c arm.v6.urel.gcce4_4_1

debug-winscw: c:\Users\Unknown\Desktop\StarBrowser\StarBrowser.loc bld.inf
	$(SBS) -c winscw_udeb.mwccinc
clean-debug-winscw: bld.inf
	$(SBS) reallyclean -c winscw_udeb.mwccinc
freeze-debug-winscw: bld.inf
	$(SBS) freeze -c winscw_udeb.mwccinc
debug-gcce: c:\Users\Unknown\Desktop\StarBrowser\StarBrowser.loc bld.inf
	$(SBS) -c arm.v5.udeb.gcce4_4_1
clean-debug-gcce: bld.inf
	$(SBS) reallyclean -c arm.v5.udeb.gcce4_4_1
freeze-debug-gcce: bld.inf
	$(SBS) freeze -c arm.v5.udeb.gcce4_4_1
debug-armv5: c:\Users\Unknown\Desktop\StarBrowser\StarBrowser.loc bld.inf
	$(SBS) -c armv5_udeb
clean-debug-armv5: bld.inf
	$(SBS) reallyclean -c armv5_udeb
freeze-debug-armv5: bld.inf
	$(SBS) freeze -c armv5_udeb
debug-armv6: c:\Users\Unknown\Desktop\StarBrowser\StarBrowser.loc bld.inf
	$(SBS) -c armv6_udeb
clean-debug-armv6: bld.inf
	$(SBS) reallyclean -c armv6_udeb
freeze-debug-armv6: bld.inf
	$(SBS) freeze -c armv6_udeb
release-gcce: c:\Users\Unknown\Desktop\StarBrowser\StarBrowser.loc bld.inf
	$(SBS) -c arm.v5.urel.gcce4_4_1
clean-release-gcce: bld.inf
	$(SBS) reallyclean -c arm.v5.urel.gcce4_4_1
freeze-release-gcce: bld.inf
	$(SBS) freeze -c arm.v5.urel.gcce4_4_1
release-armv5: c:\Users\Unknown\Desktop\StarBrowser\StarBrowser.loc bld.inf
	$(SBS) -c armv5_urel
clean-release-armv5: bld.inf
	$(SBS) reallyclean -c armv5_urel
freeze-release-armv5: bld.inf
	$(SBS) freeze -c armv5_urel
release-armv6: c:\Users\Unknown\Desktop\StarBrowser\StarBrowser.loc bld.inf
	$(SBS) -c armv6_urel
clean-release-armv6: bld.inf
	$(SBS) reallyclean -c armv6_urel
freeze-release-armv6: bld.inf
	$(SBS) freeze -c armv6_urel
debug-armv5-gcce4.4.1: c:\Users\Unknown\Desktop\StarBrowser\StarBrowser.loc bld.inf
	$(SBS) -c arm.v5.udeb.gcce4_4_1
clean-debug-armv5-gcce4.4.1: bld.inf
	$(SBS) reallyclean -c arm.v5.udeb.gcce4_4_1
freeze-debug-armv5-gcce4.4.1: bld.inf
	$(SBS) freeze -c arm.v5.udeb.gcce4_4_1
release-armv5-gcce4.4.1: c:\Users\Unknown\Desktop\StarBrowser\StarBrowser.loc bld.inf
	$(SBS) -c arm.v5.urel.gcce4_4_1
clean-release-armv5-gcce4.4.1: bld.inf
	$(SBS) reallyclean -c arm.v5.urel.gcce4_4_1
freeze-release-armv5-gcce4.4.1: bld.inf
	$(SBS) freeze -c arm.v5.urel.gcce4_4_1
debug-armv6-gcce4.4.1: c:\Users\Unknown\Desktop\StarBrowser\StarBrowser.loc bld.inf
	$(SBS) -c arm.v6.udeb.gcce4_4_1
clean-debug-armv6-gcce4.4.1: bld.inf
	$(SBS) reallyclean -c arm.v6.udeb.gcce4_4_1
freeze-debug-armv6-gcce4.4.1: bld.inf
	$(SBS) freeze -c arm.v6.udeb.gcce4_4_1
release-armv6-gcce4.4.1: c:\Users\Unknown\Desktop\StarBrowser\StarBrowser.loc bld.inf
	$(SBS) -c arm.v6.urel.gcce4_4_1
clean-release-armv6-gcce4.4.1: bld.inf
	$(SBS) reallyclean -c arm.v6.urel.gcce4_4_1
freeze-release-armv6-gcce4.4.1: bld.inf
	$(SBS) freeze -c arm.v6.urel.gcce4_4_1

export: bld.inf
	$(SBS) export -c winscw_udeb.mwccinc -c arm.v5.udeb.gcce4_4_1 -c arm.v6.udeb.gcce4_4_1 -c arm.v5.urel.gcce4_4_1 -c arm.v6.urel.gcce4_4_1

cleanexport: bld.inf
	$(SBS) cleanexport -c winscw_udeb.mwccinc -c arm.v5.udeb.gcce4_4_1 -c arm.v6.udeb.gcce4_4_1 -c arm.v5.urel.gcce4_4_1 -c arm.v6.urel.gcce4_4_1

freeze: freeze-release

check: first

run:
	call C:/QtSDK/Symbian/SDKs/SymbianSR1Qt474/epoc32/release/winscw/udeb/StarBrowser.exe $(QT_RUN_OPTIONS)

runonphone: sis
	runonphone $(QT_RUN_ON_PHONE_OPTIONS) --sis StarBrowser.sis StarBrowser.exe $(QT_RUN_OPTIONS)

StarBrowser_template.pkg: C:/Users/Unknown/Desktop/StarBrowser/StarBrowser.pro
	$(MAKE) -f $(MAKEFILE) qmake

StarBrowser_installer.pkg: C:/Users/Unknown/Desktop/StarBrowser/StarBrowser.pro
	$(MAKE) -f $(MAKEFILE) qmake

StarBrowser_stub.pkg: C:/Users/Unknown/Desktop/StarBrowser/StarBrowser.pro
	$(MAKE) -f $(MAKEFILE) qmake

sis: StarBrowser_template.pkg
	$(if $(wildcard .make.cache), $(MAKE) -f $(MAKEFILE) ok_sis MAKEFILES=.make.cache , $(if $(QT_SIS_TARGET), $(MAKE) -f $(MAKEFILE) ok_sis , $(MAKE) -f $(MAKEFILE) fail_sis_nocache ) )

ok_sis:
	C:\QtSDK\Symbian\SDKs\SymbianSR1Qt474\bin\createpackage.bat -g $(QT_SIS_OPTIONS) StarBrowser_template.pkg $(QT_SIS_TARGET) $(QT_SIS_CERTIFICATE) $(QT_SIS_KEY) $(QT_SIS_PASSPHRASE)

unsigned_sis: StarBrowser_template.pkg
	$(if $(wildcard .make.cache), $(MAKE) -f $(MAKEFILE) ok_unsigned_sis MAKEFILES=.make.cache , $(if $(QT_SIS_TARGET), $(MAKE) -f $(MAKEFILE) ok_unsigned_sis , $(MAKE) -f $(MAKEFILE) fail_sis_nocache ) )

ok_unsigned_sis:
	C:\QtSDK\Symbian\SDKs\SymbianSR1Qt474\bin\createpackage.bat -g $(QT_SIS_OPTIONS) -o StarBrowser_template.pkg $(QT_SIS_TARGET)

StarBrowser.sis:
	$(MAKE) -f $(MAKEFILE) sis

installer_sis: StarBrowser_installer.pkg sis
	$(MAKE) -f $(MAKEFILE) ok_installer_sis

ok_installer_sis: StarBrowser_installer.pkg
	C:\QtSDK\Symbian\SDKs\SymbianSR1Qt474\bin\createpackage.bat $(QT_SIS_OPTIONS) StarBrowser_installer.pkg - $(QT_SIS_CERTIFICATE) $(QT_SIS_KEY) $(QT_SIS_PASSPHRASE)

unsigned_installer_sis: StarBrowser_installer.pkg unsigned_sis
	$(MAKE) -f $(MAKEFILE) ok_unsigned_installer_sis

ok_unsigned_installer_sis: StarBrowser_installer.pkg
	C:\QtSDK\Symbian\SDKs\SymbianSR1Qt474\bin\createpackage.bat $(QT_SIS_OPTIONS) -o StarBrowser_installer.pkg

fail_sis_nocache:
	$(error Project has to be built or QT_SIS_TARGET environment variable has to be set before calling 'SIS' target)

stub_sis: StarBrowser_stub.pkg
	$(if $(wildcard .make.cache), $(MAKE) -f $(MAKEFILE) ok_stub_sis MAKEFILES=.make.cache , $(if $(QT_SIS_TARGET), $(MAKE) -f $(MAKEFILE) ok_stub_sis , $(MAKE) -f $(MAKEFILE) fail_sis_nocache ) )

ok_stub_sis:
	C:\QtSDK\Symbian\SDKs\SymbianSR1Qt474\bin\createpackage.bat -s $(QT_SIS_OPTIONS) StarBrowser_stub.pkg $(QT_SIS_TARGET) $(QT_SIS_CERTIFICATE) $(QT_SIS_KEY) $(QT_SIS_PASSPHRASE)

deploy: sis
	call StarBrowser.sis

mocclean: compiler_moc_header_clean compiler_moc_source_clean

mocables: compiler_moc_header_make_all compiler_moc_source_make_all

compiler_moc_header_make_all: moc\moc_qmlapplicationviewer.cpp moc\moc_qmlutils.cpp moc\moc_networkaccessmanagerinteractor.cpp moc\moc_networkmonitor.cpp moc\moc_mediakeysobserver.cpp moc\moc_useragent.cpp moc\moc_qdeclarativewebview.cpp moc\moc_qtdownload.cpp moc\moc_qsymbianapplication.cpp moc\moc_downloadbackend.cpp moc\moc_settings.cpp moc\moc_downloadmanager.cpp moc\moc_downloadmanager2.cpp moc\moc_customnetworkmanagerfactory.cpp
compiler_moc_header_clean:
	-$(DEL_FILE) moc\moc_qmlapplicationviewer.cpp moc\moc_qmlutils.cpp moc\moc_networkaccessmanagerinteractor.cpp moc\moc_networkmonitor.cpp moc\moc_mediakeysobserver.cpp moc\moc_useragent.cpp moc\moc_qdeclarativewebview.cpp moc\moc_qtdownload.cpp moc\moc_qsymbianapplication.cpp moc\moc_downloadbackend.cpp moc\moc_settings.cpp moc\moc_downloadmanager.cpp moc\moc_downloadmanager2.cpp moc\moc_customnetworkmanagerfactory.cpp
moc\moc_qmlapplicationviewer.cpp: qmlapplicationviewer\qmlapplicationviewer.h
	C:\QtSDK\Symbian\SDKs\SymbianSR1Qt474\bin\moc.exe $(DEFINES) $(INCPATH) -DSYMBIAN c:\Users\Unknown\Desktop\StarBrowser\qmlapplicationviewer\qmlapplicationviewer.h -o c:\Users\Unknown\Desktop\StarBrowser\moc\moc_qmlapplicationviewer.cpp

moc\moc_qmlutils.cpp: qmlutils.h
	C:\QtSDK\Symbian\SDKs\SymbianSR1Qt474\bin\moc.exe $(DEFINES) $(INCPATH) -DSYMBIAN c:\Users\Unknown\Desktop\StarBrowser\qmlutils.h -o c:\Users\Unknown\Desktop\StarBrowser\moc\moc_qmlutils.cpp

moc\moc_networkaccessmanagerinteractor.cpp: networkaccessmanagerinteractor.h
	C:\QtSDK\Symbian\SDKs\SymbianSR1Qt474\bin\moc.exe $(DEFINES) $(INCPATH) -DSYMBIAN c:\Users\Unknown\Desktop\StarBrowser\networkaccessmanagerinteractor.h -o c:\Users\Unknown\Desktop\StarBrowser\moc\moc_networkaccessmanagerinteractor.cpp

moc\moc_networkmonitor.cpp: networkmonitor.h
	C:\QtSDK\Symbian\SDKs\SymbianSR1Qt474\bin\moc.exe $(DEFINES) $(INCPATH) -DSYMBIAN c:\Users\Unknown\Desktop\StarBrowser\networkmonitor.h -o c:\Users\Unknown\Desktop\StarBrowser\moc\moc_networkmonitor.cpp

moc\moc_mediakeysobserver.cpp: mediakeysobserver.h
	C:\QtSDK\Symbian\SDKs\SymbianSR1Qt474\bin\moc.exe $(DEFINES) $(INCPATH) -DSYMBIAN c:\Users\Unknown\Desktop\StarBrowser\mediakeysobserver.h -o c:\Users\Unknown\Desktop\StarBrowser\moc\moc_mediakeysobserver.cpp

moc\moc_useragent.cpp: useragent.h
	C:\QtSDK\Symbian\SDKs\SymbianSR1Qt474\bin\moc.exe $(DEFINES) $(INCPATH) -DSYMBIAN c:\Users\Unknown\Desktop\StarBrowser\useragent.h -o c:\Users\Unknown\Desktop\StarBrowser\moc\moc_useragent.cpp

moc\moc_qdeclarativewebview.cpp: qdeclarativewebview.h
	C:\QtSDK\Symbian\SDKs\SymbianSR1Qt474\bin\moc.exe $(DEFINES) $(INCPATH) -DSYMBIAN c:\Users\Unknown\Desktop\StarBrowser\qdeclarativewebview.h -o c:\Users\Unknown\Desktop\StarBrowser\moc\moc_qdeclarativewebview.cpp

moc\moc_qtdownload.cpp: qtdownload.h
	C:\QtSDK\Symbian\SDKs\SymbianSR1Qt474\bin\moc.exe $(DEFINES) $(INCPATH) -DSYMBIAN c:\Users\Unknown\Desktop\StarBrowser\qtdownload.h -o c:\Users\Unknown\Desktop\StarBrowser\moc\moc_qtdownload.cpp

moc\moc_qsymbianapplication.cpp: qsymbianapplication.h
	C:\QtSDK\Symbian\SDKs\SymbianSR1Qt474\bin\moc.exe $(DEFINES) $(INCPATH) -DSYMBIAN c:\Users\Unknown\Desktop\StarBrowser\qsymbianapplication.h -o c:\Users\Unknown\Desktop\StarBrowser\moc\moc_qsymbianapplication.cpp

moc\moc_downloadbackend.cpp: downloadbackend.h
	C:\QtSDK\Symbian\SDKs\SymbianSR1Qt474\bin\moc.exe $(DEFINES) $(INCPATH) -DSYMBIAN c:\Users\Unknown\Desktop\StarBrowser\downloadbackend.h -o c:\Users\Unknown\Desktop\StarBrowser\moc\moc_downloadbackend.cpp

moc\moc_settings.cpp: settings.h
	C:\QtSDK\Symbian\SDKs\SymbianSR1Qt474\bin\moc.exe $(DEFINES) $(INCPATH) -DSYMBIAN c:\Users\Unknown\Desktop\StarBrowser\settings.h -o c:\Users\Unknown\Desktop\StarBrowser\moc\moc_settings.cpp

moc\moc_downloadmanager.cpp: downloadmanager.h
	C:\QtSDK\Symbian\SDKs\SymbianSR1Qt474\bin\moc.exe $(DEFINES) $(INCPATH) -DSYMBIAN c:\Users\Unknown\Desktop\StarBrowser\downloadmanager.h -o c:\Users\Unknown\Desktop\StarBrowser\moc\moc_downloadmanager.cpp

moc\moc_downloadmanager2.cpp: downloadmanager2.h
	C:\QtSDK\Symbian\SDKs\SymbianSR1Qt474\bin\moc.exe $(DEFINES) $(INCPATH) -DSYMBIAN c:\Users\Unknown\Desktop\StarBrowser\downloadmanager2.h -o c:\Users\Unknown\Desktop\StarBrowser\moc\moc_downloadmanager2.cpp

moc\moc_customnetworkmanagerfactory.cpp: settings.h \
		customnetworkmanagerfactory.h
	C:\QtSDK\Symbian\SDKs\SymbianSR1Qt474\bin\moc.exe $(DEFINES) $(INCPATH) -DSYMBIAN c:\Users\Unknown\Desktop\StarBrowser\customnetworkmanagerfactory.h -o c:\Users\Unknown\Desktop\StarBrowser\moc\moc_customnetworkmanagerfactory.cpp

compiler_rcc_make_all: rcc\qrc_symbian-res.cpp
compiler_rcc_clean:
	-$(DEL_FILE) rcc\qrc_symbian-res.cpp
rcc\qrc_symbian-res.cpp: symbian-res.qrc \
		qml\StarBrowser\TextAreaa.qml \
		qml\StarBrowser\TopToolBar.qml \
		qml\StarBrowser\HistoryCleaner.qml \
		qml\StarBrowser\AppManager.js \
		qml\StarBrowser\PrivacySettings.qml \
		qml\StarBrowser\TipsDio.qml \
		qml\StarBrowser\ListItemer.qml \
		qml\StarBrowser\TextContextMenuu.qml \
		qml\StarBrowser\MenuButton.qml \
		qml\StarBrowser\Constants.js \
		qml\StarBrowser\FeedEditDialog.qml \
		qml\StarBrowser\ShareArea.qml \
		qml\StarBrowser\SourceCodeMenu.qml \
		qml\StarBrowser\SearchBox.qml \
		qml\StarBrowser\ProgressTray.qml \
		qml\StarBrowser\Dialoger.qml \
		qml\StarBrowser\SectionScroller.js \
		qml\StarBrowser\Buttoner.qml \
		qml\StarBrowser\RSSFeeds.qml \
		qml\StarBrowser\BookmarksLongPressMenu.qml \
		qml\StarBrowser\test.html \
		qml\StarBrowser\TextSelectionHandlee.qml \
		qml\StarBrowser\ToolButtonSenseFloat.qml \
		qml\StarBrowser\ButtonSense.qml \
		qml\StarBrowser\HistoryView.qml \
		qml\StarBrowser\History.js \
		qml\StarBrowser\SettingsAdvanced.qml \
		qml\StarBrowser\SafeBrowsingSettings.qml \
		qml\StarBrowser\SHistory.js \
		qml\StarBrowser\ToolButtonSense.qml \
		qml\StarBrowser\MenuContenter.qml \
		qml\StarBrowser\FeedDeleteDialog.qml \
		qml\StarBrowser\Banner.qml \
		qml\StarBrowser\SearchHistorySaver.qml \
		qml\StarBrowser\SearchHistory.qml \
		qml\StarBrowser\TextMagnifierr.qml \
		qml\StarBrowser\BookmarkDelete.qml \
		qml\StarBrowser\HistoryToBookMarkAdder.qml \
		qml\StarBrowser\FirstRunScreenEType.qml \
		qml\StarBrowser\SelectionDialoger.qml \
		qml\StarBrowser\ButtonSenseFloat.qml \
		qml\StarBrowser\HistoryDelete.qml \
		qml\StarBrowser\HistoryDeleteAll.qml \
		qml\StarBrowser\Settings.qml \
		qml\StarBrowser\MenuSwipeIndicator.qml \
		qml\StarBrowser\FeedsDeleteAll.qml \
		qml\StarBrowser\FirstRunDialog.qml \
		qml\StarBrowser\AppPage.qml \
		qml\StarBrowser\CommonDialoger.qml \
		qml\StarBrowser\SearchHistoryDeleteAll.qml \
		qml\StarBrowser\BasePage.qml \
		qml\StarBrowser\MenuItemer.qml \
		qml\StarBrowser\LocationHistory.js \
		qml\StarBrowser\Decorator.qml \
		qml\StarBrowser\NightIntensityToggle.qml \
		qml\StarBrowser\BookMarkEditPage.qml \
		qml\StarBrowser\ContextMenuer.qml \
		qml\StarBrowser\PageToolMenu.qml \
		qml\StarBrowser\HistoryLongPressMenu.qml \
		qml\StarBrowser\feeds.js \
		qml\StarBrowser\MenuButtonLabel.qml \
		qml\StarBrowser\ProgressBaredit.qml \
		qml\StarBrowser\ScrollBarer.qml \
		qml\StarBrowser\main.qml \
		qml\StarBrowser\TabButtoner.qml \
		qml\StarBrowser\PopupMenu.qml \
		qml\StarBrowser\BookmarkDeleteAll.qml \
		qml\StarBrowser\Help.qml \
		qml\StarBrowser\dbcore.js \
		qml\StarBrowser\Database.js \
		qml\StarBrowser\FeedsLongPress.qml \
		qml\StarBrowser\HistorySaver.qml \
		qml\StarBrowser\PopupButton.qml \
		qml\StarBrowser\RSSFeedList.qml \
		qml\StarBrowser\Fader.qml \
		qml\StarBrowser\Label.qml \
		qml\StarBrowser\NightCover.qml \
		qml\StarBrowser\RSSDelegate.qml \
		qml\StarBrowser\BookmarkShare.qml \
		qml\StarBrowser\Popuper.qml \
		qml\StarBrowser\RectUtils.js \
		qml\StarBrowser\AutoNightCoverDialog.qml \
		qml\StarBrowser\Switcher.qml \
		qml\StarBrowser\BookmarksView.qml \
		qml\StarBrowser\GoogleSuggest.js \
		qml\StarBrowser\ListHeader.qml \
		qml\StarBrowser\TextTouchControllerr.qml \
		qml\StarBrowser\FlickItemSetup.qml \
		qml\StarBrowser\About.qml \
		qml\StarBrowser\ScrollButton.qml \
		qml\StarBrowser\CloseDialog.qml \
		qml\StarBrowser\SearchSuggestions\GoogleSearchSuggestion.qml \
		qml\StarBrowser\DownloadManager\DownloadManagerUI.qml \
		qml\StarBrowser\DownloadManager\ProgressListItem.qml \
		qml\StarBrowser\SettingsDialogs\SearchEngineChooser.qml \
		qml\StarBrowser\SettingsDialogs\CustomUAChooser.qml \
		qml\StarBrowser\SettingsDialogs\Homepage.qml \
		qml\StarBrowser\SettingsDialogs\ClearCookies.qml \
		qml\StarBrowser\SettingsDialogs\ToolBarColour.qml \
		qml\StarBrowser\SettingsDialogs\ReloadAllPages.qml \
		qml\StarBrowser\SettingsDialogs\FontSizeDialog.qml \
		qml\StarBrowser\SettingsDialogs\UserAgentChooser.qml \
		qml\StarBrowser\SettingsDialogs\ResetAll.qml \
		qml\StarBrowser\SettingsDialogs\CustomQAColour.qml \
		qml\StarBrowser\SettingsDialogs\HomePageChooser.qml \
		qml\StarBrowser\SettingsDialogs\BannerColour.qml \
		qml\StarBrowser\SettingsDialogs\ButtonsColour.qml \
		qml\StarBrowser\SettingsDialogs\SettingRestartPopup.qml \
		qml\StarBrowser\SettingsDialogs\ProgressBar.qml \
		qml\StarBrowser\SettingsDialogs\ToolButtonSenseColour.qml \
		qml\StarBrowser\SettingsDialogs\AutoReloadDuration.qml \
		qml\StarBrowser\SettingsDialogs\GlobalGoogleSearch.qml \
		qml\StarBrowser\RSSFeeds\FeedWindowChooser.qml \
		qml\StarBrowser\RSSFeeds\ShareAreaRSS.qml \
		qml\StarBrowser\RSSFeeds\FeedsEditPage.qml \
		qml\StarBrowser\WindowServer\PopupMenu.qml \
		qml\StarBrowser\WindowServer\Window1.qml \
		qml\StarBrowser\WindowServer\Window5.qml \
		qml\StarBrowser\WindowServer\PopupBut.qml \
		qml\StarBrowser\WindowServer\WindowFindText.qml \
		qml\StarBrowser\WindowServer\SwitcherLoadingIndicator.qml \
		qml\StarBrowser\WindowServer\HistorySaver.qml \
		qml\StarBrowser\WindowServer\GeoSaver.qml \
		qml\StarBrowser\WindowServer\Window2.qml \
		qml\StarBrowser\WindowServer\Window6.qml \
		qml\StarBrowser\WindowServer\WindowToolMenu.qml \
		qml\StarBrowser\WindowServer\FullScreenSwitcher.qml \
		qml\StarBrowser\WindowServer\ShareAreaWindows.qml \
		qml\StarBrowser\WindowServer\WindowServer.qml \
		qml\StarBrowser\WindowServer\Window3.qml \
		qml\StarBrowser\WindowServer\Window4.qml \
		qml\StarBrowser\WindowServer\FullScreenSwitcherItem.qml \
		qml\StarBrowser\WindowServer\SwitcherLongPressMenu.qml \
		qml\StarBrowser\QAComponents\WindowListItem.qml \
		qml\StarBrowser\QAComponents\ConsoleViewer.qml \
		qml\StarBrowser\QAComponents\StopIndicator.qml \
		qml\StarBrowser\QAComponents\WindowItemText.qml \
		qml\StarBrowser\QAComponents\OtherAppsModel.qml \
		qml\StarBrowser\QAComponents\OnScreenControlButtonRight.qml \
		qml\StarBrowser\QAComponents\ExtraMenuButton.qml \
		qml\StarBrowser\QAComponents\HTTPSIndicator.qml \
		qml\StarBrowser\QAComponents\OtherAppsDialog.qml \
		qml\StarBrowser\QAComponents\ReloadIndicator.qml \
		qml\StarBrowser\QAComponents\OnScreenControlButtonLeft.qml \
		qml\StarBrowser\QAComponents\WindowSelector.qml \
		qml\StarBrowser\QAComponents\EvaluateJSPopup.qml \
		qml\StarBrowser\img\information_userguide_flat.svg \
		qml\StarBrowser\img\next_flat.svg \
		qml\StarBrowser\img\windowLoad.svg \
		qml\StarBrowser\img\mute.svg \
		qml\StarBrowser\img\music.svg \
		qml\StarBrowser\img\pause.svg \
		qml\StarBrowser\img\home_flat.svg \
		qml\StarBrowser\img\web_page.svg \
		qml\StarBrowser\img\Code.svg \
		qml\StarBrowser\img\bufferingind.svg \
		qml\StarBrowser\img\refresh_flat.svg \
		qml\StarBrowser\img\qtg_fr_popup.svg \
		qml\StarBrowser\img\facebook.svg \
		qml\StarBrowser\img\drilldown.svg \
		qml\StarBrowser\img\refresh_holdcontrol.svg \
		qml\StarBrowser\img\stop.svg \
		qml\StarBrowser\img\qtg_fr_textfield_dark_highlighted.svg \
		qml\StarBrowser\img\switch_windows_flat.svg \
		qml\StarBrowser\img\qtg_fr_textfield_dark_editable.svg \
		qml\StarBrowser\img\add_flat.svg \
		qml\StarBrowser\img\qtg_fr_textfield_dark_error.svg \
		qml\StarBrowser\img\help.svg \
		qml\StarBrowser\img\full_screen_flat.svg \
		qml\StarBrowser\img\refresh.svg \
		qml\StarBrowser\img\history_flat.svg \
		qml\StarBrowser\img\selectAll.svg \
		qml\StarBrowser\img\rss_feed_flat.svg \
		qml\StarBrowser\img\qtg_graf_magnifier.svg \
		qml\StarBrowser\img\share_flat.svg \
		qml\StarBrowser\img\mail_flat.svg \
		qml\StarBrowser\img\delete_flat.svg \
		qml\StarBrowser\img\twitter.svg \
		qml\StarBrowser\img\messaging_flat.svg \
		qml\StarBrowser\img\favourite_flat.svg \
		qml\StarBrowser\img\toolbox.svg \
		qml\StarBrowser\img\stop_flat.svg \
		qml\StarBrowser\img\icon.svg \
		qml\StarBrowser\img\qtg_fr_pushbutton_normal_black.svg \
		qml\StarBrowser\img\settings_flat.svg \
		qml\StarBrowser\img\location_mark_small_off.svg \
		qml\StarBrowser\img\camera_flat.svg \
		qml\StarBrowser\img\console.svg \
		qml\StarBrowser\img\lock_flat.svg \
		qml\StarBrowser\img\window_switcher_close.svg \
		qml\StarBrowser\img\unlock_flat.svg \
		qml\StarBrowser\img\play.svg \
		qml\StarBrowser\img\download.svg \
		qml\StarBrowser\img\personalise_flat.svg \
		qml\StarBrowser\img\qtg_fr_popup_black.svg \
		qml\StarBrowser\img\save.svg \
		qml\StarBrowser\img\close_stop_flat.svg \
		qml\StarBrowser\img\error.svg \
		qml\StarBrowser\img\toolbar_extension_flat.svg \
		qml\StarBrowser\img\stoptopbar.svg \
		qml\StarBrowser\img\back_flat.svg \
		qml\StarBrowser\img\search_flat.svg \
		qml\StarBrowser\img\button_option_enabled_dark.svg \
		qml\StarBrowser\img\qtg_graf_magnifier_mask.svg \
		qml\StarBrowser\img\volume_increase.svg \
		qml\StarBrowser\img\javascript.svg \
		qml\StarBrowser\img\paste.svg \
		qml\StarBrowser\img\qtg_fr_textfield_dark_uneditable.svg \
		qml\StarBrowser\img\zoom_out.svg \
		qml\StarBrowser\img\volume_decrease.svg \
		qml\StarBrowser\img\location_mark_small.svg \
		qml\StarBrowser\img\button_option_enabled.svg \
		qml\StarBrowser\img\memory_flat.svg \
		qml\StarBrowser\img\minus-flat.svg \
		qml\StarBrowser\img\qtg_fr_pushbutton_normal.svg \
		qml\StarBrowser\img\night_flat.svg \
		qml\StarBrowser\img\undo.svg \
		qml\StarBrowser\img\zoom_in.svg \
		qml\StarBrowser\img\ToolButton\magenta.svg \
		qml\StarBrowser\img\ToolButton\purple.svg \
		qml\StarBrowser\img\ToolButton\empty.svg \
		qml\StarBrowser\img\ToolButton\float_background.svg \
		qml\StarBrowser\img\ToolButton\green.svg \
		qml\StarBrowser\img\ToolButton\blue.svg \
		qml\StarBrowser\img\ToolButton\red.svg \
		qml\StarBrowser\img\ToolButton\orange.svg \
		qml\StarBrowser\img\AudioVolume\audiovolumemute.svg \
		qml\StarBrowser\img\Setup\QAMenu.png \
		qml\StarBrowser\img\Setup\button.png \
		qml\StarBrowser\img\Button\magenta.svg \
		qml\StarBrowser\img\Button\purple.svg \
		qml\StarBrowser\img\Button\empty.svg \
		qml\StarBrowser\img\Button\green.svg \
		qml\StarBrowser\img\Button\blue.svg \
		qml\StarBrowser\img\Button\red.svg \
		qml\StarBrowser\img\Button\orange.svg \
		qml\StarBrowser\img\ScrollBar\qtg_fr_scrollbar_v_handle_light_normal.svg \
		qml\StarBrowser\img\ScrollBar\qtg_fr_scrollbar_v_handle_pressed.svg \
		qml\StarBrowser\img\ScrollBar\qtg_fr_scrollbar_h_handle_light_pressed.svg \
		qml\StarBrowser\img\ScrollBar\qtg_fr_scrollbar_v_track_normal.svg \
		qml\StarBrowser\img\ScrollBar\qtg_fr_scrollbar_h_handle_pressed.svg \
		qml\StarBrowser\img\ScrollBar\qtg_fr_scrollbar_h_track_normal.svg \
		qml\StarBrowser\img\ScrollBar\qtg_fr_scrollbar_h_handle_normal.svg \
		qml\StarBrowser\img\ScrollBar\qtg_fr_scrollbar_v_handle_light_pressed.svg \
		qml\StarBrowser\img\ScrollBar\qtg_fr_scrollbar_v_handle_normal.svg \
		qml\StarBrowser\img\ScrollBar\qtg_fr_scrollbar_h_handle_light_normal.svg \
		qml\StarBrowser\img\Switch\qtg_graf_switchbutton_fill_lime.svg \
		qml\StarBrowser\img\Switch\qtg_graf_switchbutton_fill_Magenta.svg \
		qml\StarBrowser\img\Switch\qtg_graf_switchbutton_disabled_off.svg \
		qml\StarBrowser\img\Switch\qtg_graf_switchbutton_fill.svg \
		qml\StarBrowser\img\Switch\qtg_graf_switchbutton_handle_normal.svg \
		qml\StarBrowser\img\Switch\qtg_graf_switchbutton_fill_orange.svg \
		qml\StarBrowser\img\Switch\qtg_graf_switchbutton_disabled_on.svg \
		qml\StarBrowser\img\Switch\qtg_graf_switchbutton_fill_red.svg \
		qml\StarBrowser\img\Switch\qtg_graf_switchbutton_handle_pressed.svg \
		qml\StarBrowser\img\Switch\qtg_graf_switchbutton_track.svg \
		qml\StarBrowser\img\Switch\qtg_graf_switchbutton_fill_blue.svg \
		qml\StarBrowser\img\Switch\qtg_graf_switchbutton_fill_default.svg \
		qml\StarBrowser\img\Switch\qtg_graf_switchbutton_fill_green.svg \
		qml\StarBrowser\img\Switch\qtg_graf_switchbutton_fill_purple.svg \
		qml\StarBrowser\img\SwipeIndicator\swipearrow_flat.svg \
		qml\StarBrowser\ComponentsSB\BookmarkSaver.qml \
		qml\StarBrowser\ComponentsSB\WebImageViewer.qml \
		qml\StarBrowser\ComponentsSB\PageFindText.qml \
		qml\StarBrowser\ComponentsSB\SliderDialog.qml \
		qml\StarBrowser\ComponentsSB\WebVideoPlayerControls.qml \
		qml\StarBrowser\ComponentsSB\ColourPeeker.qml \
		qml\StarBrowser\ComponentsSB\WebAudioVolumeChanger.qml \
		qml\StarBrowser\ComponentsSB\BufferIndicator.qml \
		qml\StarBrowser\ComponentsSB\WebAudioPlayer.qml \
		qml\StarBrowser\ComponentsSB\WebImageViewerFileTypeChooser.qml \
		qml\StarBrowser\ComponentsSB\WebVideoMenu.qml \
		qml\StarBrowser\ComponentsSB\ExtendingOptionsDialog.qml \
		qml\StarBrowser\ComponentsSB\ToolButtonSenseDialog.qml \
		qml\StarBrowser\ComponentsSB\PageBlockedPage.qml \
		qml\StarBrowser\ComponentsSB\GeoSaver.qml \
		qml\StarBrowser\ComponentsSB\WebVideoPlayer.qml \
		qml\StarBrowser\ComponentsSB\WebPageSnapper.qml \
		qml\StarBrowser\SettingsPages\DeveloperSettings.qml \
		qml\StarBrowser\SettingsPages\NetworkProxySettings.qml \
		qml\StarBrowser\SettingsPages\GeoLocationSettings.qml \
		qml\StarBrowser\SettingsPages\CacheSettings.qml \
		qml\StarBrowser\SettingsPages\ExternalAccessSettings.qml \
		qml\StarBrowser\UserTips\NightCover.qml \
		qml\StarBrowser\UserTips\Homepage.qml \
		qml\StarBrowser\UserTips\USBKeyboard.qml \
		qml\StarBrowser\UserTips\FileDownloading.qml \
		qml\StarBrowser\UserTips\StartupToolMenu.qml \
		qml\StarBrowser\UserTips\QAButton.qml \
		qml\StarBrowser\UserTips\HTML5Player.qml \
		qml\StarBrowser\UserTips\ButtonsDef.qml \
		qml\StarBrowser\SecurityComponents\OtherUserArea.qml \
		qml\StarBrowser\SecurityComponents\CreateNewCredentials.qml \
		qml\StarBrowser\SecurityComponents\EnterPasswordStart.qml \
		qml\StarBrowser\SecurityComponents\ChangePasswordDialog.qml \
		qml\StarBrowser\SecurityComponents\PasswordEnter.qml \
		qml\StarBrowser\SecurityComponents\ForgotPasswordArea.qml \
		splash\splash.png
	c:\QtSDK\Symbian\SDKs\SymbianSR1Qt474\bin\rcc.exe -name symbian-res c:\Users\Unknown\Desktop\StarBrowser\symbian-res.qrc -o c:\Users\Unknown\Desktop\StarBrowser\rcc\qrc_symbian-res.cpp

compiler_image_collection_make_all: ui\qmake_image_collection.cpp
compiler_image_collection_clean:
	-$(DEL_FILE) ui\qmake_image_collection.cpp
compiler_moc_source_make_all:
compiler_moc_source_clean:
compiler_uic_make_all:
compiler_uic_clean:
compiler_yacc_decl_make_all:
compiler_yacc_decl_clean:
compiler_yacc_impl_make_all:
compiler_yacc_impl_clean:
compiler_lex_make_all:
compiler_lex_clean:
compiler_clean: compiler_moc_header_clean compiler_rcc_clean 

dodistclean:
	-@ if EXIST "c:\Users\Unknown\Desktop\StarBrowser\StarBrowser_template.pkg" $(DEL_FILE)  "c:\Users\Unknown\Desktop\StarBrowser\StarBrowser_template.pkg"
	-@ if EXIST "c:\Users\Unknown\Desktop\StarBrowser\StarBrowser_stub.pkg" $(DEL_FILE)  "c:\Users\Unknown\Desktop\StarBrowser\StarBrowser_stub.pkg"
	-@ if EXIST "c:\Users\Unknown\Desktop\StarBrowser\StarBrowser_installer.pkg" $(DEL_FILE)  "c:\Users\Unknown\Desktop\StarBrowser\StarBrowser_installer.pkg"
	-@ if EXIST "c:\Users\Unknown\Desktop\StarBrowser\Makefile" $(DEL_FILE)  "c:\Users\Unknown\Desktop\StarBrowser\Makefile"
	-@ if EXIST "c:\Users\Unknown\Desktop\StarBrowser\StarBrowser_exe.mmp" $(DEL_FILE)  "c:\Users\Unknown\Desktop\StarBrowser\StarBrowser_exe.mmp"
	-@ if EXIST "c:\Users\Unknown\Desktop\StarBrowser\StarBrowser_reg.rss" $(DEL_FILE)  "c:\Users\Unknown\Desktop\StarBrowser\StarBrowser_reg.rss"
	-@ if EXIST "c:\Users\Unknown\Desktop\StarBrowser\StarBrowser.rss" $(DEL_FILE)  "c:\Users\Unknown\Desktop\StarBrowser\StarBrowser.rss"
	-@ if EXIST "c:\Users\Unknown\Desktop\StarBrowser\StarBrowser.loc" $(DEL_FILE)  "c:\Users\Unknown\Desktop\StarBrowser\StarBrowser.loc"
	-@ if EXIST "c:\Users\Unknown\Desktop\StarBrowser\bld.inf" $(DEL_FILE)  "c:\Users\Unknown\Desktop\StarBrowser\bld.inf"

distclean: clean dodistclean

clean: bld.inf
	-$(SBS) reallyclean --toolcheck=off -c winscw_udeb.mwccinc -c arm.v5.udeb.gcce4_4_1 -c arm.v6.udeb.gcce4_4_1 -c arm.v5.urel.gcce4_4_1 -c arm.v6.urel.gcce4_4_1


