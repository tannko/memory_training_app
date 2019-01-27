import QtQuick 2.0

Rectangle {
    id: root
    signal continueClicked
    signal startAgainClicked
    signal backClicked

    Button {
        id: continueGame
        text: "continue"
        anchors.centerIn: parent
        onClicked: {
            root.continueClicked()
        }
    }

    Button {
        id: startLevelAgain
        text: "startAgain"
        anchors.left: continueGame.right
        anchors.bottom: continueGame.bottom
        onClicked: {
            root.startAgainClicked()
        }
    }

    Button {
        id: backToMenu
        text: "back"
        anchors.bottom: parent.bottom

        onClicked: {
            root.backClicked()
        }
    }
}
