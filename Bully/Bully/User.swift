//
//  User.swift
//  Bully
//
//  Created by Dev on 7/16/17.
//  Copyright © 2017 Truative. All rights reserved.
//

import UIKit

struct User {
    
    
     var firstname: String?
     var _uid: String
     var lastName: String?
    var isAdmin: Bool?
    
    var uid: String {
        return _uid
    }
    
    var firstName: String {
    return firstname!
    }
    
    init(uid: String, firstName: String) {
        _uid = uid
        firstname = firstName
        
    }
    
}


