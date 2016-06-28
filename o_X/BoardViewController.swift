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
    }
    
    @IBAction func logoutButtonpressed(sender: UIButton) {
        print("Logout button pressed")
    }
    

    
    @IBAction func cellButtonPressed(sender: UIButton) {
        print("Tag is \(sender.tag)")
    }
    
    // Create additional IBActions here.

}

