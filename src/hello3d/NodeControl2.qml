import QtQuick 2.15
import QtQuick3D 1.15
import QtQuick3D.Helpers 1.15

View3D {
    id: control

    //可以设置受控的节点为camera或者model
    property var controlNode: camera //cube

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

    //鼠标操作控制节点
    MouseArea {
        anchors.fill: parent
        hoverEnabled: false
        property int xTemp: 0
        property int yTemp: 0
        //滚轮缩放
        onWheel: {
            if(wheel.angleDelta.y>0){
                camera.z-=5
            }else{
                camera.z+=5
            }
        }
        onPressed: {
            xTemp = mouse.x
            yTemp = mouse.y
        }
        //按住鼠标移动转动方向
        onPositionChanged: {
            //欧拉角
            //绕x轴转 pitch俯仰角
            //绕y轴转 yaw偏航角
            //绕z轴转 roll滚动角
            //上下拖y值是绕x轴转
            controlNode.eulerRotation.x = controlNode.eulerRotation.x+(yTemp-mouse.y)*0.3
            //左右拖x值是绕y轴转
            controlNode.eulerRotation.y = controlNode.eulerRotation.y+(xTemp-mouse.x)*0.3
            xTemp = mouse.x
            yTemp = mouse.y
        }
    }

    //快捷键控制节点移动
    Shortcut {
        sequences: ["W","Up"]
        onActivated: {
            controlNode.y += 3;
        }
    }
    Shortcut {
        sequences: ["A","Left"]
        onActivated: {
            controlNode.x -= 3;
        }
    }
    Shortcut {
        sequences: ["S","Down"]
        onActivated: {
            controlNode.y -= 3;
        }
    }
    Shortcut {
        sequences: ["D","Right"]
        onActivated: {
            controlNode.x += 3;
        }
    }
}
