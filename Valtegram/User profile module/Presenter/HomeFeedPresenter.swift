//
//  HomeFeedPresenter.swift
//  Valtegram
//
//  Created by Максим Алексеев on 28.03.2020.
//  Copyright © 2020 Максим Алексеев. All rights reserved.
//

import Firebase

class HomeFeedPresenter: HomeFeedOutput {
    // MARK:- Properties
    var posts: [Post] = [Post]()
    
    // MARK:- Methods
    func fetchPosts(complitionHandler: @escaping () -> () ) {
        guard let uid = Auth.auth().currentUser?.uid else { return }
        
        let reference = Database.database().reference().child("posts").child(uid)
        reference.observe(.value, with: { (snapshot) in

            guard let dictionaries = snapshot.value as? [String:Any] else { return }
            dictionaries.forEach { (key, value) in
                print("Key: \(key), value \(value)")
                
                guard let dictionary = value as? [String:Any] else { return }
                let imageUrl = dictionary["imageUrl"] as? String
                let post = Post(dictionary: dictionary)
                self.posts.append(post)
            }
            
            complitionHandler()
        }) { (error) in
            print(error.localizedDescription)
            return
        }
    }
}
