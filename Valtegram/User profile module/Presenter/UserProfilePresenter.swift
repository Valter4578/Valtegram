//
//  UserProfilePresenter.swift
//  Valtegram
//
//  Created by Максим Алексеев on 25.03.2020.
//  Copyright © 2020 Максим Алексеев. All rights reserved.
//

import Firebase

class UserProfilePresenter: UserProfileOutput {
    
    weak var view: UserProfileInput?
    
    var posts = [Post]()
    
    func didLogOut() {
        try? Auth.auth().signOut()
        
        let logInViewController = LoginAssembly.configureModule()
        let navigationVC = UINavigationController(rootViewController: logInViewController)
        view?.show(navigationVC)
    }
    
    func fetchUser(complitionHandler: @escaping ((User) -> Void) ) {
        guard let uid = Auth.auth().currentUser?.uid else { return }
        
        Database.database().reference().child("users").child(uid).observeSingleEvent(of: .value, with: { (snapshot) in
            guard let dictionary = snapshot.value as? [String:Any] else { return }
            
            let user = User(dictionary: dictionary)
            
            complitionHandler(user)
        }) { (error) in
            print(error.localizedDescription)
            return
        }
    }
    
    func fetchOrderedPosts(complitionHandler: @escaping ([Post]) -> Void ) {
        guard let uid = Auth.auth().currentUser?.uid else { return }
        let reference = Database.database().reference().child("posts").child(uid)
        
        reference.queryOrdered(byChild: "date").observe(.value, with: { (snapshot) in
            guard let dictionary = snapshot.value as? [String:Any] else { return }
            let post = Post(dictionary: dictionary)
            self.posts.append(post)
            
            self.view?.update(with: self.posts)
        }) { (error) in
            print(error.localizedDescription)
            return
        }
    }
        
}
