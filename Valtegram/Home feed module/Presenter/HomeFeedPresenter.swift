//
//  HomeFeedPresenter.swift
//  Valtegram
//
//  Created by Максим Алексеев on 22.03.2020.
//  Copyright © 2020 Максим Алексеев. All rights reserved.
//

import Firebase

class HomeFeedPresenter: HomeFeedPresenterOutput {
    var posts: [Post]
    
        
    weak var view: HomeFeedPresenterInput!
    

    func fetchPosts(view: HomeFeedPresenterInput) -> ((Error?, Post?) -> Void) {
        guard let uid = Auth.auth().currentUser?.uid else { fatalError() }
        
        let reference = Database.database().reference().child("posts").child(uid)
        reference.observe(.value, with: { (snapshot) in
            
            guard let dictionaries = snapshot.value as? [String:Any] else { return }
            dictionaries.forEach { (key, value) in
                print("Key: \(key), value \(value)")
                
                guard let dictionary = value as? [String:Any] else { return }
                let imageUrl = dictionary["imageUrl"] as? String
                let post = Post(dictionary: dictionary)
                
                return (nil, post)
            }
            
        }) { (error) in
            return (error, nil)
        }
        
    }
    
    init(posts: [Post]) {
        self.posts = posts
    }
}
