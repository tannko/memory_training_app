import QtQuick 2.0

Rectangle {
    id: root
    property alias text: label.text
    signal clicked

    width: 120
    height: 20
    border.color: "black"

    Text {
        id: label
        anchors.centerIn: parent
        text: "button"
    }

    MouseArea {
        anchors.fill: parent
        onClicked: root.clicked()
    }
}
