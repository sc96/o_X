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
    
    func getGameList(onCompletion onCompletion: ([OXGame]?, String?) -> Void) {
        
        // is it kosher to unwrap all of these?
        let request = self.createMutableRequest(NSURL(string: "https://ox-backend.herokuapp.com/games"), method: "GET", parameters: nil)
        
        
        //execute request is a function we are able to call in UserController, because UserController extends WebService (See top of file, where UserController is defined)
        self.executeRequest(request, requestCompletionFunction: {(responseCode, json) in
            
            
            if (responseCode / 100 == 2)   {
                
                print(json)
                var gameList : [OXGame] = []
                
                for game in json.arrayValue {
                    let g = OXGame()
                    g.ID = game["id"].intValue
                    g.host = game["host_user"]["uid"].stringValue
                    gameList.append(g)
                }
                
                onCompletion(gameList, nil)
                
                
            }   else    {
                // onCompletion(nil, json["errors"]["full_messages"][0].stringValue)
                onCompletion(nil, "error on getting game list")
            }
            
        })
        
        
    }
    
    // ns if this works and if the paremters are right
    func acceptGame(game_id : Int, onCompletion: (OXGame?, String?) -> Void) {
        
        let request = self.createMutableRequest(NSURL(string: "https://ox-backend.herokuapp.com/games/\(game_id)/join"), method: "GET", parameters: nil)
        
        
        self.executeRequest(request, requestCompletionFunction: {(responseCode, json) in
            
            
            if (responseCode / 100 == 2)   {
                
                
                let g = OXGame()
                g.ID = json["id"].intValue
                g.host = json["host_user"]["uid"].stringValue
                
                
                onCompletion(g, nil)
                
                
            }   else    {
               // onCompletion(nil, json["errors"]["full_messages"][0].stringValue)
                onCompletion(nil, "error on accepting game")
            }
            
        })
        
        
        
        
        
        
    }
    
    func cancelGame(game_id : Int, onCompletion: (OXGame?, String?) -> Void) {
        
        let request = self.createMutableRequest(NSURL(string: "https://ox-backend.herokuapp.com/games/\(game_id)"), method: "DELETE", parameters: nil)
        
        self.executeRequest(request, requestCompletionFunction: {(responseCode, json) in
            
            if (responseCode / 100 == 2) {
                
                let g = OXGame()
                g.ID = json["id"].intValue
                g.host = json["host_user"]["uid"].stringValue
                
                onCompletion(g, nil)
            }
            else {
                //onCompletion(nil, json["errors"]["full_messages"][0].stringValue)
                onCompletion(nil, "error on cancelling game")
            }
            
            
        })
        
    }
    
    func playMove(game_id: Int, board: String, onCompletion: (String?, String?) -> Void) {
        
        let boardString = ["board" : board]
        
        let request = self.createMutableRequest(NSURL(string: "https://ox-backend.herokuapp.com/games/\(game_id)"), method: "PUT",
                                                parameters: boardString)
        
        
        print(board)
        
        self.executeRequest(request, requestCompletionFunction: {(responseCode, json) in
         
            if (responseCode / 100 == 2) {
                
                let updatedString = json["board"].stringValue
                
                onCompletion(updatedString, nil)
            }

                else {  onCompletion(nil, "error on playing move")
               
                    // onCompletion(nil, json["errors"]["full_messages"][0].stringValue)
            
                }
            
            })
    }
    

    
        
    
    
    // ns if this works and if parameters are correct
    func createNewGame(onCompletion onCompletion: (OXGame?, String?) -> Void) {
        
        let request = self.createMutableRequest(NSURL(string: "https://ox-backend.herokuapp.com/games/"), method: "POST", parameters: nil)
        
        
        self.executeRequest(request, requestCompletionFunction: {(responseCode, json) in
            
            if (responseCode/100 == 2) {
                
                let g = OXGame()
                g.ID = json["id"].intValue
                g.host = json["host_user"]["uid"].stringValue
                
                
                onCompletion(g, nil)
            }
                
            else {
                onCompletion(nil, "error dude on creating new game")
            }
            
        })
        
    }
    
    func getGame(game_id : Int, onCompletion: (String?, String?, String?) -> Void) {
        
        let request = self.createMutableRequest(NSURL(string: "https://ox-backend.herokuapp.com/games/\(game_id)"), method: "GET",
                                                parameters: nil)
        
        self.executeRequest(request, requestCompletionFunction: {(responseCode, json) in
            
            if (responseCode / 100 == 2) {
                
                let stateString = json["state"].stringValue
                let boardString = json["board"].stringValue
                onCompletion(boardString, stateString, nil)
                
            }
                
            else {
                
                onCompletion(nil, nil,  "error dude on getting game")
                
            }
            
            
        })
    }
}