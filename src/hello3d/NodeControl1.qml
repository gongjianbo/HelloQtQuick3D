import QtQuick 2.15
import QtQuick3D 1.15
import QtQuick3D.Helpers 1.15

View3D {
    id: control

    //背景
    environment: SceneEnvironment {
        clearColor: "darkGreen"
        backgroundMode: SceneEnvironment.Color
    }

    //观察相机
    PerspectiveCamera {
        id: camera
        z: 100
    }

    //光照
    DirectionalLight {
        eulerRotation.y: 45
    }

    //模型
    Model {
        id: cube
        position: Qt.vector3d(0, 0, 0)
        source: "#Cube"
        scale: Qt.vector3d(0.2, 0.1, 0.2)
        materials: [
            DefaultMaterial {
                diffuseColor: "cyan"
            }
        ]
    }

    //使用键盘和鼠标来控制节点方位
    //W or up - 前进
    //S or down - 后退
    //A or left - 左移
    //D or right - 右移
    //R or page up - 上移
    //F or page down - 下移
    //shift与其他键同时按，移动可以加速
    //注意：按键控制需要WasdController具有焦点时才会响应
    //按住鼠标左键拖动是改变方向，可惜的是滚轮没有前进后退效果
    WasdController {
        id: wasd_control
        //指定受控对象，通常受控节点是相机
        controlledObject: camera //cube
    }

    //点击使control获得焦点，才能接受按键控制
    MouseArea {
        visible: !wasd_control.activeFocus
        anchors.fill: parent
        onClicked: {
            wasd_control.forceActiveFocus()
        }
    }
}
