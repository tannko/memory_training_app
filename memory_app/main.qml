import QtQuick 2.9
import QtQuick.Window 2.2
import QtQuick.Controls 1.4

Window {
    visible: true
    width: 1024
    height: 768
    title: qsTr("Memory")

    Component {
        id: welcomePage

        WelcomePage {
            objectName: "welcomePage"

            onStartClicked: {
                stackView.push(setChoosePage)
            }

            onSettingsClicked: {
                stackView.push(settingsPage)
            }
        }
    }

    Component {
        id: setChoosePage

        SetChoosePage {
            objectName: "setChoosePage"

            onBackClicked: {
                stackView.pop()
            }

            onSetChosen: {
                stackView.push(levelChoosePage)
            }
        }
    }

    Component {
        id: settingsPage

        SettingsPage {
            objectName: "settingsPage"

            onBackClicked: {
                stackView.pop()
            }
        }
    }

    Component {
        id: levelChoosePage

        LevelChoosePage {
            objectName: "levelChoosePage"

            onBackClicked: {
                stackView.pop()
            }

            onLevelClicked: {
                stackView.push(gamePage)
            }
        }
    }

    Component {
        id: gamePage

        GamePage {
            objectName: "gamePage"

            onPauseClicked: {
                stackView.push(pauseWindow)
            }
            onGameFinished: {
                stackView.push(resultsPage)
            }
        }
    }

    Component {
        id: pauseWindow

        PauseWindow {
            objectName: "pauseWindow"

            onContinueClicked: {
                stackView.pop()
            }
            onStartAgainClicked: {
                stackView.pop()
                stackView.push({item: gamePage, replace: true})
            }
            onBackClicked: {
                stackView.popTo("levelChoosePage")
            }
        }
    }

    Component {
        id: resultsPage

        ResultsPage {
            objectName: "resultsPage"

            onBackToMenuClicked: {
                stackView.popTo("levelChoosePage")
            }

            onStartAgainClicked: {
                stackView.pop()
                stackView.push({item: gamePage, replace: true})
            }

            onNextLevelClicked: {
                //TO DO
                //stackView.push()
            }
        }
    }

    StackView {
        id: stackView
        anchors.fill: parent
        initialItem: welcomePage

        function popTo(itemName) {
           var item =  stackView.find(function(item) {
                return item.objectName === itemName
            })
           return stackView.pop(item)
        }

    }







}
