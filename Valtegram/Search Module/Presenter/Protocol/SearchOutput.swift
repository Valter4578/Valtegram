//
//  SearchOutput.swift
//  Valtegram
//
//  Created by Максим Алексеев on 02.04.2020.
//  Copyright © 2020 Максим Алексеев. All rights reserved.
//

import Foundation

protocol SearchOutput {
    var users: [User] { get set }
    var filteredUsers: [User] { get set }
    
    func fetchUsers(complitionHandler: @escaping () -> () ) 
}
