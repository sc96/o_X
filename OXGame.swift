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
        
        
        
    }

    
    
    
}







