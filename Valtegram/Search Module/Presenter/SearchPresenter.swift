//
//  SearchPresenter.swift
//  Valtegram
//
//  Created by Максим Алексеев on 02.04.2020.
//  Copyright © 2020 Максим Алексеев. All rights reserved.
//

import Firebase

final class SearchPresenter: SearchOutput {
    var filteredUsers: [User] = [User]()
    var users: [User] = [User]()
    
    func fetchUsers(complitionHandler: @escaping () -> ()) {
        let reference = Database.database().reference().child("users")
        reference.observeSingleEvent(of: .value, with: { (snapshot) in
            guard let dictionaries = snapshot.value as? [String:Any] else { return }
            
            dictionaries.forEach { (key,value) in // key is uid 
                
                // Don't presenter user's account in search
                if key == Auth.auth().currentUser?.uid {
                    return
                }
                
                guard let dictionary = value as? [String:Any] else { return }
                
                let user = User(dictionary: dictionary, uid: key)
                
                self.users.append(user)
                self.filteredUsers = self.users
                
                self.users.sorted { (firstUser, secondUser) -> Bool in
                    return firstUser.username.compare(secondUser.username) == .orderedAscending
                }
                
                complitionHandler() 
            }
        }) { (error) in
            print(error.localizedDescription)
            return
        }
    }
    
}
