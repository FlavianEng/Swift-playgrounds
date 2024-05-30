/**
 Chutes and ladders
 
 The rules of the game are as follows:
 
 - [x] The board has 25 squares, and the aim is to land on or beyond square 25.
 - [x] The player’s starting square is “square zero”, which is just off the bottom-left corner of the board.
 - [x] Each turn, you roll a six-sided dice and move by that number of squares, following the horizontal path indicated by the dotted arrow above.
 - [x] The game contains 4 ladders and 4 snakes
 - [x] If your turn ends at the bottom of a ladder, you move up that ladder.
 - [x] If your turn ends at the head of a snake, you move down that snake.
 
 * Bonus *
 - [x] Ladders and snakes numbers are dynamic with squares count. Cannot be below 1 each.
 - [x] Ladders and snakes positions are randomized.
 - [x] The aim is to land precisely on final square.
 
 * Bonus x2 *
 - [x] Change final square value
 
 Answer: https://docs.swift.org/swift-book/documentation/the-swift-programming-language/controlflow
 */

let finalSquare = 25
var board: [Int] = Array(repeating: 0, count: finalSquare + 1)

func start() {
    initGame(finalSquare: finalSquare)
    
    board
    
    var score = 0
    var currentSquare: Int = 0
    
    repeat {
        let diceResult = Int.random(in: 1...6)
        
        currentSquare += diceResult
        score += 1
        
        if currentSquare < finalSquare && board[currentSquare] > 0 {
            currentSquare = board[currentSquare]
        }
        
        if currentSquare > finalSquare {
            let squaresOverFinalSquare =  currentSquare - finalSquare
            currentSquare = finalSquare - squaresOverFinalSquare
        }
    
    } while currentSquare != finalSquare
    
    print("You've done well with a score of \(score)")
}

func initGame(finalSquare: Int) {
    setLadders(finalSquare: finalSquare)
    setSnakes(finalSquare: finalSquare)
}

func setLadders(finalSquare: Int) {
    let laddersCount = Int(finalSquare / 6)
    let maxLadderLength = Int(Double(finalSquare) * (30/100))
    let maxLadderPosition = Int(Double(finalSquare) * (70/100)) - maxLadderLength
    
    var ladderPositions: Set<Int> = []
    
    while ladderPositions.count < laddersCount {
        ladderPositions.insert(Int.random(in: 1...maxLadderPosition))
    }
    
    for ladderPosition in ladderPositions {
        board[ladderPosition] = ladderPosition + Int.random(in: 1...maxLadderLength)
    }
}

func setSnakes(finalSquare: Int) {
    let snakesCount = Int(finalSquare / 6)
    let maxSnakeLength = Int(Double(finalSquare) * (40/100))
    let minSnakePosition = Int(Double(finalSquare) * (10/100)) + maxSnakeLength
    
    var snakePositions: Set<Int> = []
    
    while snakePositions.count < snakesCount {
        snakePositions.insert(Int.random(in: minSnakePosition...(finalSquare-1)))
    }
    
    var snakePlaced = 0
    while snakePlaced < snakesCount {
        let snakeHeadPosition = Int.random(in: minSnakePosition...finalSquare-1)
        let snakeTailPosition = snakeHeadPosition - Int.random(in: 1...maxSnakeLength)
        
        if board[snakeHeadPosition] != 0 {
            continue
        }
        
        board[snakeHeadPosition] = snakeTailPosition
        snakePlaced += 1
    }
}

start()
