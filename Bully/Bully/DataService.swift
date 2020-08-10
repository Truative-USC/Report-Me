//
//  DataService.swift
//  Bully
//
//  Created by Dev on 6/21/17.
//  Copyright © 2017 Truative. All rights reserved.
//

import Foundation
import Firebase
import FirebaseDatabase
import KeychainSwift

let DB_BASE = Database.database().reference()

let FIR_CHILD_USERS = "users"
let USER_REPORTS = "reports"



class DataService {
    
        private static let _instance = DataService()
    
        static var instance: DataService {
            return _instance //Maybe take out the "."
        }
    
        var mainRef: DatabaseReference {
            return Database.database().reference()
        }
    
    
    

    
    var usersRef: DatabaseReference {
        return mainRef.child(FIR_CHILD_USERS)
    }
    var reportRef: DatabaseReference {
        return mainRef.child(USER_REPORTS)
    }
    
    
    func saveUser(uid: String, userFirstName: String, userID: String) {
            let profile: Dictionary<String, AnyObject> = ["firstname": userFirstName as AnyObject, "lastName": "" as AnyObject, "isAdmin": "" as AnyObject, "id": userID as AnyObject]
            mainRef.child(FIR_CHILD_USERS).child(uid).child("profile").setValue(profile)
//            mainRef.child(FIR_CHILD_USERS).child(uid).child("profile").child("firstName").setValue(userFirstName)
        }
  

}




//        init(snapshot: DataSnapshot) {
//             admin = (snapshot.value! as! NSDictionary)["isAdmin"] as! String
//        }





//        private var _keyChain = KeychainSwift()
//        private var _refDatabase = DB_BASE
//
//        var keyChain: KeychainSwift {
//            get {
//                return _keyChain
//            }
//            set {
//                _keyChain = newValue
//            }
//        }


//
