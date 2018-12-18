import QtQuick 2.0
import Qt.labs.folderlistmodel 2.1

Rectangle {
    id: root

    signal backClicked
    signal setChosen

    Button {
        id: nextSet
        anchors.bottom: setView.bottom
        anchors.left: setView.right
        text: "next"

        onClicked: {
            if (setView.currentIndex < setView.model-1)
                setView.currentIndex++;
            //setPageText.text = setView.currentIndex
        }
    }

    Button {
        id: prevSet
        anchors.bottom: setView.bottom
        anchors.right: setView.left
        text: "prev"

        onClicked: {
            if (setView.currentIndex > 0)
                setView.currentIndex--;
            //setPageText.text = setView.currentIndex
        }
    }

    Button {
        id: backToWelcome
        anchors.bottom: parent.bottom
        text: "back"
        onClicked:  {
            root.backClicked()
        }
    }



    Text {
        id: setPageText
        text: "Set Choose Page"
    }

    ListView {
        id: setView
        width: 140
        height: 140

        anchors.centerIn: parent
        //anchors.margins: 40
        model: 3 // TO CHANGE
        delegate: setDelegate
        clip: true
        focus: true
        currentIndex: 0
        orientation: ListView.Horizontal
    }

    FolderListModel {
        id: folderModel
        folder: 'img/set_logo'
        nameFilters: [ "*.png"]
    }

    Component {
        id: setDelegate

        MemorySet {
            width: 140
            height: 140
            src: "img/set_logo/set_" + modelData + ".png"

            onClicked: {
                root.setChosen()
            }
        }

    }

}
