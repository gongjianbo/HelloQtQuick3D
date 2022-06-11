import QtQuick 2.15
import QtQuick.Controls 2.15

//目录页
Item {
    id: control

    //用listview来展示demo选项
    ListView {
        id: list_view
        anchors.fill: parent
        header: Rectangle {
            width: ListView.view.width
            height: 35
            color: "black"
            Text {
                anchors.centerIn: parent
                color: "white"
                text: "Demo List: "+list_view.count
            }
        }
        delegate: Rectangle {
            width: ListView.view.width
            height: 35
            color: mouse_area.containsMouse?"lightGray":"white"
            Rectangle {
                height: 1
                width: parent.width
                anchors.bottom: parent.bottom
                color: "black"
            }
            Text {
                anchors.centerIn: parent
                text: model.title //ListElement.demo
            }
            MouseArea {
                id: mouse_area
                anchors.fill: parent
                hoverEnabled: true
                //点击之后，切换loader加载页
                onClicked: {
                    loader_page.source=model.url
                    loader_page.title=model.title
                    home_page.visible=false
                }
            }
            ToolTip.text: model.url //ListElement.url
            ToolTip.visible: mouse_area.containsMouse
        }
        ScrollBar.vertical: ScrollBar{}

        section{
            //分组的属性
            property: "group"  //ListElement.group
            //可以按照全称分组，或者首字符ViewSection.FirstCharacter
            criteria: ViewSection.FullString
            delegate: Rectangle {
                width: ListView.view.width
                height: 35
                color: "gray"
                Rectangle {
                    height: 1
                    width: parent.width
                    anchors.bottom: parent.bottom
                    color: "black"
                }
                Text {
                    anchors.centerIn: parent
                    text: "【"+section+"】"
                }
            }
        }
        model: ListModel {
            id: list_model
            //"Hellow Qt Quick 3D：初相遇"
            ListElement {
                group: "Hellow Qt Quick 3D"
                title: "First Window：一个简单的窗口"
                url: "qrc:/src/hello3d/FirstWindow.qml"
            }
            ListElement {
                group: "Hellow Qt Quick 3D"
                title: "First Model：加载内置模型"
                url: "qrc:/src/hello3d/FirstModel.qml"
            }
            ListElement {
                group: "Hellow Qt Quick 3D"
                title: "First Triangle：嵌入Quick2D三角"
                url: "qrc:/src/hello3d/FirstTriangle.qml"
            }
            ListElement {
                group: "Hellow Qt Quick 3D"
                title: "Mesh Model：加载mesh模型文件"
                url: "qrc:/src/hello3d/MeshModel.qml"
            }
            ListElement {
                group: "Hellow Qt Quick 3D"
                title: "Node Control 1：与鼠标键盘的交互"
                url: "qrc:/src/hello3d/NodeControl1.qml"
            }
            ListElement {
                group: "Hellow Qt Quick 3D"
                title: "Node Control 2：与鼠标键盘的交互"
                url: "qrc:/src/hello3d/NodeControl2.qml"
            }
            ListElement {
                group: "Hellow Qt Quick 3D"
                title: "Pick Model：物体拾取"
                url: "qrc:/src/hello3d/PickModel.qml"
            }
            //"Qt Quick 3D Demo：示例学习"
            ListElement {
                group: "Qt Quick 3D Demo"
                title: "Simple Scene：弹跳小球"
                url: "qrc:/src/qtdemo/SimpleScene.qml"
            }
            ListElement {
                group: "Qt Quick 3D Demo"
                title: "View3D：多视口观察茶壶"
                url: "qrc:/src/qtdemo/View3DDemo.qml"
            }
        }
    }
}
