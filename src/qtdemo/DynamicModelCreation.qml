import QtQuick 2.15
import QtQuick.Controls 2.15
import QtQuick3D 1.15

//示例，动态创建模型节点
View3D {
    id: control

    //背景
    environment: SceneEnvironment {
        clearColor: "skyblue"
        backgroundMode: SceneEnvironment.Color
    }

    //光照
    PointLight {
        position: Qt.vector3d(0, 0, 0);
        brightness: 1500
    }

    Node {
        position: Qt.vector3d(0, 0, 0);

        PerspectiveCamera {
            position: Qt.vector3d(0, 0, 1000)
        }

        eulerRotation.y: -90

        //相机绕Y轴旋转
        SequentialAnimation on eulerRotation.y {
            loops: Animation.Infinite
            PropertyAnimation {
                duration: 5000
                to: 360
                from: 0
            }
        }
    }

    Node {
        id: wrapper
        property real range: 300

        //增加节点
        function appendModel()
        {
            let xPos = (2 * Math.random() * range) - range;
            let yPos = (2 * Math.random() * range) - range;
            let zPos = (2 * Math.random() * range) - range;
            //var node_comp = Qt.createComponent("ModelNode.qml");
            //创建一个节点，指定wrapper为parent
            let instance = node_comp.createObject(
                    wrapper, { "x": xPos, "y": yPos, "z": zPos,
                        "scale": Qt.vector3d(0.2, 0.2, 0.2) });
        }

        //移除节点
        function removeModel()
        {
            if(wrapper.children.length<1)
                return;
            //释放掉最后children一个
            wrapper.children[wrapper.children.length-1].destroy();
        }

        Component.onCompleted: {
            appendModel()
        }
    }

    Component {
        id: node_comp

        Node {
            property real xRotation: Math.random() * (360 - (-360)) + -360
            property real yRotation: Math.random() * (360 - (-360)) + -360
            property real zRotation: Math.random() * (360 - (-360)) + -360

            Model {
                source: "qrc:/model/teapot.mesh"
                scale: Qt.vector3d(150, 150, 150)
                eulerRotation.x: 90

                SequentialAnimation on eulerRotation {
                    loops: Animation.Infinite
                    PropertyAnimation {
                        duration: Math.random() * (6000 - 1) + 2000
                        to: Qt.vector3d(xRotation -  360, yRotation - 360, zRotation - 360)
                        from: Qt.vector3d(xRotation, yRotation, zRotation)
                    }
                }

                materials: DefaultMaterial {
                    diffuseColor: "red"
                }
            }
        }
    }

    //按钮
    Row {
        x: 20
        y: 20
        spacing: 20
        Button {
            //新版本有childNodes属性
            enabled: wrapper.children.length<100
            text: "Append"
            onClicked: wrapper.appendModel()
        }
        Button {
            enabled: wrapper.children.length>0
            text: "Remove"
            onClicked: wrapper.removeModel()
        }
        Label {
            anchors.verticalCenter: parent.verticalCenter
            text: "Model Count:"+wrapper.children.length
        }
    }
}
