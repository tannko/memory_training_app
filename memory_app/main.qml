import QtQuick 2.9
import QtQuick.Window 2.2
import Qt.labs.folderlistmodel 2.1

Window {
    visible: true
    width: 1024
    height: 768
    title: qsTr("Memory")

    Image {
        id: card_table
        anchors.centerIn: parent
        source: 'img/table.png'

        Timer {
            id: preview_timer
            interval: 3000
            repeat: false
            onTriggered: {
                grid.closeAllCards();
            }
        }

        Timer {
            id: closing_timer
            interval: 500
            repeat: false
            property MemoryCard currentCard: null
            onTriggered: {
                currentCard.closeCard();
                grid.lastOpenCard.closeCard();
                grid.lastOpenCard = null // pair is closed or matched, start from the null again
            }
        }

        FolderListModel {
            id: folderModel
            folder: 'img/physics'
            nameFilters: [ "*.png"]
        }

        GridView {
            id: grid
            anchors.fill: parent
            anchors.margins: 150
            model: getIndexArray(folderModel.count)

            cellWidth: 150
            cellHeight: 190

            property int openCardsCount: 0
            property MemoryCard lastOpenCard: null

            property bool allCardsOpen: false

            function openAllCards() {
                allCardsOpen = true
            }

            function closeAllCards() {
                allCardsOpen = false
            }

            function getIndexArray(count) {
                var i = 0, j = 0, array = [];
                for (i=0; i< count; i++) {
                    for (j=0; j<2; j++)
                        array.push(i);
                }
                shuffle(array);
                return array;
            }

            function shuffle(array) { //Fisher-Yates shuffling (modern)
                var i = 0, j = 0, temp = null;

                for (i = array.length-1; i > 0; i-=1) {
                    j = Math.floor(Math.random()*(i+1));
                    temp = array[i]
                    array[i] = array[j]
                    array[j] = temp
                }
            }

            delegate: mc

        }

        Component {
            id: mc

            MemoryCard {

                property bool forseOpening : grid.allCardsOpen;

                src: 'img/physics/physics_' + modelData + '.png'

                onForseOpeningChanged: {
                    cardOpened = !cardOpened;
                }

                onClicked: {
                    if (cardOpened) { // if this card became opened
                        if (grid.lastOpenCard != null) { // if another card was opened before
                            if (src === grid.lastOpenCard.src) {  // and two these cards are equal
                                // bingo!
                                this.freeze(); // disable mouse clicking for this pair
                                grid.lastOpenCard.freeze();
                                grid.openCardsCount++;
                                grid.lastOpenCard = null // pair is closed or matched, start from the null again
                                scoreText.scorePoints += 100
                            } else { // they are not equal
                                closing_timer.currentCard = this;
                                closing_timer.start(); // show the cards for 2 sec and close both cards in timer
                                grid.openCardsCount -=2;
                            }
                        } else { // this is the first card for a pair match
                            grid.lastOpenCard = this;
                            grid.openCardsCount++;
                        }
                    } else { // card was closed
                        grid.openCardsCount--;
                        grid.lastOpenCard = null;
                    }
                }
            }

        }

        Component.onCompleted: {
            grid.openAllCards();
            preview_timer.start();
        }

        Text {
            id: scoreText

            property int scorePoints: 0

            anchors.left: parent.left
            anchors.leftMargin: 20
            color: 'brown'
            font.pixelSize: 32
            text: 'SCORE: ' + scorePoints
        }

        Text {
            id: timeText

            anchors.right: parent.right
            anchors.rightMargin: 20
            color: 'brown'
            font.pixelSize: 32
            text: '1:32'
        }

    }



}
