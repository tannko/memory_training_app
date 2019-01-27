import QtQuick 2.0

Rectangle {
    id: root
    signal backClicked

    Text {
        text: "Settings"
    }

    Button {
        text: "back"
        onClicked: {
            root.backClicked()

        }
    }

    // sounds On/Off
    // preview On/Off
}
