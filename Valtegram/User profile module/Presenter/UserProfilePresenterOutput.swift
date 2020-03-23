//
//  UserProfilePresenterOutput.swift
//  Valtegram
//
//  Created by Максим Алексеев on 22.03.2020.
//  Copyright © 2020 Максим Алексеев. All rights reserved.
//

import UIKit

protocol UserProfileOutput: class {
    // UserProfileViewController
    func didLogOut()
    func fetchOrderedPosts()
    func fetchUser(complitionHandler: @escaping ((User) -> Void))
    // PostCollectionViewHeader
    func getProfileImage(url: URL) -> UIImage?
    // PostCollectionViewCell
    func getPostImage(post: Post?) -> UIImage?
}
