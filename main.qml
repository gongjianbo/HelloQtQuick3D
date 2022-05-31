import QtQuick 2.15
import QtQuick.Window 2.15
import "./src"

//Qt Quick 3D是Qt5.14开始出的一个新模块
//pro文件中 QT += quick3d，但貌似不是必须的
//按照官方的说辞可以看成一个易于操作的简化版的Qt 3D模块
//我在main.cpp中设置了全局字体
Window {
    visible: true
    width: 640
    height: 480
    title: qsTr("Hello Qt Quick 3D (by GongJianBo 1992)")

    HomePage {
        id: home_page
        visible: true
        anchors.fill: parent
    }

    LoaderPage {
        id: loader_page
        visible:!home_page.visible
        anchors.fill: parent
    }
}
