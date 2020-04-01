//
//  User.swift
//  Valtegram
//
//  Created by Максим Алексеев on 14.03.2020.
//  Copyright © 2020 Максим Алексеев. All rights reserved.
//

import Foundation

struct User {
    let username: String
    let profileImageURL: String
    var uid: String
    
    init(dictionary: [String:Any], uid: String) {
        self.username = dictionary["username"] as? String ?? ""
        self.profileImageURL = dictionary["profileImageUrl"] as? String ?? ""
        self.uid = uid 
    }
}

