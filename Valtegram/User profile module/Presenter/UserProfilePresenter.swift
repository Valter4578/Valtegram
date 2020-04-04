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
    
    weak var view: UserProfileViewInput?
    weak var header: UserProfileHeaderInput?
    
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
    
    func isCurrentUser(uid: String) -> Bool {
        return Auth.auth().currentUser?.uid == uid
    }
    
    func didFollowTapped(isFollowing: Bool) {
        guard let currentUserUid = Auth.auth().currentUser?.uid else { return }
        guard let usersUid = user?.uid else { return }
        
        if isFollowing { // When button title is "unfollow"
            let reference = Database.database().reference().child("following").child(currentUserUid)
            reference.removeValue { (error, reference) in
                if let err = error {
                    print(err.localizedDescription)
                    return
                }
                
            }
        } else { // When button title is "follow"
            let values = [usersUid : 1]
            let reference = Database.database().reference().child("following").child(currentUserUid)
            reference.updateChildValues(values) { (error, reference) in
                if let err = error {
                    print(err.localizedDescription)
                    return
                }
            }
        }
    }
    
    func isFollowing() {
        guard let currentUsersUid = Auth.auth().currentUser?.uid else { fatalError() }
        guard let usersUid = user?.uid else { fatalError() }
    Database.database().reference().child(currentUsersUid).child(usersUid).observeSingleEvent(of: .value, with: { (snapshot) in
            
            guard let isFollowing = snapshot.value as? Int else { return }
            self.header?.setFollow(isFollowing: isFollowing == 1)
            
        }) { (error) in
            print(error.localizedDescription)
        }
    }
    
    
    init(view: UserProfileViewInput) {
        self.view = view
    }
}
