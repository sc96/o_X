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
}


class OXGame {


    private  var board : [CellType] = [CellType.Empty, CellType.Empty, CellType.Empty,
                                       CellType.Empty, CellType.Empty, CellType.Empty,
                                       CellType.Empty, CellType.Empty, CellType.Empty]
    
    private var magicSquare: [Int] = [4, 9, 2, 3, 5, 7, 8, 1, 6]
    
    private var startType = CellType.X
    
    private var count : Int = 0
    private var xScore : Int = 0
    private var oScore : Int = 0
    
    
    func turnCount() -> Int {
        
        return count
        
    }
    
    func whoseTurn() -> CellType {
        
        if (count % 2 == 0) {
            
            return CellType.X
        }
        else {
            return CellType.O
        }
        
    }
    
    func playMove(cellNumber: Int) -> CellType {
        
        if (count % 2 == 0) {
            
            board[cellNumber] = CellType.X
            count += 1
            xScore += magicSquare[cellNumber]
            return CellType.X
            
        }
        
        else {
            board[cellNumber] = CellType.O
            count += 1
            xScore += magicSquare[cellNumber]
            return CellType.O
        }

        
        
    }
    
    func gameWon() -> Bool {
        
        if (xScore == 15 || oScore == 15) {
            return true
        }
        else {
            return false
        }
        
        
    }
    
    func state() -> OXGameState {
        
        if (gameWon()) {
            return OXGameState.Won
        }
        else if (count == 9) {
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
        xScore = 0
        oScore = 0
        
        
    }

    
    
    
}







