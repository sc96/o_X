//
//  OXGameController.swift
//  o_X
//
//  Created by Sam on 6/29/16.
//  Copyright © 2016 iX. All rights reserved.
//

import Foundation
import UIKit


class OXGameController {
    
    private var currGame: OXGame = OXGame()

    
    static let sharedInstance = OXGameController()
    private init() {}
    
    
    func getCurrentGame() -> OXGame {
        
        return currGame
    }
    
    func restartGame() {
        
        currGame = OXGame()
    }
    
    func playMove(cellNumber : Int) -> CellType {
        
        return currGame.playMove(cellNumber)
        
        
    }
    
    
    
    
}