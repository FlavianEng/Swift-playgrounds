/**
 Chutes and ladders
 
 The rules of the game are as follows:
 
 - The board has 25 squares, and the aim is to land on or beyond square 25.
 - The player’s starting square is “square zero”, which is just off the bottom-left corner of the board.
 - Each turn, you roll a six-sided dice and move by that number of squares, following the horizontal path indicated by the dotted arrow above.
 - The game contains 4 ladders and 4 snakes
 - If your turn ends at the bottom of a ladder, you move up that ladder.
 - If your turn ends at the head of a snake, you move down that snake.
 
 * Bonus *
 - Ladders and snakes numbers are dynamic with squares count. Cannot be below 1 each.
 - Ladders and snakes positions are randomized.
 - The aim is to land precisely on final square.
 
 * Bonus x2 *
 - Change final square value
 - Calculates and indicates best score
 
 Answer: https://docs.swift.org/swift-book/documentation/the-swift-programming-language/controlflow
 */

let finalSquare = 25
var board: [Int] = Array(repeating: 0, count: finalSquare + 1)

func start() -> Void {
    initGame()
    
    var score = 0
    var currentSquare: Int = 0
    
    repeat {
        let diceResult = Int.random(in: 1...6)
        
        currentSquare += diceResult
        score += 1
        
        if (currentSquare < board.count && board[currentSquare] > 0) {
            currentSquare = board[currentSquare]
        }
    } while currentSquare <= finalSquare
    
    print("You've done well with a score of \(score)")
}

func initGame() -> Void {
    setLadders()
    setSnakes()
}

func setLadders() -> Void {
    board[03] = 11
    board[06] = 17
    board[09] = 18
    board[10] = 12
}

func setSnakes() -> Void {
    board[14] = 4
    board[19] = 8
    board[22] = 20
    board[24] = 16
}

start()

