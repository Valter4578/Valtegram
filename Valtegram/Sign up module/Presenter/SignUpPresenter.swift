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
        
        
    }
    
    func createUser(email: String, password: String, imageToUpload: UIImage, data: Data, username: String) {
        
    }
    
    func uploadImage(image: UIImage, data: Data, uid: String, for username: String) -> URL? {
    }

}
