import QtQuick 2.15
import QtQuick3D 1.15
import QtQuick.Shapes 1.15

//渲染3D场景的视口
View3D {
    id: control

    environment: SceneEnvironment {
        clearColor: "darkGreen"
        backgroundMode: SceneEnvironment.Color
    }

    //透视投影
    PerspectiveCamera {
        id: camera
        position: Qt.vector3d(0, 0, 300)
        //eulerRotation.x: -30
    }

    //光源
    DirectionalLight {
        eulerRotation.x: -100
        eulerRotation.y: -100
        eulerRotation.z: 500
    }

    //自定义Geometry还得从Cpp注册，或者source加载自己的mesh文件
    //为了图方便，贴一个Quick2的Shape来展示三角
    Node {
        position: Qt.vector3d(0, 0, 0)
        Shape {
            id: shape
            width: 300
            height: 200
            ShapePath {
                strokeColor: "transparent"
                fillColor: "lightGreen"
                startX: shape.width/2; startY: 0
                PathLine { x: shape.width; y: shape.height }
                PathLine { x: 0; y: shape.height }
                PathLine { x: shape.width/2; y: 0 }
            }
        }
    }
}
