//
//  UserProfilePresenter.swift
//  Valtegram
//
//  Created by Максим Алексеев on 22.03.2020.
//  Copyright © 2020 Максим Алексеев. All rights reserved.
//

import Firebase

class UserProfilePresenter: UserProfileOutput {
    var post: Post?
    
   
    weak var view: UserProfileInput!
    
    var complitionHandler: ((User) -> Void)?
    func fetchUser(complitionHandler: @escaping ((User) -> Void)) {
        guard let uid = Auth.auth().currentUser?.uid else { return }
        self.complitionHandler = complitionHandler
        Database.database().reference().child("users").child(uid).observeSingleEvent(of: .value, with: { (snapshot) in
            print(snapshot.value ?? "")
            
            guard let dictionary = snapshot.value as? [String: Any] else { return }
            let user = User(dictionary: dictionary)
            self.view.user = user
            
            complitionHandler(user)
        }) { (error) in
            print(error.localizedDescription)
        }
    }
    
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
//
//    func getPostImage(url: URL) -> UIImage? {
//        var image: UIImage?
//
//        let networkService = NetworkService()
//        networkService.retriveUrl(url) { (data) in
//            image = UIImage(data: data)
//        }
//
//        return image
//    }

    func getProfileImage(url: URL) -> UIImage? {
        let networkService = NetworkService()
        
        networkService.getImageFrom(url) { (data) -> UIImage in
            guard let image = UIImage(data: data) else { fatalError() }
            return image
        }
        
        return nil
    }
    
    func getPostImage(post: Post?) -> UIImage? {
        guard let post = post else { fatalError() }
        guard let url = URL(string: post.imageUrl) else { fatalError() }
        
        
        let networkService = NetworkService()

        networkService.getImageFrom(url) { (data) -> UIImage in
            if url.absoluteString != self.post?.imageUrl { fatalError() }
            
            guard let image = UIImage(data: data) else { fatalError() }
            return image
        }
        
        return nil
    }
}
