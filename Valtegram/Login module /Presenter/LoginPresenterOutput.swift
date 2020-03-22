//
//  LoginPresenterOutput.swift
//  Valtegram
//
//  Created by Максим Алексеев on 22.03.2020.
//  Copyright © 2020 Максим Алексеев. All rights reserved.
//

import Foundation

protocol LoginViewOutput: class {
        
    func didPressLogin(email: String, password: String)
}
    
