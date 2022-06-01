import QtQuick 2.15

//加载页
Item {
    id: control

    property alias title: text.text
    property alias source: loader.source

    //标题
    Rectangle {
        id: title
        width: parent.width
        height: 35
        color: "black"
        Text {
            id: text
            anchors.centerIn: parent
            color: "white"
        }
        //返回按钮
        Rectangle {
            anchors.left: parent.left
            anchors.leftMargin: 6
            anchors.verticalCenter: parent.verticalCenter
            width: 24
            height: 24
            radius: 12
            color: mouse_area.containsMouse?"white": "lightGray"
            Text {
                anchors.centerIn: parent
                color: "black"
                text: "←"
            }
            MouseArea {
                id: mouse_area
                hoverEnabled: true
                anchors.fill: parent
                //返回目录页
                onClicked: {
                    loader_page.source=""
                    home_page.visible=true
                }
            }
        }
    }
    //加载demo
    //note:在最初的版本我企图使用Loader切换View3D的Demo时会异常
    //但是在5.15.2+MSVC64bit环境下没复现崩溃问题
    Loader {
        id: loader
        anchors.fill: parent
        anchors.topMargin: title.height
    }
}

