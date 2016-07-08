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
    var host : Bool = false
    @IBOutlet weak var CancelGameBUtton: UIButton!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        // Do any additional setup after loading the view, typically from a nib.
        
        if (networkMode == false) {
            newGameButton.hidden = true
   
        }
        else {
            self.navigationController?.setNavigationBarHidden(true, animated: true)
            self.restartGame()
            for view in self.boardView.subviews {
                let button = view as? UIButton
                button?.enabled = false
            }
            if (host == true) {
                networkLabel.text = "Waiting for someone to join"
                
              
            }
            else {
                networkLabel.text = "Your opponent's turn"
            }
            
        
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
    

    @IBAction func cancelGameButtonPressed(sender: UIButton) {
        
        
        OXGameController.sharedInstance.cancelGame(OXGameController.sharedInstance.getCurrentGame().ID, onCompletion: {game, message in
            
            print(message)
            
            if (message == nil) {
                
                OXGameController.sharedInstance.restartGame()
                self.networkMode = false
            }
            else {
                print(message)
            }
            
            
        })
        networkMode = false
    }
    
    
    @IBAction func refreshButtonPressed(sender: UIButton) {
        
        
        
        
        
        OXGameController.sharedInstance.getGame(OXGameController.sharedInstance.getCurrentGame().ID, onCompletion: { boardString, boardState, message in
            
          
            
            if (message == nil) {
         
                
                if (boardState == "tie") {
                    
                    self.updateUI(boardString!)
                    self.networkLabel.text = "Tied!!"
                    let alert = UIAlertController(title: "Tied", message: "No one won",
                        preferredStyle: UIAlertControllerStyle.Alert)
                    
                    let alertAction = UIAlertAction(title: "Dismiss", style: .Cancel, handler: { (action) in
                        
                        
                        
                    })
                    
                    alert.addAction(alertAction)
                    self.presentViewController(alert, animated: true, completion: nil)
                    return
                    
                    
                    
                    
                }
                
                
                if (boardState == "x_win") {
                    
                    self.updateUI(boardString!)
                    self.networkLabel.text = "Host won!"
                    let alert = UIAlertController(title: "Game over boi", message: "X won",
                        preferredStyle: UIAlertControllerStyle.Alert)
                    
                    let alertAction = UIAlertAction(title: "Dismiss", style: .Cancel, handler: { (action) in
                        
                        
                        
                    })
                    
                    alert.addAction(alertAction)
                    self.presentViewController(alert, animated: true, completion: nil)
                    return
                    
                    
                }
                
                if (boardState == "o_win") {
                    
                    self.updateUI(boardString!)
                    self.networkLabel.text = "Guest won!"
                    let alert = UIAlertController(title: "Game over boi", message: "O won",
                        preferredStyle: UIAlertControllerStyle.Alert)
                    
                    let alertAction = UIAlertAction(title: "Dismiss", style: .Cancel, handler: { (action) in
                        
                        
                        
                    })
                    
                    alert.addAction(alertAction)
                    self.presentViewController(alert, animated: true, completion: nil)
                    return


                    
                    
                    
                }
                
                
                
                if (boardState == "abandoned") {
                    
                    self.networkLabel.text = "Game Abandoned!"
                    let alert = UIAlertController(title: "Your opponent left.", message: "You kinda won?",
                        preferredStyle: UIAlertControllerStyle.Alert)
                    
                    let alertAction = UIAlertAction(title: "Dismiss", style: .Cancel, handler: { (action) in
                        
                        
                        
                    })
                    
                    alert.addAction(alertAction)
                    self.presentViewController(alert, animated: true, completion: nil)
                    return
                    
                    
                    
                    
                }
                
                
                if (boardState == "in_progress")
                
                {
                    
                    if (OXGameController.sharedInstance.getCurrentGame().turnCount() == 0) {
                        
                        if (self.host == true) {
                            
                            self.networkLabel.text = "Your turn bro!"
                            for view in self.boardView.subviews {
                                if let button = view as? UIButton {
                                    button.enabled = true
                                }
                            }
                            
                        }
                        
                        else {
                            
                            self.networkLabel.text = "Your opponent's turn"
                            
                        }
                        
                        
                    }
                    
                    
                
                if (OXGameController.sharedInstance.getCurrentGame().serialiseBoard() != boardString)
                {
                
                
                if (OXGameController.sharedInstance.getCurrentGame().host ==
                    UserController.sharedInstance.currentUser?.email) {
                    
                    
                    if (OXGameController.sharedInstance.getCurrentGame().turnCount()
                        % 2 == 0) {
                        
                        
                        self.networkLabel.text = "Your turn bro!"
                        for view in self.boardView.subviews {
                            if let button = view as?UIButton {
                                if (button.titleLabel == "") {
                                    button.enabled = true
                                }
                            }
                        }
                        
                        
                    }
                        
                    else {
                        
                        self.networkLabel.text = "Your opponent's turn."
                        for view in self.boardView.subviews {
                            if let button = view as? UIButton {
                                if (button.enabled == true) {
                                    button.enabled = false
                                }
                            }
                            
                        }
                        
                    }
                }
                else {
                    
                    
                    if (OXGameController.sharedInstance.getCurrentGame().turnCount() % 2
                        == 0) {
                        
                        self.networkLabel.text = "Your opponent's turn."
                        for view in self.boardView.subviews {
                            if let button = view as? UIButton {
                                if (button.enabled == true) {
                                    button.enabled = false
                                }
                            }
                        }
                    }
                        
                    else {
                        
                        self.networkLabel.text = "Your turn bro!"
                        for view in self.boardView.subviews {
                            if let button = view as? UIButton {
                                if (button.titleLabel == "") {
                                    button.enabled = true
                                }
                            }
                        }
                        
                    }
                    
                    
                    
                    }
                
                    
                    self.updateUI(boardString!)
                    print(boardString! + "in refresh button method")
                    print(OXGameController.sharedInstance.getCurrentGame().board)
                
                
                
    
                }
                
                
                } }
            else {
                print(message)
            }
                
            
            })
        }
    
    @IBAction func cellButtonPressed(sender: UIButton) {
        
        
        // janky stuff
        let doNothing = {() in
            return
        }
        
        if (networkMode == false) {
            
        
        
        
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
            
            
        else {
            
            
            
            let boardString = OXGameController.sharedInstance.getCurrentGame().serialiseBoard()
            
            var updatedString : String
            
            
            
            if (OXGameController.sharedInstance.getCurrentGame().turnCount() % 2 == 0) {
                
                updatedString = String(boardString.characters.dropLast(10 - sender.tag)) + "x" +
                String(boardString.characters.dropFirst(sender.tag))
                
            }
            else {
                
                updatedString = String(boardString.characters.dropLast(10 - sender.tag)) + "o" +
                String(boardString.characters.dropFirst(sender.tag))
            }
            
            updateUI(updatedString)
            
            
            
            
            OXGameController.sharedInstance.playMove(OXGameController.sharedInstance.getCurrentGame().ID, board: updatedString, onCompletion: {updatedString, message in
                
                if (message == nil) {
                    
                    sender.setTitle(OXGameController.sharedInstance.playMove(sender.tag).rawValue, forState: .Normal)
                    sender.enabled = false
                    self.updateUI(updatedString!)
                    self.networkLabel.text = "Your opponent's turn."
                    
                    
                    for view in self.boardView.subviews {
                        if let button = view  as? UIButton {
                            button.enabled = false
                        }
                    }
                    
                    
                    
                    
                    
                    let state = OXGameController.sharedInstance.getCurrentGame().state()
                    
                    if (state == OXGameState.Won) {
                        
                        // making sure you can't press buttons after you win
                        for view in self.boardView.subviews {
                            if let button = view as? UIButton {
                                if (button.enabled == true) {
                                    button.enabled = false
                                }
                                
                            }
                            
                        }
                        
                        
                        
                        if (OXGameController.sharedInstance.getCurrentGame().turnCount() % 2 == 1) {
                            
                            self.networkLabel.text = "Host won!"
                            let alert = UIAlertController(title: "Game over boi", message: "X won",
                                preferredStyle: UIAlertControllerStyle.Alert)
                            
                            let alertAction = UIAlertAction(title: "Dismiss", style: .Cancel, handler: { (action) in
                                
                                    doNothing()
                                
                            })
                            
                            alert.addAction(alertAction)
                            self.presentViewController(alert, animated: true, completion: nil)
                            
                        }
                        else {
                            
                            self.networkLabel.text = "Guest won!"
                            let alert = UIAlertController(title: "Game over boi", message: "O won",
                                preferredStyle: UIAlertControllerStyle.Alert)
                            
                            let alertAction = UIAlertAction(title: "Dismiss", style: .Cancel, handler: { (action) in
                                    doNothing()
                            
                            })
                            
                            alert.addAction(alertAction)
                            self.presentViewController(alert, animated: true, completion: nil)
                        }

                        
                        
                        
                    }
                    
                    
                    
                    else if (state == OXGameState.Tie){
                        
                        
                        self.networkLabel.text = "No one won!"
                        let alert = UIAlertController(title: "Tie", message: "No one won",
                            preferredStyle: UIAlertControllerStyle.Alert)
                        
                        let alertAction = UIAlertAction(title: "Dismiss", style: .Cancel, handler: { (action) in
                                doNothing()
                        })
                        
                        alert.addAction(alertAction)
                        self.presentViewController(alert, animated: true, completion: nil)
                        
                        
                    
                    }
                    
                    
                    
 
 
                    
                }
                
                else {
                    
                    // should be nil
                    print(message)
                    
                }
                })
                
            
          //  sender.setTitle(OXGameController.sharedInstance.playMove(sender.tag).rawValue, forState: .Normal)
            sender.enabled = false
            
          /*  if (OXGameController.sharedInstance.getCurrentGame().host == UserController.sharedInstance.currentUser!.email) {
                
                
                
            } */
            
            
            
            
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
    
    func updateUI(boardString : String) {
        
        
      //  var gameBoard = OXGameController.sharedInstance.getCurrentGame().board
        
   
        
        
        
        
        for view in boardView.subviews {
            if let button = view as? UIButton {
                let c = String(boardString[boardString.startIndex.advancedBy(button.tag - 1)])
                
                if (c == "x") {
                    button.setTitle("X", forState: .Normal)
                    button.enabled = false
                    OXGameController.sharedInstance.getCurrentGame().board[button.tag - 1] = CellType.X
                }
                else if (c == "o") {
                    button.setTitle("O", forState: .Normal)
                    button.enabled = false
                    OXGameController.sharedInstance.getCurrentGame().board[button.tag - 1] = CellType.O
                }
                else {
                    button.setTitle("", forState: .Normal)
                    button.enabled = true
                }
            }
        }
        
        
  
 
    }
 
}

