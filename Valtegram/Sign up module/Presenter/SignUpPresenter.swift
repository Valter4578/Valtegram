//
//  SignUpPresenter.swift
//  Valtegram
//
//  Created by Максим Алексеев on 26.03.2020.
//  Copyright © 2020 Максим Алексеев. All rights reserved.
//

import Firebase

class SignUpPresenter: SignUpOutput {
    
    weak var view: SignUpInput?
    
    func saveUserIntoDatabase(username: String, uid: String, imageUrl: URL?) {
        Database.database().reference().child("users").updateChildValues([uid:["username":username, "profileImageUrl":imageUrl?.absoluteString]]) { (error, reference) in
            if let err = error {
                print("Failed to add user into database: ",err.localizedDescription)
                return
            }
            print("User " + username + " saved with image: \(imageUrl?.absoluteString)")
            
            // Update ui
            guard let tabBarVC = UIApplication.shared.keyWindow?.rootViewController as? TabBarController else { return }
            tabBarVC.setupViewControllers()
            view?.cancel(animated: true)
        }
        print(#function)
    }
    
    func createUser(email: String, password: String, imageToUpload: UIImage, data: Data, username: String) {
        
    }
    
    func uploadImage(image: UIImage, data: Data, uid: String, for username: String) -> URL? {
    }

}
