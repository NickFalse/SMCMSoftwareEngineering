import QtQuick 2.11
import QtQuick.Window 2.11

Window {
    id: window
    visible: true
    width: 640
    height: 480
    title: qsTr("Tic-Tac-Toe")
    maximumWidth: 640
    maximumHeight: 480
    minimumWidth: 640
    minimumHeight: 480

    property int p1ScoreValue: 0
    property int p2ScoreValue: 0
    property var board: [["-1","-1","-1"],["-1","-1","-1"],["-1","-1","-1"]]
    property var lastMove: [-1, -1]
    property int turn: 1
    property int startedPrevGame: 1

    function checkBoard() {
        for(var i = 0; i < board.length; ++i)
        {
            if(board[i][0] === "-1")
                continue;
            if(board[i][0] === board[i][1] && board[i][1] === board[i][2])
                return board[i][0];
        }

        for(i = 0; i < board[0].length; ++i)
        {
            if(board[0][i] === "-1")
                continue;
            if(board[0][i] === board[1][i] && board[1][i] === board[2][i])
                return board[0][i];
        }

        if(board[0][0] !== "-1" && board[0][0] === board[1][1] && board[1][1] === board[2][2])
            return board[0][0];

        if(board[2][0] !== "-1" && board[2][0] === board[1][1] && board[1][1] === board[0][2])
            return board[2][0];

        for(i = 0; i < board.length; ++i)
        {
            for(var j = 0; j < board[i].length; ++j)
            {
                if(board[i][j] === "-1")
                    return false;
            }
        }

        return "C";
    }

    function clearBoard()
    {
        board = [["-1","-1","-1"],["-1","-1","-1"],["-1","-1","-1"]];
        boardChange();
        undoButton.enabled = false;
    }

    function undo()
    {
        board[lastMove[0]][lastMove[1]] = "-1";
        boardChange();
        undoButton.enabled = false;
        if(turn == 1)
            turn = 2;
        else
            turn = 1;
    }

    function resetScoreValues()
    {
        p1ScoreValue = 0;
        p2ScoreValue = 0;
        initNames(player1Input.text, player2Input.text)
    }

    function initNames(p1Name, p2Name)
    {
        p1Score.text = p1Name + ": " + p1ScoreValue;
        p2Score.text = p2Name + ": " + p2ScoreValue;
    }

    function boardChange() {
        for(var i = 0; i < board.length; ++i)
        {
            for(var j = 0; j < board[i].length; ++j)
            {
                if(board[i][j] === "-1")
                    ticTacToeBoardImages.children[i * board.length + j].source = "";
                else if(board[i][j] === "O")
                    ticTacToeBoardImages.children[i * board.length + j].source = "o.png";
                else if(board[i][j] === "X")
                    ticTacToeBoardImages.children[i * board.length + j].source = "x.png";
            }
        }

        var winningPlayer = checkBoard();
        if(winningPlayer !== false)
        {
            endGameMenu.visible = true;
            dropShadow.visible = true;
        }

        if(winningPlayer === "X")
        {
            responseText.text = player1Input.text + " Wins!";
            //displayResponseText.restart();
            p1ScoreValue++;
            turn = 2;
            startedPrevGame = turn;
            //clearBoard();
            initNames(player1Input.text, player2Input.text);
        }
        else if(winningPlayer === "O")
        {
            responseText.text = player2Input.text + " Wins!";
            //displayResponseText.restart();
            p2ScoreValue++;
            turn = 1;
            startedPrevGame = turn;
            //clearBoard();
            initNames(player1Input.text, player2Input.text);
        }
        else if(winningPlayer === "C")
        {
            responseText.text = "Cats Game!";
            //displayResponseText.restart();
            if(startedPrevGame === 1)
                turn = 2;
            else
                turn = 1;
            startedPrevGame = turn;
            //clearBoard();
        }
    }

    function turnChange() {
        if(turn === 1)
        {
            p1Score.color = "#ffee9e";
            p2Score.color = "#ffffff";
        }
        else if(turn === 2)
        {
            p2Score.color = "#ffee9e";
            p1Score.color = "#ffffff";
        }
    }

    onTurnChanged: {
        turnChange();
    }

    Component.onCompleted: {
        turnChange();
    }


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
            width: 312
            height: 43
            color: "#ffffff"
            text: qsTr("Player 1: 0")
            font.bold: true
            font.family: "Segoe Print"
            font.pixelSize: 24
        }

        Text {
            id: p2Score
            x: 326
            y: 11
            width: 297
            height: 43
            color: "#ffffff"
            text: qsTr("Player 2: 0")
            horizontalAlignment: Text.AlignRight
            font.bold: true
            font.family: "Segoe Print"
            font.pixelSize: 24
        }

    }

    Item {
        id: ticTacToeBoard

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

        Item {
            id: ticTacToeBoardImages

            function cellClicked(row, col)
            {
                if(board[row][col] !== "-1")
                    return;

                if(turn === 1)
                {
                    board[row][col] = "X";
                    turn = 2;
                }
                else if(turn === 2)
                {
                    board[row][col] = "O";
                    turn = 1;
                }

                lastMove = [row, col];
                undoButton.enabled = true;

                boardChange();
            }

            Image {
                id: topLeftImage
                x: 175
                y: 65
                width: 80
                height: 80
                source: ""

                MouseArea {
                    id: mouseArea2
                    x: -10
                    y: -10
                    width: 100
                    height: 100
                    onClicked: ticTacToeBoardImages.cellClicked(0, 0)
                }
            }

            Image {
                id: topMiddleImage
                x: 281
                y: 65
                width: 80
                height: 80
                source: ""

                MouseArea {
                    id: mouseArea1
                    x: -10
                    y: -10
                    width: 100
                    height: 100
                    onClicked: ticTacToeBoardImages.cellClicked(0, 1)
                }
            }

            Image {
                id: topRightImage
                x: 388
                y: 65
                width: 80
                height: 80
                source: ""

                MouseArea {
                    id: mouseArea
                    x: -10
                    y: -10
                    width: 100
                    height: 100
                    onClicked: ticTacToeBoardImages.cellClicked(0, 2)
                }
            }

            Image {
                id: middleLeftImage
                x: 175
                y: 172
                width: 80
                height: 80
                source: ""

                MouseArea {
                    id: mouseArea8
                    x: -10
                    y: -10
                    width: 100
                    height: 100
                    onClicked: ticTacToeBoardImages.cellClicked(1, 0)
                }
            }

            Image {
                id: middleMiddleImage
                x: 281
                y: 172
                width: 80
                height: 80
                source: ""

                MouseArea {
                    id: mouseArea7
                    x: -10
                    y: -10
                    width: 100
                    height: 100
                    onClicked: ticTacToeBoardImages.cellClicked(1, 1)
                }
            }

            Image {
                id: middleRightImage
                x: 388
                y: 172
                width: 80
                height: 80
                source: ""

                MouseArea {
                    id: mouseArea6
                    x: -10
                    y: -10
                    width: 100
                    height: 100
                    onClicked: ticTacToeBoardImages.cellClicked(1, 2)
                }
            }

            Image {
                id: bottomLeftImage
                x: 175
                y: 278
                width: 80
                height: 80
                source: ""

                MouseArea {
                    id: mouseArea5
                    x: -10
                    y: -10
                    width: 100
                    height: 100
                    onClicked: ticTacToeBoardImages.cellClicked(2, 0)
                }
            }

            Image {
                id: bottomMiddleImage
                x: 281
                y: 278
                width: 80
                height: 80
                source: ""

                MouseArea {
                    id: mouseArea4
                    x: -10
                    y: -10
                    width: 100
                    height: 100
                    onClicked: ticTacToeBoardImages.cellClicked(2, 1)
                }
            }

            Image {
                id: bottomRightImage
                x: 388
                y: 278
                width: 80
                height: 80
                source: ""

                MouseArea {
                    id: mouseArea3
                    x: -10
                    y: -10
                    width: 100
                    height: 100
                    onClicked: ticTacToeBoardImages.cellClicked(2, 2)
                }
            }
        }
    }

    Text {
        id: aboutButton
        x: 538
        y: -15
        color: "#41beff"
        text: qsTr("?")
        font.bold: true
        font.family: "Segoe Print"
        font.pixelSize: 54

        MouseArea {
            id: aboutMouseArea
            x: -8
            y: 27
            width: 43
            height: 45
            hoverEnabled: true

            onClicked: {
                aboutMenu.visible = true;
                dropShadow.visible = true;
            }

            onEntered: {
                aboutButton.opacity = 0.8;
                cursorShape = Qt.PointingHandCursor;
            }

            onExited: {
                aboutButton.opacity = 1.0;
                cursorShape = Qt.ArrowCursor;
            }
        }
    }

    Image {
        id: arrowLeft
        x: 12
        y: 12
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
            hoverEnabled: true

            onClicked: {
                newGameMenu.visible = true;
            }

            onEntered: {
                arrowLeft.opacity = 0.8;
                cursorShape = Qt.PointingHandCursor;
            }

            onExited: {
                arrowLeft.opacity = 1.0;
                cursorShape = Qt.ArrowCursor;
            }
        }
    }

    Image {
        id: undoButton
        x: 585
        y: 12
        width: 43
        height: 45
        source: "reset_scores.png"
        opacity: 0.3;

        property bool enabled: false;

        onEnabledChanged: {
            if(enabled)
            {
                opacity = 1.0;
            }
            else
            {
                opacity = 0.3;
            }
        }

        MouseArea {
            id: undoMouseArea
            x: -7
            y: -6
            width: 56
            height: 58
            hoverEnabled: true

            onClicked: {
                if(undoButton.enabled)
                {
                    undo();
                }
            }

            onEntered: {
                if(undoButton.enabled)
                {
                    undoButton.opacity = 0.8;
                    cursorShape = Qt.PointingHandCursor;
                }
            }

            onExited: {
                if(undoButton.enabled)
                {
                    undoButton.opacity = 1.0;
                    cursorShape = Qt.ArrowCursor;
                }
            }
        }
    }

    Rectangle {
        id: dropShadow
        x: 0
        y: 0
        width: 640
        height: 480
        color: "#99000000"

        MouseArea {
            anchors.fill: parent
            hoverEnabled: true
        }
    }



    Item {
        id: endGameMenu
        x: 0
        y: 0
        width: 640
        height: 480
        visible: false

        Text {
            id: responseText
            y: 80
            color: "#ffffff"
            text: ""
            anchors.horizontalCenter: parent.horizontalCenter
            horizontalAlignment: Text.AlignHCenter
            verticalAlignment: Text.AlignVCenter
            font.pixelSize: 50
            font.bold: true
            font.family: "Segoe Print"

            //        SequentialAnimation {
            //            id: displayResponseText

            //            PropertyAnimation {
            //                target: responseText
            //                property: "opacity"
            //                to: 1.0
            //                duration: 100
            //            }
            //            PauseAnimation {
            //                duration: 1000
            //            }
            //            PropertyAnimation {
            //                target: responseText
            //                property: "opacity"
            //                to: 0.0
            //                duration: 200
            //            }
            //        }
        }

        Rectangle {
            id: playAgainButton
            x: 185
            y: 180
            width: 270
            height: 70
            color: "#75d0ff"
            radius: 20
            border.width: 10
            border.color: "#41beff"

            Text {
                id: playAgainText
                x: 120
                y: 0
                width: 22
                height: 11
                color: "#ffffff"
                text: qsTr("Play Again")
                font.bold: true
                font.family: "Segoe Print"
                horizontalAlignment: Text.AlignHCenter
                font.pixelSize: 35
            }

            MouseArea {
                anchors.fill: parent
                hoverEnabled: true

                onClicked: {
                    endGameMenu.visible = false;
                    dropShadow.visible = false;
                    clearBoard();
                }

                onEntered: {
                    playAgainButton.opacity = 0.8;
                    cursorShape = Qt.PointingHandCursor;
                }

                onExited: {
                    playAgainButton.opacity = 1.0;
                    cursorShape = Qt.ArrowCursor;
                }
            }
        }

        Rectangle {
            id: quitButton
            x: 185
            y: 270
            width: 270
            height: 70
            color: "#ff847e"
            radius: 20
            border.color: "#ff554c"
            border.width: 10
            Text {
                id: quitText
                x: 120
                y: 0
                width: 22
                height: 11
                color: "#ffffff"
                text: qsTr("Quit")
                font.pixelSize: 35
                font.bold: true
                horizontalAlignment: Text.AlignHCenter
                font.family: "Segoe Print"
            }

            MouseArea {
                anchors.fill: parent
                hoverEnabled: true

                onClicked: {
                    close();
                }

                onEntered: {
                    quitButton.opacity = 0.8;
                    cursorShape = Qt.PointingHandCursor;
                }

                onExited: {
                    quitButton.opacity = 1.0;
                    cursorShape = Qt.ArrowCursor;
                }
            }
        }
    }

    Rectangle {
        id: newGameMenu
        x: 0
        y: 0
        width: 214
        height: 480
        color: "#ff6c67"

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
            radius: 0
            border.color: "#ffaba7"
            border.width: 2
            clip: true

            TextInput {
                id: player1Input
                x: 8
                y: 16
                width: 171
                height: 20
                text: qsTr("Player 1")
                font.bold: true
                font.family: "Segoe Print"
                selectionColor: "#ffaba7"
                font.pixelSize: 18
                maximumLength: 18
            }
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

        Rectangle {
            id: player2InputBackdrop
            x: 15
            y: 203
            width: 183
            height: 40
            color: "#ffffff"
            border.width: 2
            border.color: "#ffaba7"
            clip: true

            TextInput {
                id: player2Input
                x: 7
                y: 16
                width: 169
                height: 20
                text: qsTr("Player 2")
                font.family: "Segoe Print"
                font.bold: true
                selectionColor: "#ffaba7"
                font.pixelSize: 18
                maximumLength: 18
            }
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
            hoverEnabled: true

            onClicked: {
                newGameMenu.visible = false;
                dropShadow.visible = false;
                initNames(player1Input.text, player2Input.text);
                turn = 1;
                resetScoreValues();
                clearBoard();
                startedPrevGame = turn;
            }

            onEntered: {
                arrowRight.opacity = 0.8;
                goText.opacity = 0.8;
                cursorShape = Qt.PointingHandCursor;
            }

            onExited: {
                arrowRight.opacity = 1.0;
                goText.opacity = 1.0;
                cursorShape = Qt.ArrowCursor;
            }
        }
    }


    Item {
        id: aboutMenu
        visible: false;

        MouseArea {
            width: 640
            height: 480

            onClicked: {
                aboutMenu.visible = false;
                dropShadow.visible = false;
            }
        }

        Rectangle {
            id: aboutBox
            x: 132
            y: 97
            width: 400
            height: 300
            color: "#ffffff"
            radius: 15
            border.width: 6
            border.color: "#41beff"

            Text {
                id: aboutDescription
                x: 33
                y: 45
                text: qsTr("Software Name: Tic-Tac-Toe\nVersion Number: 1.0\n\nDevelopers:\nNicholas True - Team Lead\nChristian Oliverio - Documentation Lead\nChristopher Beatrez - Software Engineer\nLucius Latham - Software Engineer")
                font.bold: true
                font.family: "Segoe Print"
                font.pixelSize: 16
            }

            Rectangle {
                id: aboutTitleBox
                x: 75
                y: -30
                width: 250
                height: 60
                color: "#75d0ff"
                radius: 15
                border.width: 6
                border.color: "#41beff"

                MouseArea {
                    anchors.fill: parent
                }
            }

            Text {
                id: aboutTitle
                x: 175
                y: -24
                color: "#ffffff"
                text: qsTr("About")
                anchors.horizontalCenterOffset: 0
                anchors.horizontalCenter: parent.horizontalCenter
                font.bold: true
                font.family: "Segoe Print"
                font.pixelSize: 27
            }

            MouseArea {
                anchors.fill: parent
            }
        }
    }
}

/*##^## Designer {
    D{i:39;invisible:true}
}
 ##^##*/
