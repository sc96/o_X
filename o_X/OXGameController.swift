//
//  OXGameController.swift
//  o_X
//
//  Created by Sam on 6/29/16.
//  Copyright © 2016 iX. All rights reserved.
//

import Foundation
import UIKit


class OXGameController : WebService {
    
    private var currGame: OXGame = OXGame()
    

    
    static let sharedInstance = OXGameController()
    private override init() {}
    
    
    
    func getCurrentGame() -> OXGame {
        
        return currGame
    }
    
    func restartGame() {
        
        currGame.reset()
    }
    
    func playMove(cellNumber : Int) -> CellType {
        
        
        return currGame.playMove(cellNumber)
        
        
    }
    
    /*
    
    func getGames(onCompletion onCompletion: ([OXGame]?, String?) -> Void) {
        
        
        // WIP
        let gameArr : [OXGame] = [currGame, OXGame(), OXGame()]
        let message : String = ""
        onCompletion(gameArr, message)
        
    }
    
 */
    
    func getGames(onCompletion onCompletion: ([OXGame]?, String?) -> Void) {
        
        // is it kosher to unwrap all of these?
        let request = self.createMutableRequest(NSURL(string: "https://ox-backend.herokuapp.com/games"), method: "GET", parameters: nil)

        
        //execute request is a function we are able to call in UserController, because UserController extends WebService (See top of file, where UserController is defined)
        self.executeRequest(request, requestCompletionFunction: {(responseCode, json) in
            
            
            if (responseCode / 100 == 2)   {
                
                var gameList : [OXGame] = []
                
                for game in json.arrayValue {
                    let g = OXGame()
                    g.ID = game["id"].intValue
                    g.host = game["host_user"]["uid"].stringValue
                    gameList.append(g)
                }
                
                onCompletion(gameList, nil)
               
              
            }   else    {
                onCompletion(nil, json["errors"]["full_messages"][0].stringValue)
            }
            
        })

        
    }

    
    
    
    
}