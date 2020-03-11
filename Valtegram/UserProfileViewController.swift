//
//  UserProfileController.swift
//  Valtegram
//
//  Created by Максим Алексеев on 11.03.2020.
//  Copyright © 2020 Максим Алексеев. All rights reserved.
//

import UIKit
import Firebase

class UserProfileViewController: UICollectionViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        
        collectionView.backgroundColor = .white
        
        
        fetchUser()
    }
    
    private func fetchUser() {
        guard let uid = Auth.auth().currentUser?.uid else { return }
        Database.database().reference().child("users").child(uid).observeSingleEvent(of: .value, with: { (snapshot) in
            print(snapshot.value ?? "")
            
            
            guard let dictionary = snapshot.value as? [String: Any] else { return }
            let username = dictionary["username"] as? String
            self.title = username
        }) { (error) in
            print(error.localizedDescription)
        }
    }
}
