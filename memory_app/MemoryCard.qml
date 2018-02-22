import QtQuick 2.9

Rectangle {
    id: root
    width: 140
    height: 180

    property bool cardOpened: false
    //property alias isOpened: card_pic.visible
    property alias src: card_pic.source
    signal clicked

    Image {
        id: card_pic
        anchors.centerIn: parent
        source: 'img/empty.png'
        visible: cardOpened
        property alias mouse_enabled: card_pic_mouse.enabled
        MouseArea {
            id: card_pic_mouse
            width: parent.width
            height: parent.height
            enabled: true
            onClicked: {
                closeCard()
                root.clicked()
            }
        }
    }

    Image {
        id: card_back
        anchors.centerIn: parent
        source: 'img/card_back_2.png'
        visible: !cardOpened
        MouseArea {
            width: parent.width
            height: parent.height
            onClicked: {
                openCard()
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
*/
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

}

