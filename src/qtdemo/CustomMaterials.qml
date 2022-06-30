import QtQuick 2.15
import QtQuick3D 1.15
import QtQuick3D.Materials 1.15

//示例，自定义材质
View3D {
    id: control

    environment: SceneEnvironment {
        //清除颜色
        clearColor: "darkCyan"
        //控制是否以及如何清除场景的背景
        backgroundMode: SceneEnvironment.Color
        //修改光探测器发出的光量
        probeBrightness: 1000
        //用于照亮场景的图像（最好是高动态范围图像）
        //以代替标准灯光或作为标准灯光的补充
        lightProbe: Texture {
            source: "qrc:/img/OpenfootageNET_garage-1024.hdr"
        }
        //控制渲染场景时应用的抗锯齿模式
        //NoAA --默认无抗锯齿
        //SSAA --超级采样抗锯齿，场景以更高的分辨率渲染，然后按比例缩小到实际分辨率
        //MSAA --多重采样抗锯齿，几何体的边缘经过超级采样，产生更平滑的轮廓
        //ProgressiveAA --渐进式抗锯齿，当场景的所有内容都停止移动时，相机会在帧之间轻微晃动，新帧和之前的混合
        antialiasingMode: SceneEnvironment.SSAA
        //应用于场景的抗锯齿级别
        antialiasingQuality: SceneEnvironment.VeryHigh
    }

    camera: camera

    PerspectiveCamera {
        id: camera
        position: Qt.vector3d(0, 0, 500)
    }

    //铝材质
    Model {
        position: Qt.vector3d(-100, 100, 0)
        source: "#Sphere"
        materials: [ AluminumMaterial {
                //调整凹凸，使看起来有破损或者铸造
                bump_amount: 5.0
            }
        ]
    }

    //铜材质
    Model {
        position: Qt.vector3d(-100, -100, 0)
        source: "#Sphere"
        materials: [ CopperMaterial {
            }
        ]
    }

    //玻璃材质
    Model {
        position: Qt.vector3d(100, 100, 0)
        source: "#Sphere"
        materials: [ FrostedGlassSinglePassMaterial {
                //粗糙度，默认0
                //roughness: 0.1
                //反射率，默认1
                //reflectivity_amount: 0.9
                //折射率
                glass_ior: 1.9
                //基础颜色
                glass_color: Qt.vector3d(0, 1, 0)
            }
        ]
    }

    //塑料材质
    Model {
        position: Qt.vector3d(100, -100, 0)
        source: "#Sphere"
        materials: [ PlasticStructuredRedMaterial {
                //折射率
                material_ior: 1.55
                //纹理缩放
                bump_factor: 0.1
            }
        ]
    }
}
