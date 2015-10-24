//Snake & ladder

import UIKit

class Player {
    var name: String
    var playerPosition: Int
    
    init(name: String) {
        self.name = name
        self.playerPosition = 0
    }
    
    func move(gameBoard: Board){
        var nextPosition: Int = 0
        let dieValue: Int = Die().roll()

            let rolledPosition: Int = self.playerPosition + dieValue
            print("Rolled Die Value: \(dieValue)")
        
            // If player hits 100, then we got a winner!
            if (rolledPosition >= gameBoard.finalSquareIndex) {
                nextPosition = gameBoard.finalSquare
            } else {
                // Move up or down by n spaces if needed
                let snakeLadderValue: Int = gameBoard.board[rolledPosition]
                if (snakeLadderValue > 1) {
                    print("Wohoo! There is a ladder, you are moving up by \(snakeLadderValue)")
                }else if(snakeLadderValue < -1){
                    print("Opsie! You hit a snake, you are dropping by \(snakeLadderValue)")
                }else{
                    print("Moving Forward!")
                }
                nextPosition = rolledPosition + snakeLadderValue
            }
        
        self.playerPosition = nextPosition
    }
}

class Die {
    func roll() -> Int {
        return Int(arc4random_uniform(6)) + 1
    }
}

class Snake {
    var length: Int
    
    init(length: Int){
        self.length = length
    }
}

class Ladder {
    var length: Int
    
    init(length: Int){
        self.length = length
    }
}

class Board {
    var board = [Int]()
    let finalSquareIndex: Int = 99
    let finalSquare: Int = 100
    
    func setup() {
        
        board = [Int](count: finalSquare, repeatedValue: 0)
        
        board[03] = Ladder(length: 08).length
        board[06] = Ladder(length: 11).length
        board[09] = Ladder(length: 09).length
        board[10] = Ladder(length: 02).length
        board[14] = Snake(length: -10).length
        board[19] = Snake(length: -11).length
        board[22] = Snake(length: -02).length
        board[24] = Snake(length: -08).length
        board[25] = Ladder(length: 08).length
        board[30] = Ladder(length: 11).length
        board[38] = Ladder(length: 09).length
        board[50] = Ladder(length: 02).length
        board[32] = Snake(length: -10).length
        board[40] = Snake(length: -11).length
        board[49] = Snake(length: -02).length
        board[60] = Snake(length: -08).length
        board[63] = Ladder(length: 08).length
        board[67] = Ladder(length: 11).length
        board[70] = Ladder(length: 09).length
        board[99] = Snake(length: -03).length
        board[73] = Snake(length: -10).length
        board[80] = Snake(length: -11).length
        board[89] = Snake(length: -02).length
        board[95] = Snake(length: -08).length
    }

}

class Game {
    
    var players: [Player] = [Player(name: "a"),Player(name: "b"),Player(name: "c"), Player(name: "d"), Player(name: "e")]
    let finalSquare: Int = 100
    
    func checkWinner(player: Player) -> Bool {
        return player.playerPosition == finalSquare
    }
    
    func printStep(player: Player) {
        print("New Location: \(player.playerPosition)")
    }

    func main() {
        let gameBoard: Board = Board()
        
        gameBoard.setup()
        
        print("======================")
        print("Let's Start")
        
        var hasWinner: Bool = false
        
        while !hasWinner {
            for player in players{
                print("                        ")
                print("======================")
                print("\(player.name)'s Turn!")
                print("======================")
                print("                        ")
                player.move(gameBoard)
                printStep(player)
                
                if checkWinner(player) {
                    hasWinner = true
                    print("                        ")
                    print("**************************")
                    print("We have a winner", player.name)
                    print("**************************")
                }
            }
        }

    }
    
}

Game().main()
