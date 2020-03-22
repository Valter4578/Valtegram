//
//  LoginPresenterInput.swift
//  Valtegram
//
//  Created by Максим Алексеев on 22.03.2020.
//  Copyright © 2020 Максим Алексеев. All rights reserved.
//

import Foundation

protocol LoginViewInput: class {
    func handleLoginButton()
    
    func handleTextInputChange()
    
    func handleSignUpButton()
    
    func cancel(_ animated: Bool)
}
