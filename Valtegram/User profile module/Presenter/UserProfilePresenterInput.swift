//
//  UserProfilePresenterInput.swift
//  Valtegram
//
//  Created by Максим Алексеев on 22.03.2020.
//  Copyright © 2020 Максим Алексеев. All rights reserved.
//

import UIKit

protocol UserProfileInput: class {
    // UserProfileViewController
    var posts: [Post] { get set }
    var user: User? { get set }

    func handleLogOutButton()
    func show(_ controller: UIViewController)
    func setUser()
}
