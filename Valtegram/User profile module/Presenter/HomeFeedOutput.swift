//
//  HomeFeedOutput.swift
//  Valtegram
//
//  Created by Максим Алексеев on 28.03.2020.
//  Copyright © 2020 Максим Алексеев. All rights reserved.
//

import Foundation

protocol HomeFeedOutput {
    var posts: [Post] { get set }
    
    func fetchPosts(complitionHandler: @escaping () -> ())
}
