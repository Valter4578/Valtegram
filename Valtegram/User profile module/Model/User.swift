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
    
    init(dictionary: [String:Any]) {
        self.username = dictionary["username"] as? String ?? ""
        self.profileImageURL = dictionary["profileImageUrl"] as? String ?? ""
    }
}

