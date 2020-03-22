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
    // MARK:- Private properties
    private var user: User?
    private let cellId = "mainCell"
    private var posts = [Post]()
    
    // MARK:- Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Check if user didn't log in
        if Auth.auth().currentUser == nil {
            DispatchQueue.main.async {
                let logInViewController = LoginAssembly.configureModule()
                let navigationController = UINavigationController(rootViewController: logInViewController)
                self.present(navigationController, animated: true, completion: nil)
            }
        }
        
        collectionView.backgroundColor = .white
        
        fetchUser()
        
        collectionView?.register(UserProfileHeader.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: "headerID")
        
        collectionView.register(PostCollectionViewCell.self, forCellWithReuseIdentifier: cellId)
        
        setupPreferenceButton()
        
        fetchOrderedPosts()
    }
    
    //MARK: - Private methods
    private func showErrorAlert(with errorText: String) {
           let alertController = UIAlertController(title: "Error", message: errorText, preferredStyle: .alert)
           let alertAction = UIAlertAction(title: "OK", style: .cancel)
           alertController.addAction(alertAction)
           self.present(alertController, animated: true, completion: nil)
           
           print(errorText)
       }
       
    
    func fetchUser() {
        guard let uid = Auth.auth().currentUser?.uid else { return }
        Database.database().reference().child("users").child(uid).observeSingleEvent(of: .value, with: { (snapshot) in
            print(snapshot.value ?? "")
            
            
            guard let dictionary = snapshot.value as? [String: Any] else { return }
            self.user = User(dictionary: dictionary)
            
            self.title = self.user?.username
            
            self.collectionView.reloadData()
        }) { (error) in
            print(error.localizedDescription)
        }
    }
    
    private func fetchOrderedPosts() {
        guard let uid = Auth.auth().currentUser?.uid else { return }
        let reference = Database.database().reference().child("posts").child(uid)

        reference.queryOrdered(byChild: "date").observe(.childAdded, with: { (snapshot) in
            print(snapshot.key)
            print(snapshot.value)
            
            guard let dictionary = snapshot.value as? [String:Any] else { return }
            let post = Post(dictionary: dictionary)
            self.posts.append(post)
            
            self.collectionView?.reloadData()
            
        }) { (error) in
            self.showErrorAlert(with: error.localizedDescription)
        }
    }

    
    // MARK:- Setups
    private func setupPreferenceButton() {
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(named: "preference"), style: .plain, target: self, action: #selector(logOut))
    }
    
    
    // MARK:- Objc methods
    @objc func logOut() {
        let alertController = UIAlertController(title: "Log out", message: "Do you really want to do it ?", preferredStyle: .actionSheet)
        alertController.addAction(UIAlertAction(title: "Log out", style: .destructive, handler: { (_) in
            do {
                try? Auth.auth().signOut()
                
                let logInViewController = LoginAssembly.configureModule()
                let navigationVC = UINavigationController(rootViewController: logInViewController)
                self.present(navigationVC, animated: true, completion: nil)
            } catch {
                print(error)
            }
        }))
        
        alertController.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        present(alertController, animated: true)
    }
    // MARK:- Collection view delegate
    override func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        let header = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: "headerID", for: indexPath) as! UserProfileHeader
        
        header.user = self.user
            
        return header
    }
    

    // MARK:- Collection view data source
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return posts.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for:  indexPath) as? PostCollectionViewCell
        cell?.post = posts[indexPath.item]
        return cell!
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        // Deduct 2 because of two lines beetwen midle cell and left and right cell
        let width = (view.frame.width-2)/3
        return CGSize(width: width, height: width)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 1
    }
}

// MARK:- CollectionView Flow layout delegate
extension UserProfileViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        print(#function)
        return CGSize(width: view.frame.width, height: 200)
        
    }
}
