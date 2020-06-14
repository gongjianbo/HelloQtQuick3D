import QtQuick 2.15
import QtQuick.Controls 2.15

//目录页
Rectangle {

    //用listview来展示demo选项
    ListView{
        id: listview
        anchors.fill: parent
        header: Rectangle{
            width: ListView.view.width
            height: 35
            color: "black"
            Text {
                anchors.centerIn: parent
                color: "white"
                text: "Demo List: "+listview.count
                font{
                    family: "宋体"
                    pixelSize: 16
                }
                renderType: Text.NativeRendering
            }
        }
        delegate: Rectangle{
            width: ListView.view.width
            height: 35
            color: mousearea.containsMouse?"lightGray":"white"
            Rectangle{
                height: 1
                width: parent.width
                anchors.bottom: parent.bottom
                color: "black"
            }
            Text {
                anchors.centerIn: parent
                text: demo //ListElement.demo
            }
            MouseArea{
                id: mousearea
                anchors.fill: parent
                hoverEnabled: true
                //点击之后，切换loader加载页
                onClicked: {
                    loaderPage.source=url
                    loaderPage.title=demo
                    homePage.visible=false
                }
            }
            ToolTip.text: url //ListElement.url
            ToolTip.visible: mousearea.containsMouse
        }
        ScrollBar.vertical: ScrollBar{}

        section{
            //分组的属性
            property: "group"  //ListElement.group
            //可以按照全称分组，或者首字符ViewSection.FirstCharacter
            criteria: ViewSection.FullString
            delegate: Rectangle{
                width: ListView.view.width
                height: 35
                color: "gray"
                Rectangle{
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
        model: ListModel{
            id: listmodel
            ListElement{
                group: "Hellow Qt Quick 3D"
                demo: "First Window：一个简单的窗口"
                url: "qrc:/src/hello3d/FirstWindow.qml"
            }
            ListElement{
                group: "Hellow Qt Quick 3D"
                demo: "First Model：内置的模型数据"
                url: "qrc:/src/hello3d/FirstModel.qml"
            }
        }
    }
}
