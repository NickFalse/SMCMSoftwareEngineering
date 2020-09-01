import QtQuick 2.11
import QtQuick.Window 2.11

Window {
    visible: true
    width: 640
    height: 480
    title: qsTr("Tic-Tac-Toe")

    Rectangle {
        id: scoreRectangle
        x: 0
        y: 411
        width: 640
        height: 69
        color: "#6eceff"

        Text {
            id: p1Score
            x: 14
            y: 11
            color: "#ffffff"
            text: qsTr("Player 1: 0")
            font.bold: true
            font.family: "Segoe Print"
            font.pixelSize: 24
        }

        Text {
            id: p2Score
            x: 486
            y: 11
            color: "#ffffff"
            text: qsTr("Player 2: 0")
            font.bold: true
            font.family: "Segoe Print"
            font.pixelSize: 24
        }

    }

    Rectangle {
        id: rectangle1
        x: 170
        y: 155
        width: 300
        height: 3
        color: "#929191"
    }

    Rectangle {
        id: rectangle2
        x: 170
        y: 265
        width: 300
        height: 3
        color: "#929191"
    }

    Rectangle {
        id: rectangle3
        x: 265
        y: 60
        width: 3
        height: 300
        color: "#929191"
    }

    Rectangle {
        id: rectangle4
        x: 375
        y: 60
        width: 3
        height: 300
        color: "#929191"
    }

    Text {
        id: aboutButton
        x: 543
        y: -15
        color: "#41beff"
        text: qsTr("?")
        font.bold: true
        font.family: "Segoe Print"
        font.pixelSize: 54
    }

    Image {
        id: arrowLeft
        x: 9
        y: 8
        width: 52
        height: 42
        sourceSize.height: 0
        sourceSize.width: 0
        source: "arrow_left.png"

        MouseArea {
            id: arrowLeftMouseArea
            x: -4
            y: -8
            width: 60
            height: 60

            onClicked: {
                newGameMenu.visible = true;
            }
        }
    }

    Image {
        id: resetScores
        x: 585
        y: 12
        width: 43
        height: 45
        source: "reset_scores.png"
    }

    Rectangle {
        id: newGameMenu
        x: 0
        y: 0
        width: 214
        height: 480
        color: "#ff6c67"

        Rectangle {
            id: dropShadow
            x: 214
            y: 0
            width: 427
            height: 480
            color: "#99000000"
        }

        Text {
            id: newGameTitle
            x: 0
            y: 0
            width: 214
            height: 51
            color: "#ffffff"
            text: qsTr("New Game?")
            horizontalAlignment: Text.AlignHCenter
            font.bold: true
            font.family: "Segoe Print"
            font.pixelSize: 30
        }

        Text {
            id: player1InputName
            x: 15
            y: 78
            width: 191
            height: 30
            color: "#ffffff"
            text: qsTr("Player 1's Name")
            font.family: "Segoe Print"
            font.bold: true
            horizontalAlignment: Text.AlignLeft
            font.pixelSize: 18
        }

        Rectangle {
            id: player1InputBackdrop
            x: 15
            y: 108
            width: 183
            height: 40
            color: "#ffffff"
            border.color: "#ffaba7"
            border.width: 2
        }

        Text {
            id: player2InputName
            x: 15
            y: 173
            width: 191
            height: 30
            color: "#ffffff"
            text: qsTr("Player 2's Name")
            font.family: "Segoe Print"
            font.bold: true
            horizontalAlignment: Text.AlignLeft
            font.pixelSize: 18
        }

        TextInput {
            id: player1Input
            x: 21
            y: 123
            width: 171
            height: 20
            text: qsTr("Player 1")
            font.bold: true
            font.family: "Segoe Print"
            selectionColor: "#ffaba7"
            font.pixelSize: 18
        }


        Rectangle {
            id: player2InputBackdrop
            x: 15
            y: 203
            width: 183
            height: 40
            color: "#ffffff"
            border.width: 2
            border.color: "#ffaba7"
        }
        TextInput {
            id: player2Input
            x: 21
            y: 219
            width: 169
            height: 20
            text: qsTr("Player 2")
            font.family: "Segoe Print"
            font.bold: true
            selectionColor: "#ffaba7"
            font.pixelSize: 18
        }

        Image {
            id: arrowRight
            x: 58
            y: 392
            width: 140
            height: 70
            source: "arrow_right.png"
        }

        Text {
            id: goText
            x: 90
            y: 369
            width: 68
            height: 51
            color: "#ffffff"
            text: qsTr("Go!")
            font.family: "Segoe Print"
            font.bold: true
            horizontalAlignment: Text.AlignHCenter
            font.pixelSize: 34
        }

        MouseArea {
            id: goMouseArea
            x: 46
            y: 369
            width: 162
            height: 103

            onClicked: {
                newGameMenu.visible = false;
            }
        }


    }


}

/*##^## Designer {
    D{i:10;invisible:true}
}
 ##^##*/
