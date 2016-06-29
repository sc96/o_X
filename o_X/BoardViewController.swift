//
//  BoardViewController.swift
//  o_X
//

import UIKit

class BoardViewController: UIViewController {

    
    @IBOutlet weak var newGameButton: UIButton!
    @IBOutlet weak var logoutButton: UIButton!
    // Create additional IBOutlets here.
    @IBOutlet weak var boardView: UIView!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view, typically from a nib.
        
    }
    
    @IBAction func newGameButtonPressed(sender: UIButton) {
        print("New game button pressed.")
        restartGame()
    }
    
    @IBAction func logoutButtonpressed(sender: UIButton) {
        print("Logout button pressed")
    }
    

    
    @IBAction func cellButtonPressed(sender: UIButton) {
        
        
        sender.setTitle(OXGameController.sharedInstance.playMove(sender.tag).rawValue, forState: .Normal)
        sender.enabled = false
        
        let state :OXGameState = OXGameController.sharedInstance.getCurrentGame().state()
        
        if (state == OXGameState.Won) {
            
            if (OXGameController.sharedInstance.getCurrentGame().turnCount() % 2 == 1) {
                print("Congratulations, X player won")
                
            }
            else {
                print("Congratulations, O player won")
            }
            restartGame()
            
            
            
        }
            
        else if (state == OXGameState.Tie){
            print("You guys both suck. Game is tied")
            restartGame()
        }
        
        
    }
    
    func restartGame() {
        
        OXGameController.sharedInstance.restartGame()
        
        for view in boardView.subviews {
            if let button = view as? UIButton {
                button.setTitle("", forState: .Normal)
                button.enabled = true
            }

        }
        
        
        
        
    }
    
    
    // Create additional IBActions here.

}

