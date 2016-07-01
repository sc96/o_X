//
//  UserController.swift
//  o_X
//
//  Created by Sam on 6/30/16.
//  Copyright © 2016 iX. All rights reserved.
//

import Foundation


class User {
    
    var email: String
    var password: String
    
    init(email: String, password: String) {
        
        self.email = email
        self.password = password
    }
}


class UserController {
    
    var currentUser: User?
    var UserList : [User] = []
    
    static let sharedInstance = UserController()
    private init() {}
    
    
    



func register(email email: String, password: String, onCompletion: (User?, String?) -> Void) {
    
    
    if (password.characters.count < 6) {
        onCompletion(nil, "Password is too short")
        return
    }
    
    for user in UserList {
    if (user.email == email) {
        onCompletion(nil, "Email is already in used")
        return
    }
    }
    
    
    currentUser = User(email: email, password: password)
    
    let defaults = NSUserDefaults.standardUserDefaults()
    defaults.setObject(email, forKey: "currentUserEmail")
    defaults.setObject(password, forKey: "currentUserPassword")
    defaults.synchronize()
    
    
    onCompletion(currentUser,nil)
    self.UserList.append(currentUser!)
    
    
    
}
func login(email email: String, password: String, onCompletion: (User?, String?) -> Void) {
    
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
