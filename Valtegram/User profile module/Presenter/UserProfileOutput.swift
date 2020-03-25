//
//  UserProfileOutput.swift
//  Valtegram
//
//  Created by Максим Алексеев on 25.03.2020.
//  Copyright © 2020 Максим Алексеев. All rights reserved.
//

import Foundation

protocol UserProfileOutput {
    var posts: [Post] { get set }
    
    func didLogOut() 
    func fetchUser(complitionHandler: @escaping ((User) -> Void) )
    func fetchOrderedPosts(complitionHandler: @escaping ([Post]) -> Void)
    
}
