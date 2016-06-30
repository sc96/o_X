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
        newGameButton.hidden = true
        
    }
    
    @IBAction func newGameButtonPressed(sender: UIButton) {
        print("New game button pressed.")
        newGameButton.hidden = true
        restartGame()
    }
    
    @IBAction func logoutButtonpressed(sender: UIButton) {
        print("Logout button pressed")
        
        OXGameController.sharedInstance.restartGame()
        let controller = UIStoryboard(name: "Onboarding", bundle: nil).instantiateInitialViewController()
        let window = UIApplication.sharedApplication().keyWindow
        window?.rootViewController = controller
    }
    

    
    @IBAction func cellButtonPressed(sender: UIButton) {
        
        
        sender.setTitle(OXGameController.sharedInstance.playMove(sender.tag).rawValue, forState: .Normal)
        sender.enabled = false
        
        let state :OXGameState = OXGameController.sharedInstance.getCurrentGame().state()
        
        let unhideNewButton = { () in
            self.newGameButton.hidden = false }
        
        if (state == OXGameState.Won) {
            
            // making sure you can't press buttons after you win
            for view in boardView.subviews {
                if let button = view as? UIButton {
                    if (button.enabled == true) {
                        button.enabled = false
                    }
                   
                }
                
            }

            
            
            
            if (OXGameController.sharedInstance.getCurrentGame().turnCount() % 2 == 1) {
               
                print(state.rawValue)
                let alert = UIAlertController(title: "Game over boi", message: "X won",
                                              preferredStyle: UIAlertControllerStyle.Alert)
                
                let alertAction = UIAlertAction(title: "Dismiss", style: .Cancel, handler: { (action) in
                    unhideNewButton()
                    
                })
                
                alert.addAction(alertAction)
                self.presentViewController(alert, animated: true, completion: nil)
                
            }
            else {
                
                let alert = UIAlertController(title: "Game over boi", message: "O won",
                                              preferredStyle: UIAlertControllerStyle.Alert)
                
                let alertAction = UIAlertAction(title: "Dismiss", style: .Cancel, handler: { (action) in
                    unhideNewButton()
                    
                })
                
                alert.addAction(alertAction)
                self.presentViewController(alert, animated: true, completion: nil)
            }
            
            
            
        }
            
        else if (state == OXGameState.Tie){
            print("You guys both suck. Game is tied")
            let alert = UIAlertController(title: "Tie", message: "No one won",
                                          preferredStyle: UIAlertControllerStyle.Alert)
            
            let alertAction = UIAlertAction(title: "Dismiss", style: .Cancel, handler: { (action) in
                unhideNewButton()
                
            })
            
            alert.addAction(alertAction)
            self.presentViewController(alert, animated: true, completion: nil)

            
            // restartGame()
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

