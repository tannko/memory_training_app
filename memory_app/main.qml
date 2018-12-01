import QtQuick 2.9
import QtQuick.Window 2.2
import Qt.labs.folderlistmodel 2.1

Window {
    visible: true
    width: 1024
    height: 768
    title: qsTr("Memory")

    QtObject {
        id: impl

        property real startTime: new Date().getTime()
        property int gridCellWidth: 150
        property int gridCellHeight: 190
        property int deckX: 500
        property int deckY: 500
        property int deckAnimationMoveDuration: 2000
        property int deckAnimationTurnoverDuration: 1500
        property int gridMargins: 150
        property int pairCount: 4
        property int openPairCount: 0

        function getIndexArray(count) {
            var i = 0, j = 0, array = [];
            for (i=0; i< count; i++) {
                for (j=0; j<2; j++)
                    array.push(i);
            }
            shuffle(array);
            return array;
        }

        //Fisher-Yates shuffling (modern)
        function shuffle(array) {
            var i = 0, j = 0, temp = null;

            for (i = array.length-1; i > 0; i-=1) {
                j = Math.floor(Math.random()*(i+1));
                temp = array[i]
                array[i] = array[j]
                array[j] = temp
            }
        }

        function animateToDeck(targets) {
            cardsToDeckAnim.targets = targets;
            if (cardsToDeckAnim.running)
                cardsToDeckAnim.complete();
            cardsToDeckAnim.start();
        }

    }

    ParallelAnimation {
       id: cardsToDeckAnim
       property var targets: []

       NumberAnimation {
            targets: cardsToDeckAnim.targets
            property: "x"
            to: impl.deckX
            duration: impl.deckAnimationMoveDuration
            //easing.type: Easing.InOutQuad
       }

       NumberAnimation {
            targets: cardsToDeckAnim.targets
            property: "y"
            to: impl.deckY
            duration: impl.deckAnimationMoveDuration
            //easing.type: Easing.InOutQuad
       }

       PropertyAnimation {
           targets: cardsToDeckAnim.targets
           property: "isSelected"
           to: "false"
           duration: impl.deckAnimationTurnoverDuration
       }

       PropertyAction {
           targets: cardsToDeckAnim.targets
           property: "mouseClickEnabled"
           value: "false"
       }

   }

    Image {
        id: card_table
        anchors.fill: parent
        source: 'img/table.png'

        Timer {
            id: preview_timer
            interval: 3000
            repeat: false
            onTriggered: {
                grid.allCardsOpen = false;
                impl.startTime = new Date().getTime();
                clock_timer.start();
            }
        }

        Timer {
            id: closing_timer
            interval: 500
            repeat: false

            onTriggered: {
                grid.currOpenCard.isSelected = false;
                grid.lastOpenCard.isSelected = false;
                grid.lastOpenCard = null // pair is closed or matched, start from the null again
            }
        }


        Timer {
            id: clock_timer
            interval: 1000
            repeat: true
            onTriggered: {
                // show current time
                var msec = new Date().getTime() - impl.startTime;
                var sec = Math.floor((msec/1000)%60);
                var min = Math.floor((msec/(1000*60))%60);
                timeText.text = min + ':' + (sec < 10 ? + '0': '') + sec;
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
            anchors.margins: impl.gridMargins
            model: impl.getIndexArray(impl.pairCount)

            cellWidth: impl.gridCellWidth
            cellHeight: impl.gridCellHeight

            //property int openCardsCount: 0
            property MemoryCard currOpenCard: null
            property MemoryCard lastOpenCard: null

            property bool allCardsOpen: false

            delegate: memoryCard

        }

        Component {
            id: memoryCard

            MemoryCard {
                cardOpened: grid.allCardsOpen || isSelected
                cardFreezed: grid.allCardsOpen || !mouseClickEnabled
                src: 'img/physics/physics_' + modelData + '.png'

                onClicked: {
                    isSelected = !isSelected;
                    if (cardOpened) { // if this card became opened
                        if (grid.lastOpenCard != null) { // if another card was opened before
                            if (src === grid.lastOpenCard.src) {  // and two these cards are equal
                                // bingo!
                                this.mouseClickEnabled = false;//this.freeze(); // disable mouse clicking for this pair
                                grid.lastOpenCard.mouseClickEnabled = false; //grid.lastOpenCard.freeze();

                                impl.animateToDeck([this, grid.lastOpenCard]);

                                //grid.openCardsCount++;
                                grid.lastOpenCard = null // pair is closed or matched, start from the null again
                                scoreText.scorePoints += 100

                                impl.openPairCount++;
                                if (impl.openPairCount == impl.pairCount)
                                    clock_timer.stop();
                            } else { // they are not equal
                                grid.currOpenCard = this;
                                closing_timer.start(); // show the cards for 2 sec and close both cards in timer
                                //grid.openCardsCount -= 2;
                            }
                        } else { // this is the first card for a pair match
                            grid.lastOpenCard = this;
                            //grid.openCardsCount++;
                        }
                    } else { // card was closed
                        //grid.openCardsCount--;
                        grid.lastOpenCard = null;
                    }
                }
            }

        }

        Component.onCompleted: {
            grid.allCardsOpen = true; //grid.openAllCards();
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
            text: '0:00'
        }

    }

}
