import QtQuick 2.15
import QtQuick.Window 2.15
import QtQuick3D 1.15
import QtQuick.Controls 2.15
import QtQuick.Layouts 1.15

//示例，多视口观察茶壶
Rectangle {
    id: control

    color: "#666666"

    //Scene根节点
    Node {
        id: stand_alone_scene

        //默认从正前方照射的平行光
        DirectionalLight {
            ambientColor: Qt.rgba(1.0, 1.0, 1.0, 1.0)
        }

        //一个立方体作为底座
        Model {
            source: "#Cube"
            y: -104
            //z轴方向缩小，成扁平状立方体
            scale: Qt.vector3d(3, 3, 0.1)
            //绕x轴旋转90度，这样z轴方向扁平就成了y轴方向扁平
            //这里应该是为了演示eulerRotation，否则直接设置scale y即可
            eulerRotation.x: -90
            materials: [
                DefaultMaterial {
                    //漫反射-灰色
                    diffuseColor: Qt.rgba(0.8, 0.8, 0.8, 1.0)
                }
            ]
        }

        //加载茶壶模型
        Model {
            source: "qrc:/model/teapot.mesh"
            y: -100
            scale: Qt.vector3d(50, 50, 50)
            materials: [
                PrincipledMaterial {
                    //基色，绿色
                    baseColor: "#41cd52"
                    //金属度，0非金属，1金属
                    metalness: 0.75
                    //粗糙度，0光滑，1粗糙
                    roughness: 0.1
                    //镜面反射，对非金属无效
                    specularAmount: 1.0
                    //折射率
                    indexOfRefraction: 2.5
                    //透明度，0透明
                    opacity: 1.0
                }
            ]

            //茶壶绕y轴旋转
            PropertyAnimation on eulerRotation.y {
                loops: Animation.Infinite
                duration: 5000
                to: 0
                from: -360
            }
        }

        //绕x轴旋转的透视投影相机
        Node {
            PerspectiveCamera {
                id: camera_perspective_rx
                z: 600
            }
            PropertyAnimation on eulerRotation.x {
                loops: Animation.Infinite
                duration: 5000
                to: -360
                from: 0
            }
        }

        //从正面观察的透视投影相机
        PerspectiveCamera {
            id: camera_perspective_front
            z: 600
        }

        //绕y轴旋转的透视投影相机
        Node {
            PerspectiveCamera {
                id: camera_perspective_ry
                x: 500
                eulerRotation.y: 90
            }
            PropertyAnimation on eulerRotation.y {
                loops: Animation.Infinite
                duration: 5000
                to: 0
                from: -360
            }
        }

        //绕x轴90度，在正上方正交投影相机
        OrthographicCamera {
            id: camera_orthographic_top
            y: 600
            eulerRotation.x: -90
        }

        //正前方正交投影相机
        OrthographicCamera {
            id: camera_orthographic_front
            z: 600
        }

        //绕y轴旋转90度，在左侧正交投影相机
        OrthographicCamera {
            id: camera_orthographic_left
            x: -600
            eulerRotation.y: -90
        }
    }

    //创建多个View3D视口，用不同的Camera来观察场景中的物体
    GridLayout {
        anchors.fill: parent
        anchors.margins: 2
        columns: 2
        columnSpacing: 2
        rowSpacing: 2

        View3D {
            Layout.fillWidth: true
            Layout.fillHeight: true
            importScene: stand_alone_scene
            camera: camera_orthographic_front
            Label {
                x: 10; y: 10
                color: "white"
                text: "Front"
            }
        }

        View3D {
            Layout.fillWidth: true
            Layout.fillHeight: true
            importScene: stand_alone_scene
            camera: camera_orthographic_top
            Label {
                x: 10; y: 10
                color: "white"
                text: "Top"
            }
        }

        View3D {
            Layout.fillWidth: true
            Layout.fillHeight: true
            importScene: stand_alone_scene
            camera: camera_orthographic_left
            Label {
                x: 10; y: 10
                color: "white"
                text: "Left"
            }
        }

        View3D {
            id: perspective_view
            Layout.fillWidth: true
            Layout.fillHeight: true
            camera: camera_perspective_rx
            importScene: stand_alone_scene
            //其他render效果不是很好，Qt5里渲染有点bug
            //renderMode: View3D.Underlay

            environment: SceneEnvironment {
                clearColor: "#555555"
                backgroundMode: SceneEnvironment.Color
            }

            Label {
                x: 10; y: 10
                color: "white"
                text: "Perspective"
            }

            //按钮切换不同的camera
            Row {
                anchors.bottom: parent.bottom
                anchors.horizontalCenter: parent.horizontalCenter
                anchors.margins: 10
                spacing: 10

                RoundButton {
                    height: 30
                    width: 120
                    text: "RotationX"
                    highlighted: perspective_view.camera == camera_perspective_rx
                    onClicked: {
                        perspective_view.camera = camera_perspective_rx
                    }
                }
                RoundButton {
                    height: 30
                    width: 120
                    text: "Front"
                    highlighted: perspective_view.camera == camera_perspective_front
                    onClicked: {
                        perspective_view.camera = camera_perspective_front
                    }
                }
                RoundButton {
                    height: 30
                    width: 120
                    text: "RotationY"
                    highlighted: perspective_view.camera == camera_perspective_ry
                    onClicked: {
                        perspective_view.camera = camera_perspective_ry
                    }
                }
            }
        }
    }
}
