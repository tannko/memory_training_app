import QtQuick 2.0

Rectangle {
    id: root
    property alias src: set_pic.source
    signal clicked

    Image {
        id: set_pic
        anchors.centerIn: parent
        source: ""

        MouseArea {
            anchors.fill: parent
            onClicked: {
                root.clicked()
            }
        }
    }
}
