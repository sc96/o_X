//
//  OXGame.swift
//  o_X
//
//  Created by Sam on 6/29/16.
//  Copyright © 2016 iX. All rights reserved.
//

import Foundation


enum CellType : String {
    
    case O = "O"
    case X = "X"
    case Empty = ""
    
}

enum OXGameState : String {
    
    case InProgress = "InProgress"
    case Tie = "Tie"
    case Won = "Won"
    case Open = "Open"
    case Abandoned = "Abandoned"
}


class OXGame : NSObject {


    var board : [CellType] = [CellType.Empty, CellType.Empty, CellType.Empty,
                                       CellType.Empty, CellType.Empty, CellType.Empty,
                                       CellType.Empty, CellType.Empty, CellType.Empty]
    
    
    private var startType = CellType.X
    
    private var count : Int = 0
    var ID : Int = 0
    var host: String = ""
    

    
    
    override init()  {
        super.init()
        //we are simulating setting our board from the internet
        let simulatedBoardStringFromNetwork = "_________" //update this string to different values to test your model serialisation
        self.board = deserialiseBoard(simulatedBoardStringFromNetwork) //your OXGame board model should get set here
        if(simulatedBoardStringFromNetwork == serialiseBoard())    {
            print("start\n------------------------------------")
            print("congratulations, you successfully deserialised your board and serialized it again correctly. You can send your data model over the internet with this code. 1 step closer to network OX ;)")
            
            print("done\n------------------------------------")
        }   else    {
            print("start\n------------------------------------")
            print ("your board deserialisation and serialization was not correct :( carry on coding on those functions")
            
            print("done\n------------------------------------")
            
        }
        
        
        
    }
    
    
    func turnCount() -> Int {
        
        // removing count class variable and doing it the stupid way for some reason??
        
        var count = 0
        for cell in board {
            if (cell != CellType.Empty) {
                count += 1
            }
        }
        return count
        
    }
    
    func whoseTurn() -> CellType {
        
        if (self.turnCount() % 2 == 0) {
            
            return CellType.X
        }
        else {
            return CellType.O
        }
        
    }
    
    func playMove(cellNumber: Int) -> CellType {
        
        if (self.turnCount() % 2 == 0) {
            
            board[cellNumber-1] = CellType.X
            count += 1
            return CellType.X
            
            
        }
        
        else {
            board[cellNumber-1] = CellType.O
            count += 1
            return CellType.O
        }

        
        
    }
    
    func gameWon() -> Bool {
        
        
        if (board[0] != CellType.Empty) {
            
            if (board[0] == board[1] && board[1] == board[2]) {
                return true
            }
            if (board[0] == board[3] && board[3] == board[6]) {
                return true
            }
            if (board[0] == board[4] && board[4] == board[8]) {
                return true
            }
        
        }
        
        if (board[8] != CellType.Empty) {
            
            if (board[8] == board[5] && board[5] == board[2]) {
                return true
            }
            if (board[8] == board[7] && board[7] == board[6]) {
                return true
            }
            
        }
        
        
        if (board[4] != CellType.Empty) {
            
            if (board[4] == board[3] && board[3] == board[5]) {
                return true
            }
            if (board[4] == board[1] && board[1] == board[7]) {
                return true
            }
            if (board[4] == board[2] && board[2] == board[6]) {
                return true
            }
            
        }
        
        
        
        return false
    }
    
    func state() -> OXGameState {
        
        if (gameWon()) {
            return OXGameState.Won
        }
        else if (self.turnCount() == 9) {
            return OXGameState.Tie
            
        }
        else {
        return OXGameState.InProgress
        }
        
        
    }
    
    func reset() {
        
        board = [CellType.Empty, CellType.Empty, CellType.Empty,
                 CellType.Empty, CellType.Empty, CellType.Empty,
                 CellType.Empty, CellType.Empty, CellType.Empty]
        count = 0
        
        
        
    }
    
    private func serialiseBoard() -> String {
        
        var boardString :String = ""
        
        for cell in board {
            if (cell == CellType.Empty) {
                boardString = boardString + "_"
            }
            else if (cell == CellType.X) {
                boardString = boardString + "x"
            }
            else {
                boardString = boardString + "o"
            }
            
        }
        
        return boardString
        
    }
    
    private func deserialiseBoard(boardString: String) -> [CellType] {
        
        
        var board: [CellType] = []
        
        for c in boardString.characters {
            
            if (c == "x") {
                board.append(CellType.X)
            }
            
            else if (c == "o") {
                board.append(CellType.O)
            }
            else {
                board.append(CellType.Empty)
            }
            
            
        }
        
        return board
        
        
    }
    
  

    
    
    
}







