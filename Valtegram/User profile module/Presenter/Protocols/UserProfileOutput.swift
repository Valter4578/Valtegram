//
//  UserProfileOutput.swift
//  Valtegram
//
//  Created by Максим Алексеев on 27.03.2020.
//  Copyright © 2020 Максим Алексеев. All rights reserved.
//

import Foundation

protocol UserProfileOutput {
    var user: User? { get set }
    var posts: [Post] { get set }
    
    func didLogOut()
    func fetchUser()
    func fetchPost(completionHandler: @escaping () -> Void)
}
