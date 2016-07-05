//
//  UserController.swift
//  o_X
//
//  Created by Sam on 6/30/16.
//  Copyright © 2016 iX. All rights reserved.
//

import Foundation
import Alamofire

class User {
    
    var email: String
    var password: String
    var token: String
    var client: String
    
    init(email: String, password: String, token: String, client: String) {
        
        self.email = email
        self.password = password
        self.token = token
        self.client = client
        
    }
}


class UserController: WebService {
    
    var currentUser: User?
//    var UserList : [User] = []
    
    static let sharedInstance = UserController()
    private override init() {}
    
    
    
    
    
    
    func register(email email: String, password: String, onCompletion: (User?, String?) -> Void) {
        
        
        if (password.characters.count < 6) {
            onCompletion(nil, "Password is too short")
            return
        }
        
        // Don't need this anymore??
        /*
        for user in UserList {
            if (user.email == email) {
                onCompletion(nil, "Email is already in used")
                return
            }
        }
        */
        let user = ["email": email, "password": password]
        
        
        
        let request = self.createMutableAnonRequest(NSURL(string: "https://ox-backend.herokuapp.com/auth"), method: "POST", parameters: user)
        
        //execute request is a function we are able to call in UserController, because UserController extends WebService (See top of file, where UserController is defined)
        self.executeRequest(request, requestCompletionFunction: {(responseCode, json) in
            
            //Here is our completion closure for the web request. when the web service is done, this is what is executed.
            //Not only is the code in this block executed, but we are given 2 input parameters, responseCode and json.
            //responseCode is the response code from the server.
            //json is the response data received
            
            var user:User = User(email: "", password: "", token: "", client:"")
            
            if (responseCode == 200)   { //if the responseCode is 2xx (any responseCode in the 200's range is a success case. For example, some servers return 201 for successful object creation)
                
                //successfully registered user. get the obtained data from the json response data and create the user object to give back to the calling ViewController
                user = User(email: json["data"]["email"].stringValue,password:"not_given_and_not_stored",token:json["data"]["token"].stringValue, client:json["data"]["client"].stringValue)
                
                
                
                
                //while we at it, lets persist our user
                // self.storeUser(user)
                
                let defaults = NSUserDefaults.standardUserDefaults()
                defaults.setObject(email, forKey: "currentUserEmail")
                defaults.setObject(password, forKey: "currentUserPassword")
                defaults.synchronize()
                
                
                
                
                
                //and while we still at it, lets set the user as logged in. This is good programming as we are keeping all the user management inside the UserController and handling it at the right time
                self.currentUser = user
                
                // self.UserList.append(self.currentUser!)
                
                
                //Note that our registerUser function has 4 parameters: email, password, presentingViewController and requestCompletionFunction
                //requestCompletionFunction is a closure for what is to happen in the ViewController when we are done with the webservice.
                
                //lets execute that closure now - Lets me be clear. This is 1 step more advanced than normal. We are executing a closure inside a closure (we are executing the viewControllerCompletionFunction from within the requestCompletionFunction.
                onCompletion(user,nil)
            }   else    {
                //the web service to create a user failed. Lets extract the error message to be displayed
                
                let errorMessage = json["errors"]["full_messages"][0].stringValue
                
                //execute the closure in the ViewController
                onCompletion(nil, errorMessage)}
            
            })
        
        /*
        let defaults = NSUserDefaults.standardUserDefaults()
        defaults.setObject(email, forKey: "currentUserEmail")
        defaults.setObject(password, forKey: "currentUserPassword")
        defaults.synchronize()
        
        
        onCompletion(currentUser,nil)
        self.UserList.append(currentUser! */
        
        
    }
    
        
    
 
        
        
        
 
    func login(email email: String, password: String, onCompletion: (User?, String?) -> Void) {
        
        
        // Don't need this anymore???
        /*
        for user in UserList {
            if (user.email == email && user.password == password) {
                
                let defaults = NSUserDefaults.standardUserDefaults()
                defaults.setObject(email, forKey: "currentUserEmail")
                defaults.setObject(password, forKey: "currentUserPassword")
                defaults.synchronize()
                
                currentUser = user
                onCompletion(user, nil)
                return
            }
        }
        
        onCompletion(nil, "Your username or password is incorrect")
        
 */
        
        
        let user = ["email": email, "password": password]
        let request = self.createMutableAnonRequest(NSURL(string: "https://ox-backend.herokuapp.com/auth/sign_in"), method: "POST", parameters: user)
        
        
        //execute request is a function we are able to call in UserController, because UserController extends WebService (See top of file, where UserController is defined)
        self.executeRequest(request, requestCompletionFunction: {(responseCode, json) in
            
            //Here is our completion closure for the web request. when the web service is done, this is what is executed.
            //Not only is the code in this block executed, but we are given 2 input parameters, responseCode and json.
            //responseCode is the response code from the server.
            //json is the response data received
            
            var user:User = User(email: "", password: "", token: "", client:"")
            
            if (responseCode == 200)   { //if the responseCode is 2xx (any responseCode in the 200's range is a success case. For example, some servers return 201 for successful object creation)
                
                //successfully registered user. get the obtained data from the json response data and create the user object to give back to the calling ViewController
                user = User(email: json["data"]["email"].stringValue,password:"not_given_and_not_stored",token:json["data"]["token"].stringValue, client:json["data"]["client"].stringValue)
                
                
                
                
                //while we at it, lets persist our user
                // self.storeUser(user)
                
                let defaults = NSUserDefaults.standardUserDefaults()
                defaults.setObject(email, forKey: "currentUserEmail")
                defaults.setObject(password, forKey: "currentUserPassword")
                defaults.synchronize()
                
                
                
                //and while we still at it, lets set the user as logged in. This is good programming as we are keeping all the user management inside the UserController and handling it at the right time
                self.currentUser = user
                
                
                
                //Note that our registerUser function has 4 parameters: email, password, presentingViewController and requestCompletionFunction
                //requestCompletionFunction is a closure for what is to happen in the ViewController when we are done with the webservice.
                
                //lets execute that closure now - Lets me be clear. This is 1 step more advanced than normal. We are executing a closure inside a closure (we are executing the viewControllerCompletionFunction from within the requestCompletionFunction.
                onCompletion(user,nil)
            }   else    {
                //the web service to create a user failed. Lets extract the error message to be displayed
                
                let errorMessage = json["errors"]["full_messages"][0].stringValue
                
                //execute the closure in the ViewController
                onCompletion(nil, errorMessage)}
            
        })
        
        
        
    }
    

    
    
    func logout(onCompletion onCompletion: (String?) -> Void) {
        
        
        let defaults = NSUserDefaults.standardUserDefaults()
        defaults.removeObjectForKey("currentUserEmail")
        defaults.removeObjectForKey("currentUserPassword")
        defaults.synchronize()
        currentUser = nil
        onCompletion(nil)
        
        
    }
}
