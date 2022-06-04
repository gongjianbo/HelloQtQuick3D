import QtQuick 2.15
import QtQuick3D 1.15

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
        position: Qt.vector3d(0, 0, 350)
        //eulerRotation.x: -30
    }

    //光源
    PointLight {
        position: camera.position
        color: Qt.rgba(1, 1, 1)
        ambientColor: Qt.rgba(0.5, 0.5, 0.5)
        //光衰减项的常数因子，默认值1
        constantFade: 1.0
        //增加照明效果使灯光变暗的速度与到灯光的距离成比例，默认值0
        linearFade: 0.0
        //增加了照明效果使光线变暗的速率与平方反比定律成比例，默认值1
        quadraticFade: 0.1
    }

    //加载3D模型数据
    //为了使模型可渲染，它至少需要一个网格Mesh和一种材质Material
    //Qt Quick 3D本身内置了几个简单的模型
    //矩形
    Model {
        position: Qt.vector3d(-150, 100, 0)
        source: "#Rectangle"
        materials: [
            DefaultMaterial {
                diffuseColor: "red"
            }
        ]
    }
    //球体
    Model {
        position: Qt.vector3d(0, 100, 0)
        source: "#Sphere"
        materials: [
            DefaultMaterial {
                diffuseColor: "blue"
            }
        ]
    }
    //立方体
    Model {
        position: Qt.vector3d(150, 100, 0)
        source: "#Cube"
        //缩放
        scale: Qt.vector3d(1, 0.2, 1)
        //旋转
        eulerRotation: Qt.vector3d(45, 0, 0)
        materials: [
            DefaultMaterial {
                diffuseColor: "orange"
            }
        ]
    }
    //锥体
    Model {
        position: Qt.vector3d(-150, -100, 0)
        source: "#Cone"
        materials: [
            DefaultMaterial {
                diffuseColor: "yellow"
            }
        ]
    }
    //圆柱体
    Model {
        position: Qt.vector3d(0, -100, 0)
        source: "#Cylinder"
        materials: [
            DefaultMaterial {
                diffuseColor: "purple"
            }
        ]
    }
    //旋转的立方体
    Model {
        position: Qt.vector3d(150, -100, 0)
        source: "#Cube"
        scale: Qt.vector3d(0.8, 0.8, 0.8)
        materials: [
            DefaultMaterial {
                diffuseColor: "cyan"
            }
        ]
        //循环动画
        PropertyAnimation on eulerRotation {
            running: true
            loops: Animation.Infinite
            duration: 3000
            from: Qt.vector3d(0, 0, 0)
            to: Qt.vector3d(0, 360, 360)
        }
    }
}
