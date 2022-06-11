import QtQuick 2.15
import QtQuick.Controls 2.15
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
    //View3D的mapTo/mapFrom坐标转换函数需要先设置camera属性
    camera: perspective_camera
    PerspectiveCamera {
        id: perspective_camera
        z: 300
    }

    //光照
    DirectionalLight {
        eulerRotation.y: 45
    }

    //立方体
    Model {
        id: cube_node
        objectName: "Cube"
        source: "#Cube"
        //使能pick
        pickable: true
        materials: DefaultMaterial {
            diffuseColor: mouse_area.pickNode == cube_node ? "cyan" : "yellow"
        }
        //立方体转动
        SequentialAnimation on eulerRotation {
            running: true
            loops: Animation.Infinite
            PropertyAnimation {
                duration: 10000
                from: Qt.vector3d(0, 0, 0)
                to: Qt.vector3d(360, 360, 360)
            }
        }
    }

    //锥体
    Model {
        id: cone_node
        objectName: "Cone"
        source: "#Cone"
        pickable: true
        x: 100
        z: 50
        materials: DefaultMaterial {
            diffuseColor: mouse_area.pickNode == cone_node ? "cyan" : "orange"
        }
    }

    //球体
    Model {
        id: sphere_node
        objectName: "Sphere"
        source: "#Sphere"
        pickable: true
        x: -100
        z: -50
        materials: DefaultMaterial {
            diffuseColor: mouse_area.pickNode == sphere_node ? "cyan" : "purple"
        }
    }

    //展示拾取对象的信息
    Row {
        x: 20
        y: 20
        spacing: 10
        Column {
            Label {
                color: "white"
                text: "Pick Node:"
            }
            Label {
                color: "white"
                text: "Screen Position:"
            }
            Label {
                color: "white"
                text: "Distance:"
            }
            Label {
                color: "white"
                text: "World Position:"
            }
        }
        Column {
            Label {
                id: pick_name
                color: "white"
            }
            Label {
                id: pick_screen
                color: "white"
            }
            Label {
                id: pick_distance
                color: "white"
            }
            Label {
                id: pick_word
                color: "white"
            }
        }
    }

    MouseArea {
        id: mouse_area
        anchors.fill: parent
        hoverEnabled: false
        property var pickNode: null
        //鼠标和物体xy的偏移
        property real xOffset: 0
        property real yOffset: 0
        property real zOffset: 0

        onPressed: {
            //获取点在View上的屏幕坐标
            pick_screen.text = "(" + mouse.x + ", " + mouse.y + ")"
            //pick取与该点射线路径相交的离最近的Model的信息，返回PickResult对象
            //因为该模块一直在迭代，新的版本可以从PickResult对象获取更多的信息
            //Qt6中还提供了pickAll获取与该射线相交的所有Model信息
            var result = control.pick(mouse.x, mouse.y)
            //目前只在点击时更新了pick物体的信息
            if (result.objectHit) {
                pickNode = result.objectHit
                pick_name.text = pickNode.objectName
                pick_distance.text = result.distance.toFixed(2)
                pick_word.text = "("
                        + result.scenePosition.x.toFixed(2) + ", "
                        + result.scenePosition.y.toFixed(2) + ", "
                        + result.scenePosition.z.toFixed(2) + ")"
                //console.log('in',pick_screen.text)
                //console.log(result.scenePosition)
                var map_from = control.mapFrom3DScene(pickNode.scenePosition)
                //var map_to = control.mapTo3DScene(Qt.vector3d(mouse.x,mouse.y,map_from.z))
                //console.log(map_from)
                //console.log(map_to)
                xOffset = map_from.x - mouse.x
                yOffset = map_from.y - mouse.y
                zOffset = map_from.z
            } else {
                pickNode = null
                pick_name.text = "None"
                pick_distance.text = " "
                pick_word.text = " "
            }
        }
        onPositionChanged: {
            if(!mouse_area.containsMouse || !pickNode){
                return
            }
            var pos_temp = Qt.vector3d(mouse.x + xOffset, mouse.y + yOffset, zOffset);
            var map_to = control.mapTo3DScene(pos_temp)
            pickNode.x = map_to.x
            pickNode.y = map_to.y
        }
    }
}
