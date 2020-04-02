//
//  UserProfilePresenter.swift
//  Valtegram
//
//  Created by Максим Алексеев on 27.03.2020.
//  Copyright © 2020 Максим Алексеев. All rights reserved.
//

import Foundation
import Firebase

class UserProfilePresenter: UserProfileOutput {
    
    weak var view: UserProfileInput?
    
    var user: User?
    var posts = [Post]()
    
    func didLogOut() {
        try? Auth.auth().signOut()
        
        let loginVC = LogInViewController()
        let navigationVC = UINavigationController(rootViewController: loginVC)
        
        view?.show(navigationVC)
    }
    
    func fetchUser() {
        guard let uid = view?.userId ?? Auth.auth().currentUser?.uid else { return }
        Database.database().reference().child("users").child(uid).observeSingleEvent(of: .value, with: { (snapshot) in
            print(snapshot.value ?? "")
            
            
            guard let dictionary = snapshot.value as? [String: Any] else { return }
            self.user = User(dictionary: dictionary, uid: uid)
            
            guard let usr = self.user else { return }
            self.fetchPost()
            self.view?.setUser(usr)
        }) { (error) in
            print(error.localizedDescription)
        }
    }


    func fetchPost() {
        guard let uid = user?.uid else { return }
        let reference = Database.database().reference().child("posts").child(uid)
        reference.queryOrdered(byChild: "date").observe(.childAdded, with: { (snapshot) in
            guard let dictionary = snapshot.value as? [String:Any] else { return }
            
            guard let user = self.user else { return }
            let post = Post(dictionary: dictionary, user: user)
            self.posts.insert(post, at: 0)
            
        }) { (error) in
            print(error.localizedDescription)
            return 
        }
    }
    
    init(view: UserProfileInput) {
        self.view = view
    }
}
