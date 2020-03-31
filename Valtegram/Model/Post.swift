//
//  Post.swift
//  Valtegram
//
//  Created by Максим Алексеев on 19.03.2020.
//  Copyright © 2020 Максим Алексеев. All rights reserved.
//

import UIKit

struct Post {
    let imageUrl: String
    let user: User
    let description: String
    
    init(dictionary: [String:Any], user: User) {
        self.imageUrl = dictionary["imageUrl"] as? String ?? ""
        self.user = user
        self.description = dictionary["text"] as? String ?? ""
    }
}
