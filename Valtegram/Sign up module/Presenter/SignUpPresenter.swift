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
            self.view?.cancel(animated: true)
        }
        print(#function)
    }
    
    func createUser(email: String, password: String, imageToUpload: UIImage, data: Data, username: String) {
        Auth.auth().createUser(withEmail: email, password: password) { (result, error) in
            if let err = error {
                print(err.localizedDescription)
                return
            }
            print("User created ", result?.user.uid)
            
            guard let uid = result?.user.uid else { return }

            let imgURL = self.uploadImage(image: imageToUpload, data: data, uid: uid, username: username)
            
        }
        print(#function)
    }
    
    func uploadImage(image: UIImage, data: Data, uid: String, username: String) -> URL? {
        var url: URL?
        
        let filename = NSUUID().uuidString
        
        let profileRef = Storage.storage().reference().child("profileImages").child(filename)
        
        profileRef.putData(data, metadata: nil) { (metadata, error) in
            
            let profileRef = StorageReference().child("profileImage")
            if let err = error {
                print("Failed to uploud image: ", err.localizedDescription)
                return
            }
            
            var profileImageUrl: URL?
            _ = profileRef.downloadURL { (imgUrl, error) in
                if let err = error {
                    print("Failed to get image url: ", err.localizedDescription)
                    return
                }
                
                print("Successfully upload profile image: ", imgUrl)
                    
                
                self.saveUserIntoDatabase(username: username, uid: uid, imageUrl: imgUrl)
            }
        }
        
        print(#function)
        return url
    }

    init(view: SignUpInput) {
        self.view = view
    }
    
}
