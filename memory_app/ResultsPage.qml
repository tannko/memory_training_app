import QtQuick 2.0

Rectangle {
    id: root
    signal backToMenuClicked
    signal startAgainClicked
    signal nextLevelClicked

    // show Time and Quality Results and Total
    Rectangle {
        id: timeResult
        border.color: "black"
        anchors.centerIn: parent
    }

    Rectangle {
        id: qualityResult
        border.color: "black"
        anchors.top: timeResult.bottom
    }

    Rectangle {
        id: totalResult
        border.color: "black"
        anchors.top: qualityResult.bottom
    }

    Button {
        id: backToMenu
        text: "back"
        anchors.top: totalResult.bottom
        onClicked: {
            root.backToMenuClicked()
        }
    }
    Button {
        id: startAgain
        text: "startAgain"
        anchors.left: backToMenu.right
        onClicked: {
            root.startAgainClicked()
        }
    }
    Button {
        id: nextLevel
        text: "nextLevel"
        anchors.left: startAgain.right
        onClicked: {
            root.nextLevelClicked()
        }
    }
}
