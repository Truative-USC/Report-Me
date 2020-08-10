//
//  AuthService.swift
//  Bully
//
//  Created by Dev on 6/21/17.
//  Copyright © 2017 Truative. All rights reserved.
//

import Foundation
import FirebaseAuth


typealias Completion = (_ errMsg: String?, _ data: AnyObject?) -> Void


class AuthService {
    private static let _instance = AuthService()

    static var instance: AuthService {
        return _instance
    }


    func login(email: String, password: String, onComplete: Completion?) {
        Auth.auth().signIn(withEmail: email, password: password, completion: { (user, error) in
            if error != nil {
                if user?.uid != nil {
                    //sign in
                    Auth.auth().signIn(withEmail: email, password: password, completion: { (user, error) in
                        if error != nil {
                            self.handleFirebaseError(error: error! as NSError, onComplete: onComplete)
                        }
                        else {
                            onComplete?(nil, user)
                        }
                    })
                }
            }
            else {
                
                onComplete?(nil, user)
            }
        })
    }


    func handleFirebaseError(error: NSError, onComplete: Completion?) {
        print(error.debugDescription)
        if let errorCode = AuthErrorCode(rawValue: error.code) {
            switch (errorCode) {
            case .invalidEmail:
                onComplete?("Invalid Email Address", nil)
            case .wrongPassword:
                onComplete?("Invalid Password", nil)
            default:
                onComplete?("There was a problem Autheticating please try again.", nil)
            }
        }
    }

}

