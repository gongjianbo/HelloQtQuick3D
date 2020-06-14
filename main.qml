import QtQuick 2.15
import QtQuick.Window 2.15
import "./src"

//QtQuick3D时Qt5.14开始出的一个新模块
//pro文件中 QT += quick3d，但貌似不是必须的
//按照官方的说辞可以看成一个易于操作的简化版的Qt3D模块
//我在main.cpp中设置了全局字体
Window {
    visible: true
    width: 640
    height: 480
    title: qsTr("Hello Qt Quick 3D")
    Component.onCompleted: {
        console.log("QQ交流群：647637553")
    }

    HomePage{
        id: homePage
        visible: true
        anchors.fill: parent
    }
    //企图使用Loader切换View3D的Demo时会异常
    LoaderPage{
        id:loaderPage
        visible:!homePage.visible
        anchors.fill: parent
    }
}
