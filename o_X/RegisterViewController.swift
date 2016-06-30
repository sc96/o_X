//
//  RegisterViewController.swift
//  o_X
//
//  Created by Sam on 6/30/16.
//  Copyright © 2016 iX. All rights reserved.
//

import UIKit

class RegisterViewController: UIViewController {

    
    @IBOutlet weak var emailField: UITextField!
    

    @IBOutlet weak var passwordField: UITextField!
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        
        emailField.becomeFirstResponder()
    }
    
    @IBAction func registerButton(sender: AnyObject) {
        
        UserController.sharedInstance.register(email: emailField.text!, password: passwordField.text!, onCompletion: { user, message in
    
            if (user == nil) {
                let alert = UIAlertController(title: "Failed", message: message, preferredStyle: .Alert)
                let alertAction = UIAlertAction(title: "Dismiss", style: .Default, handler: nil)
                alert.addAction(alertAction)
                self.presentViewController(alert, animated: true, completion: nil)
            } else {
                let controller = UIStoryboard(name: "Main", bundle: nil).instantiateInitialViewController()
                let window = UIApplication.sharedApplication().keyWindow
                window?.rootViewController = controller
            }
        })
    }
    
    @IBAction func emailFieldEnterPressed(sender: UITextField) {
        passwordField.becomeFirstResponder()
    }
    
    @IBAction func passwordFieldEnterPressed(sender: UITextField) {
        passwordField.resignFirstResponder()
    }

}
