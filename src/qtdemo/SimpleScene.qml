import QtQuick 2.15
import QtQuick3D 1.15

//示例，弹跳小球
View3D {
    id: control

    //背景
    environment: SceneEnvironment {
        clearColor: "skyblue"
        backgroundMode: SceneEnvironment.Color
    }

    //观察相机
    PerspectiveCamera {
        position: Qt.vector3d(0, 200, 300)
        eulerRotation.x: -30
    }

    //光照
    DirectionalLight {
        eulerRotation.x: -30
        eulerRotation.y: -70
    }

    //底部红色托盘
    Model {
        position: Qt.vector3d(0, -200, 0)
        source: "#Cylinder"
        scale: Qt.vector3d(2, 0.2, 1)
        materials: [
            DefaultMaterial {
                diffuseColor: "red"
            }
        ]
    }

    //弹跳的蓝色小球
    Model {
        position: Qt.vector3d(0, 150, 0)
        source: "#Sphere"
        materials: [
            DefaultMaterial {
                diffuseColor: "blue"
            }
        ]

        //循环动画修改y值，弹跳效果
        SequentialAnimation on y {
            loops: Animation.Infinite
            NumberAnimation {
                duration: 3000
                to: -150
                from: 150
                easing.type:Easing.InQuad
            }
            NumberAnimation {
                duration: 3000
                to: 150
                from: -150
                easing.type:Easing.OutQuad
            }
        }
    }
}
