//
//  UserProfileInput.swift
//  Valtegram
//
//  Created by Максим Алексеев on 27.03.2020.
//  Copyright © 2020 Максим Алексеев. All rights reserved.
//

import UIKit

protocol UserProfileInput: class {
    var userId: String? { get set } 
    
    func show(_ viewController: UIViewController)
    func handleLogOut()
    func setUser(_ user: User)
}
