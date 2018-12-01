import QtQuick 2.9

Rectangle {
    id: root

    property bool cardOpened: false
    property bool isSelected: false
    property bool mouseClickEnabled: true
    property bool cardFreezed: false
    property alias src: card_pic.source

    signal clicked


    state: "closed"

    states: [
        State {
            name: "opened"; when: cardOpened;
            PropertyChanges { target: card_pic; visible: true }
            PropertyChanges { target: card_back; visible: false }

        },
        State {
            name: "closed"; when: !cardOpened;
            PropertyChanges {target: card_pic; visible: false }
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
                    to: card_back.height
                    duration: 100
                    //easing.type: Easing.InOutQuad
                }

                // should be the sequential animation for the card revert
            }
        },
        // add reverted Transition too
        Transition {
            from: "closed"
            to: "opened"
            SequentialAnimation {
                NumberAnimation {
                    target: card_pic
                    property: "height"
                    from: 0
                    to: card_pic.height
                    duration: 100
                    //easing.type: Easing.InOutQuad
                }
            }

        }

    ]



    Image {
        id: card_pic
        anchors.centerIn: parent
        source: 'img/empty.png'
        //visible: cardOpened
        //property alias mouse_enabled: card_pic_mouse.enabled
        MouseArea {
            id: card_pic_mouse
            width: parent.width
            height: parent.height
            enabled: !cardFreezed //true
            onClicked: {
                //closeCard()
                root.clicked()
            }
        }
    }

    Image {
        id: card_back
        anchors.centerIn: parent
        source: 'img/card_back_2.png'
        //visible: !cardOpened
        MouseArea {
            width: parent.width
            height: parent.height
            enabled: !cardFreezed
            onClicked: {
                //openCard()
                root.clicked()
            }
        }
    }
/*
    Text {
        id: txt
        text: 'closed'
        //anchors.
    }

    function closeCard() {
        cardOpened = false;
        //card_back.visible = true;
        //card_pic.visible = false;
    }

    function openCard() {
        cardOpened = true;
        //card_back.visible = false;
        //card_pic.visible = true;
    }

    function freeze() {
        card_pic.mouse_enabled = false;
    }
*/

}


