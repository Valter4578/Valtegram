//
//  UserProfilePresenter.swift
//  Valtegram
//
//  Created by Максим Алексеев on 22.03.2020.
//  Copyright © 2020 Максим Алексеев. All rights reserved.
//

import Firebase

class UserProfilePresenter: UserProfileOutput {
    
    weak var view: UserProfileInput!
    
    
    func didLogOut() {
        try? Auth.auth().signOut()
        
        let logInViewController = LoginAssembly.configureModule()
        let navigationVC = UINavigationController(rootViewController: logInViewController)
        view.show(navigationVC)
    }
    
    
    func fetchOrderedPosts() {
        guard let uid = Auth.auth().currentUser?.uid else { return }
        let reference = Database.database().reference().child("posts").child(uid)

        reference.queryOrdered(byChild: "date").observe(.childAdded, with: { (snapshot) in
            print(snapshot.key)
            print(snapshot.value)
            
            guard let dictionary = snapshot.value as? [String:Any] else { return }
            let post = Post(dictionary: dictionary)
            self.view.posts.append(post)
            
            
        }) { (error) in
            print(error.localizedDescription)
            return
        }
    }

    
    
}
