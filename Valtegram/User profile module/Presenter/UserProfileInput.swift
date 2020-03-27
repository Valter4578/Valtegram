//
//  UserProfileInput.swift
//  Valtegram
//
//  Created by Максим Алексеев on 25.03.2020.
//  Copyright © 2020 Максим Алексеев. All rights reserved.
//

import UIKit

protocol UserProfileInput: class {
    func handleLogOut()
    func update<T>(with data: T)
    func show(_ viewController: UIViewController)
}
