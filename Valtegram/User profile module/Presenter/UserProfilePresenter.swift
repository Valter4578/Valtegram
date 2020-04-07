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

    // MARK:- Properties
    weak var view: UserProfileViewInput?
    
    var user: User?
    var posts = [Post]()
    
    // MARK:- Functions
    func didLogOut() {
        try? Auth.auth().signOut()
        
        let loginVC = LogInViewController()
        let navigationVC = UINavigationController(rootViewController: loginVC)
        
        view?.show(navigationVC)
    }
    
    /// Fetch user from firebase
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
    
    /// Started after follow/edit button in header tapped
    /// - Parameter isFollowing: will be true when button's text is "Unfollow"
    func didFollowTapped(isFollowing: Bool) {
        guard let userUid = user?.uid else { return }
        guard let currentUserUid = Auth.auth().currentUser?.uid else { return }
        let reference = Database.database().reference().child("following").child(currentUserUid)
        if isFollowing { // button's text is "Unfollow"
            reference.child(userUid).removeValue { (error, reference) in
                if let error = error {
                    print(error.localizedDescription)
                    return
                }
                
                print("Unfollowed")
            }
        } else { // button's text is "Follow"
            let values = [userUid: true]
            reference.updateChildValues(values) { (error, reference) in
                if let error = error {
                    print(error.localizedDescription)
                    return
                }
                
                print("followed")
            }
        }
    }

    
    /// Starts when user properti user setted
    /// - Parameter complitionHandler: in complition button configurated depend of value
    func checkFollowing(complitionHandler: @escaping (Bool) -> Void) {
        guard let currentUserUid = Auth.auth().currentUser?.uid else { return }
        guard let userUid = user?.uid else { return }
            
        let reference = Database.database().reference().child("following").child(currentUserUid).child(userUid)
        
        reference.observeSingleEvent(of: .value, with: { (snapshot) in
            guard let isFollowing = snapshot.value as? Bool else { return }
            complitionHandler(isFollowing)
        }) { (error) in
            print(error.localizedDescription)
            return
        }
    }
    
    // MARK:- Initializers
    init(view: UserProfileViewInput) {
        self.view = view
    }
}
