import QtQuick 2.9

Rectangle {
    id: root

    property bool cardOpened: false
    property bool isSelected: false
    property bool mouseClickEnabled: true
    property bool cardFrozen: false
    property alias src: card_face.source

    signal clicked

    state: "closed"

    states: [
        State {
            name: "opened"; when: cardOpened;
            PropertyChanges { target: card_face; visible: true }
            PropertyChanges { target: card_back; visible: false }

        },
        State {
            name: "closed"; when: !cardOpened;
            PropertyChanges {target: card_face; visible: false }
            PropertyChanges {target: card_back; visible: true }
        }
    ]

    transitions: [
        Transition {
            from: "opened"
            to: "closed"
            SequentialAnimation {
                id: revertAnimation

                NumberAnimation {
                    target: card_back
                    property: "height"
                    from: 0
                    to: card_back.sourceSize.height
                    duration: 400
                    easing.type: Easing.OutExpo
                }

            }
        },
        Transition {
            from: "closed"
            to: "opened"
            SequentialAnimation {
                NumberAnimation {
                    target: card_face
                    property: "height"
                    from: 0
                    to: card_face.sourceSize.height
                    duration: 400
                    easing.type: Easing.OutExpo
                }
            }

        }
    ]

    Image {
        id: card_face
        anchors.centerIn: parent
        source: 'img/empty.png'
        MouseArea {
            id: card_face_mouse
            width: parent.width
            height: parent.height
            enabled: !cardFrozen //true
            onClicked: {
                root.clicked()
            }
        }
    }

    Image {
        id: card_back
        anchors.centerIn: parent
        source: 'img/card_back_2.png'
        MouseArea {
            width: parent.width
            height: parent.height
            enabled: !cardFrozen
            onClicked: {
                root.clicked()
            }
        }
    }
}


