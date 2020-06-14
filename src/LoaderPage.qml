import QtQuick 2.15

//加载页
Rectangle {
    property alias title: text.text
    property alias source: loader.source

    //标题
    Rectangle{
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
        Rectangle{
            anchors.left: parent.left
            anchors.leftMargin: 6
            anchors.verticalCenter: parent.verticalCenter
            width: 24
            height: 24
            radius: 12
            color: mousearea.containsMouse?"white": "lightGray"
            Text{
                anchors.centerIn: parent
                color: "black"
                text: "←"
            }
            MouseArea{
                id: mousearea
                hoverEnabled: true
                anchors.fill: parent
                //返回目录页
                onClicked: {
                    loaderPage.source=""
                    homePage.visible=true
                }
            }
        }
    }
    //加载demo
    Loader{
        id: loader
        anchors.fill: parent
        anchors.topMargin: title.height
    }
}

