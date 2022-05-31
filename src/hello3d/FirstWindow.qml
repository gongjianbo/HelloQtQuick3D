import QtQuick 2.15
import QtQuick3D 1.15

Item {
    id: control

    //渲染3D场景的视口
    //View3D为要渲染的3D内容提供2D表面。在将3D内容显示在Qt Quick场景中之前，必须先将其展平。
    //it must first be flattend.
    View3D {
        id: view
        anchors.fill: parent
        anchors.margins: 20

        //为了控制场景的呈现，有必要定义一个SceneEnvironment的环境属性。
        //SceneEnvironment定义了渲染场景的环境，该环境定义了如何全局渲染场景。
        environment: SceneEnvironment {
            clearColor: "darkGreen"
            backgroundMode: SceneEnvironment.Color
        }

        //要将3D场景投影到2D视口，必须从摄像机查看场景。
        //正交投影：OrthographicCamera
        //透视投影：PerspectiveCamera
        OrthographicCamera {
            position: Qt.vector3d(0, 0, 0)
        }
    }
    Text {
        anchors.centerIn: parent
        text: "First Window"
        color: "white"
    }
}
