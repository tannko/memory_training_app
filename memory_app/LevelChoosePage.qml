import QtQuick 2.0

Rectangle {
    id: root
    signal backClicked
    signal levelClicked

    Button {
        anchors.bottom: parent.bottom
        text: "back"
        onClicked: {
            root.backClicked()
        }
    }

    Text {
        text: "LevelChoosePage"
    }

    Rectangle {
        anchors.centerIn: parent
        width: 100
        height: 100
        border.color: "black"

        MouseArea {
            anchors.fill: parent
            onClicked: {
                root.levelClicked();
            }
        }

    }

    // here must be grid of images-levels to choose
}
