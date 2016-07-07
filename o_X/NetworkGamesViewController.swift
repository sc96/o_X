//
//  NetworkGamesViewController.swift
//  o_X
//
//  Created by Sam on 7/4/16.
//  Copyright © 2016 iX. All rights reserved.
//

import UIKit

class NetworkGamesViewController: UITableViewController {
    
    
    
    private var gameArr : [OXGame] = []
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        OXGameController.sharedInstance.getGameList(onCompletion: {
            gameArr, message in
            
            if let game = gameArr {
                self.gameArr = game
                self.tableView.reloadData()
            } else {
                // should be an alert?
                print(message)
            }
        })
        

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
    }

    @IBAction func backButton(sender: AnyObject) {
       
        // Gives me in an infinite UI loop if I set cancel game connected to nav controller
     //   self.dismissViewControllerAnimated(true, completion: nil)
    }
    // MARK: - Table view data source

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
        
        
        
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return gameArr.count
    }
    

    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        
        
        let cell = tableView.dequeueReusableCellWithIdentifier("first", forIndexPath: indexPath)
        
        cell.textLabel?.text = "Game \(gameArr[indexPath.row].ID) @ \(gameArr[indexPath.row].host)"
        return cell
    }
  
    
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
        
        OXGameController.sharedInstance.acceptGame(gameArr[indexPath.row].ID, onCompletion: { game, message in
            
            if (message == nil) {
                
                OXGameController.sharedInstance.restartGame()
                OXGameController.sharedInstance.getCurrentGame().ID = game!.ID
                OXGameController.sharedInstance.getCurrentGame().host = game!.host
                self.performSegueWithIdentifier("NGSJoin", sender: self)
            }
            else {
                	
                // should be an alert
                print(message)
            }
        })
    }
    
    
    @IBAction func addButton(sender: UIBarButtonItem) {
        
        
        
        OXGameController.sharedInstance.createNewGame(onCompletion: { game, message in
            
            if (message == nil) {
                
                OXGameController.sharedInstance.restartGame()
                OXGameController.sharedInstance.getCurrentGame().ID = game!.ID
                OXGameController.sharedInstance.getCurrentGame().host = game!.host
                
                
                
                
                
                print(OXGameController.sharedInstance.getCurrentGame().ID)
                
                self.gameArr.append(game!)
                self.tableView.reloadData()
                self.performSegueWithIdentifier("NGSHost", sender: self)
            }
            
            else {
                
                // alert
                print(message)
            }
            
        })
        
    }
    

    /*
    // Override to support conditional editing of the table view.
    override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == .Delete {
            // Delete the row from the data source
            tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
        } else if editingStyle == .Insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(tableView: UITableView, moveRowAtIndexPath fromIndexPath: NSIndexPath, toIndexPath: NSIndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(tableView: UITableView, canMoveRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        if segue.identifier == "NGSJoin" {
            if let vc = segue.destinationViewController as? BoardViewController {
                vc.networkMode = true
                vc.host = false
                    
                
                
            }
        }
        
        if segue.identifier == "NGSHost" {
            if let vc = segue.destinationViewController as? BoardViewController {
                vc.networkMode = true
                vc.host = true
                    
                
            }
        }
    }
    

}