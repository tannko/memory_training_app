import QtQuick 2.0

Rectangle {
    id: root
    signal startClicked
    signal settingsClicked

    Button {
        id: startButton
        text: "Start"
        anchors.centerIn: parent
        //anchors.top: parent.height/2
        //anchors.left: parent.width/2 - startButton.width - 15

        onClicked: {
            root.startClicked()
        }
    }

    Button {
        id: settingsButton
        text: "Settings"
        anchors.top: startButton.top
        anchors.left: startButton.right
        anchors.leftMargin: 30

        onClicked: {
            root.settingsClicked()
        }
    }

}
