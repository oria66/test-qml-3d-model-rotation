import QtQuick 2.11
import QtQuick.Controls 2.4
import QtQuick.Window 2.11
import QtQuick.Scene3D 2.0
import Qt3D.Core 2.0
import Qt3D.Render 2.0
import Qt3D.Input 2.0
import Qt3D.Extras 2.0


ApplicationWindow {
    visible: true
    width: 1366
    height: 768
    title: qsTr("Hello World")

    Rectangle {
        id: scene
        color: "transparent"
        anchors.fill: parent

        Scene3D {
            id: scene3d
            anchors.fill: parent
            anchors.margins: 10
            focus: true
            aspects: ["input", "logic"]
            cameraAspectRatioMode: Scene3D.AutomaticAspectRatio

            Entity {
                id: rootEntity

                Camera {
                    id: camera
                    position: Qt.vector3d( 20, 20, 20 )
                    viewCenter: Qt.vector3d( 0.0, 0.0, 0.0 )
                }

                OrbitCameraController{
                    camera: camera
                    linearSpeed: 50
                    lookSpeed: 180
                }

                components: [
                    RenderSettings {
                        activeFrameGraph: ForwardRenderer {
                            camera: camera
                            clearColor: "transparent"
                        }
                    },
                    InputSettings { }
                ]

                PhongMaterial{
                    id: theMaterial
                    ambient: Qt.rgba(0.5, 0.5, 0.5, 1.0)
                    diffuse: Qt.rgba(0.5, 0.5, 0.5, 1.0)
                    specular: Qt.rgba(0.5, 0.5, 0.5, 1.0)
                    shininess: 150.0
                }

                Mesh{
                    id:theMesh
                    source: "notebook.obj"
                }

                Transform {
                    id: objectTransform
                    property real userAngle: 0.0
                    matrix: {
                        var m = Qt.matrix4x4();
                        m.rotate(userAngle, Qt.vector3d(0, 1, 0));
                        m.translate(Qt.vector3d(0, 0, 0));
                        return m;
                    }
                }

                NumberAnimation {
                    target: objectTransform
                    property: "userAngle"
                    duration: 20000
                    from: 0
                    to: 360
                    loops: Animation.Infinite
                    running: true
                }

                Entity{
                    id: theEntity
                    components: [theMaterial,theMesh,objectTransform]
                }

            }


        }
    }

}
