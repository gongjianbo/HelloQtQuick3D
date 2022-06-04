import QtQuick 2.15
import QtQuick3D 1.15

View3D {
    id: control

    //背景
    environment: SceneEnvironment {
        clearColor: "darkGreen"
        backgroundMode: SceneEnvironment.Color
    }

    //观察相机
    PerspectiveCamera {
        z: 100
    }

    //光照
    DirectionalLight {
        eulerRotation.y: 45
    }

    //模型加载
    Model {
        position: Qt.vector3d(0, 0, 0)
        source: "qrc:/model/trefoil.mesh"
        scale: Qt.vector3d(10, 10, 10)
        materials: [
            DefaultMaterial {
                diffuseColor: "red"
            }
        ]
    }
}
