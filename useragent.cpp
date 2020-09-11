/*Copyright (C) 2020 Allstar Software (Paul Wallace)*/

#include "useragent.h"
#include <QtGui/QApplication>
#include <QDebug>
#include "settings.h"

UserAgent::UserAgent(QObject *parent) :
    QObject(parent)
{
    update();
}

void UserAgent::update(){
    Setting*set = new Setting;

       QString m_userAgent = set->getUserAgent();
       qDebug() << "UA Value " +  m_userAgent;
        if (m_userAgent == "Default"){
            m_userAgent = "Mozilla/5.0 (iPhone; CPU iPhone OS 13_0 like Mac OS X) AppleWebKit/602.1.38 (KHTML, like Gecko) Version/10.0 Mobile/14A41DS1497c Safari/602.1";
            QApplication::setApplicationName(m_userAgent);
              qDebug() << QApplication::applicationName();
        }
            else if (m_userAgent == "Android"){
           m_userAgent = "Mozilla/5.0 (Linux; Android 10; Pixel 4 XL) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/78.0.3904.62 Mobile Safari/537.36";
           QApplication::setApplicationName(m_userAgent);
             qDebug() << QApplication::applicationName();
        }

            else if (m_userAgent == "Symbian"){
            m_userAgent = "Mozilla/5.0+(Symbian/3;+Series60/5.2+Nokia808PureView/113.010.1508;+Profile/MIDP-2.1+Configuration/CLDC-1.1+)+AppleWebKit/525+(KHTML,+like+Gecko)+Version/3.0+NokiaBrowser";
            QApplication::setApplicationName(m_userAgent);
              qDebug() << QApplication::applicationName();
        }
        else if (m_userAgent == "FireFox"){
            m_userAgent = "Mozilla/5.0 (Windows NT 6.1; rv:76.0) Gecko/20100101 Firefox/76.0";
            QApplication::setApplicationName(m_userAgent);
              qDebug() << QApplication::applicationName();
        }
        else if (m_userAgent == "WindowsPhone"){
            m_userAgent = "Mozilla/5.0 (compatible; MSIE 10.0; Windows Phone 8.0; Trident/6.0; IEMobile/10.0; ARM; Touch; NOKIA; Lumia 920)Mozilla/5.0 (Windows Phone 8.1; ARM; Trident/7.0; Touch; rv:11;IEMobile/11.0; NOKIA; Lumia 928) like Gecko";
            QApplication::setApplicationName(m_userAgent);
              qDebug() << QApplication::applicationName();
        }
        else if (m_userAgent == "BlackBerry10"){
            m_userAgent = "Mozilla/5.0 (BB10; Z10) AppleWebKit/537.35+ (KTML, like Gecko) Version/10.3.3.0;";
            QApplication::setApplicationName(m_userAgent);
              qDebug() << QApplication::applicationName();
        }
        else if (m_userAgent == "SailFish"){
            m_userAgent = "Mozilla/5.0 (Maemo; Linux; U; Jolla; Sailfish; Mobile; rv:31.0) Gecko/31.0 Firefox/31.0 SailfishBrowser/1.0";
            QApplication::setApplicationName(m_userAgent);
              qDebug() << QApplication::applicationName();
        }
        else if (m_userAgent == "AOSP"){
            m_userAgent = "Mozilla/5.0 (Linux; U; Android 10; ko-kr; Build/IML74K) AppleWebkit/534.30 (KHTML, like Gecko) Version/4.0 Mobile Safari/534.30";
            QApplication::setApplicationName(m_userAgent);
              qDebug() << QApplication::applicationName();
        }
        else if (m_userAgent == "OperaMini"){
            m_userAgent = "Opera/9.80 (J2ME/MIDP; Opera Mini/9.80 (S60; SymbOS; Opera Mobi/23.348; U; en) Presto/2.5.25 Version/10.54";
            QApplication::setApplicationName(m_userAgent);
              qDebug() << QApplication::applicationName();
        }
        else if (m_userAgent == "Edge"){
            m_userAgent = "Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/81.0.4044.129 Safari/537.36 Edg/81.0.416.68";
            QApplication::setApplicationName(m_userAgent);
              qDebug() << QApplication::applicationName();
        }
        else if (m_userAgent == "KaiOS"){
            m_userAgent = "Mozilla/5.0 (Mobile; rv:48.0; A405DL) Gecko/48.0 Firefox/48.0 KAIOS/2.5";
            QApplication::setApplicationName(m_userAgent);
            qDebug() << QApplication::applicationName();
        }
       else if (m_userAgent == "Custom"){
            m_userAgent = set->getCustomUserAgent();

        QApplication::setApplicationName(m_userAgent);
          qDebug() << QApplication::applicationName();}

        return;
        delete set;
}
