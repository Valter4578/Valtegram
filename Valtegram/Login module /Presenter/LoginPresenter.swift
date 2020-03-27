//
//  LoginPresenter.swift
//  Valtegram
//
//  Created by Максим Алексеев on 22.03.2020.
//  Copyright © 2020 Максим Алексеев. All rights reserved.
//

import Firebase

class LoginPresenter: LoginViewOutput {

    weak var view: LoginViewInput!
    
    func didPressLogin(email: String, password: String) {
        
        Auth.auth().signIn(withEmail: email, password: password) { (result, error) in
            if let error = error {
                print(error.localizedDescription)
                return
            }
            
            print("Succssesfuly logged in with user: ", result?.user.uid ?? "")
            // Update ui
            guard let tabBarVC = UIApplication.shared.keyWindow?.rootViewController as? TabBarController else { return }
            tabBarVC.setupViewControllers()
            
            self.view.cancel(true)
        }
    }
    
}
