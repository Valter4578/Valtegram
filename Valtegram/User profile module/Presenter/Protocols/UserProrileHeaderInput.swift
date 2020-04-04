//
//  UserProrileHeaderInput.swift
//  Valtegram
//
//  Created by Максим Алексеев on 03.04.2020.
//  Copyright © 2020 Максим Алексеев. All rights reserved.
//

import Foundation

protocol UserProfileHeaderInput: class {
    func handleFollowButton()
    func setFollow(isFollowing: Bool) 
}
