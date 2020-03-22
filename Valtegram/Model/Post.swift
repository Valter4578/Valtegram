//
//  Post.swift
//  Valtegram
//
//  Created by Максим Алексеев on 19.03.2020.
//  Copyright © 2020 Максим Алексеев. All rights reserved.
//

import Foundation

struct Post {
    let imageUrl: String
    
    init(dictionary: [String:Any] ) {
        self.imageUrl = dictionary["imageUrl"] as? String ?? ""
    }
}
