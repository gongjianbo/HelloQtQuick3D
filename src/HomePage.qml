import QtQuick 2.15
import QtQuick.Controls 2.15

//目录页
Rectangle {

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
                    text: section
                }
            }
        }
        model: ListModel {
            id: list_model
            ListElement {
                group: "Hellow Qt Quick 3D"
                title: "First Window：一个简单的窗口"
                url: "qrc:/src/hello3d/FirstWindow.qml"
            }
            ListElement {
                group: "Hellow Qt Quick 3D"
                title: "First Model：内置的模型数据"
                url: "qrc:/src/hello3d/FirstModel.qml"
            }
            ListElement {
                group: "Hellow Qt Quick 3D"
                title: "First Triangle：嵌入Quick2D三角"
                url: "qrc:/src/hello3d/FirstTriangle.qml"
            }
        }
    }
}
