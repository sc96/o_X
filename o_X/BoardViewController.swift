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
    @IBOutlet weak var networkLabel: UILabel!
    // hardcoding this. ns about initial value
    var networkMode : Bool = false
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.updateUI()
        // Do any additional setup after loading the view, typically from a nib.
        
        if (networkMode == false) {
            newGameButton.hidden = true
        }
        
        
       
        
    }
    
    @IBAction func newGameButtonPressed(sender: UIButton) {
        
        if (networkMode == false) {
            print("New game button pressed.")
            newGameButton.hidden = true
            restartGame()
        }
    }
    
    @IBAction func logoutButtonpressed(sender: UIButton) {
        print("Logout button pressed")
        
        networkMode = false
        
        UserController.sharedInstance.logout(onCompletion: {
            message in
            
            if (message == nil) {
                
                OXGameController.sharedInstance.restartGame()
                let controller = UIStoryboard(name: "Onboarding", bundle: nil).instantiateInitialViewController()
                let window = UIApplication.sharedApplication().keyWindow
                window?.rootViewController = controller
                
            }
            else {
                
                print(message)
            }
        })
        
        
    }
    

    
    @IBAction func cellButtonPressed(sender: UIButton) {
        
        
        sender.setTitle(OXGameController.sharedInstance.playMove(sender.tag).rawValue, forState: .Normal)
        sender.enabled = false
        
        let state :OXGameState = OXGameController.sharedInstance.getCurrentGame().state()
        
        
        
        let unhideNewButton = { () in
            self.newGameButton.hidden = false }
        
        
        // janky stuff
        let doNothing = {() in
            return
        }
        
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
               
                
                let alert = UIAlertController(title: "Game over boi", message: "X won",
                                              preferredStyle: UIAlertControllerStyle.Alert)
                
                let alertAction = UIAlertAction(title: "Dismiss", style: .Cancel, handler: { (action) in
                    
                    if (self.networkMode == true) {
                        doNothing()
                    }
                    else {
                        unhideNewButton()
                    }
                })
                
                alert.addAction(alertAction)
                self.presentViewController(alert, animated: true, completion: nil)
                
            }
            else {
                
                let alert = UIAlertController(title: "Game over boi", message: "O won",
                                              preferredStyle: UIAlertControllerStyle.Alert)
                
                let alertAction = UIAlertAction(title: "Dismiss", style: .Cancel, handler: { (action) in
                    
                    if (self.networkMode == true) {
                        doNothing()
                    }
                    else {
                        unhideNewButton()
                    }
                })
                
                alert.addAction(alertAction)
                self.presentViewController(alert, animated: true, completion: nil)
            }
            
            
            
        }
            
        else if (state == OXGameState.Tie){
            
            
            let alert = UIAlertController(title: "Tie", message: "No one won",
                                          preferredStyle: UIAlertControllerStyle.Alert)
            
            let alertAction = UIAlertAction(title: "Dismiss", style: .Cancel, handler: { (action) in
                
                if (self.networkMode == true) {
                    doNothing()
                }
                else {
                    unhideNewButton()
                }
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
    
    
    /*
     * BoardViewController's updateUI() function
     * Although we haven't completed full network functionality yet,
     * this function will come in handy when we have to display our opponents moves
     * that we obtain from the networking layers (more on that later)
     * For now, you are required to implement this function in connection with Activity 1 from todays class
     * Hint number 1: This function must set the values of O and X on the board, based on the games board array values. Does this kind of remind you of the resetBoard or newGameTapped function???
     * Hint number 2: if you set your board array to private in the OXGame class, maybe you should set it now to 'not private' ;)
     * Hint number 3: call this function in BoardViewController's viewDidLoad function to see it execute what board was set in the game's initialiser on your screen!
     * And Go!
     */
    
    func updateUI() {
        
        
        var gameBoard = OXGameController.sharedInstance.getCurrentGame().board
        
        
        
        for view in boardView.subviews {
            if let button = view as? UIButton {
                let cellType = gameBoard[button.tag - 1]
                
                if (cellType == CellType.X) {
                    button.setTitle("X", forState: .Normal)
                    button.enabled = false
                }
                else if (cellType == CellType.O) {
                    button.setTitle("O", forState: .Normal)
                    button.enabled = false
                }
                else {
                    button.setTitle("", forState: .Normal)
                    button.enabled = true
                }
            }
        }
        
        
  
 
    }
 
}

