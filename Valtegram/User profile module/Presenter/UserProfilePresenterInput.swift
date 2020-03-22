//
//  UserProfilePresenterInput.swift
//  Valtegram
//
//  Created by Максим Алексеев on 22.03.2020.
//  Copyright © 2020 Максим Алексеев. All rights reserved.
//

import UIKit

protocol UserProfileInput: class {
    func handleLogOutButton()
    func show(_ controller: UIViewController)
    var posts: [Post] { get set }
}
