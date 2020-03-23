//
//  UserProfileController.swift
//  Valtegram
//
//  Created by Максим Алексеев on 11.03.2020.
//  Copyright © 2020 Максим Алексеев. All rights reserved.
//

import UIKit
import Firebase

class UserProfileViewController: UICollectionViewController, UserProfileInput {
    // MARK:- Properties
    var presenter: UserProfileOutput! {
        didSet {
            print("Presenteer: \(presenter)")
        }
    }
    
    // MARK:- Private properties
    var user: User?
    private let cellId = "mainCell"
    var posts = [Post]()
    
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
        
        setUser()
        
        collectionView?.register(UserProfileHeader.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: "headerID")
        
        collectionView.register(PostCollectionViewCell.self, forCellWithReuseIdentifier: cellId)
        
        setupPreferenceButton()
        
        presenter?.fetchOrderedPosts()
    }
    
    // MARK:- Iternal methods
    func setUser() {
        presenter?.fetchUser(complitionHandler: { (user) in
            self.title = user.username
            self.collectionView.reloadData()
        })
    }
    
    //MARK: - Private method
        
//    func fetchUser() {
//        guard let uid = Auth.auth().currentUser?.uid else { return }
//        Database.database().reference().child("users").child(uid).observeSingleEvent(of: .value, with: { (snapshot) in
//            print(snapshot.value ?? "")
//
//
//            guard let dictionary = snapshot.value as? [String: Any] else { return }
//            self.user = User(dictionary: dictionary)
//
//            self.title = self.user?.username
//
//            self.collectionView.reloadData()
//        }) { (error) in
//            print(error.localizedDescription)
//        }
//    }
    
//    private func fetchOrderedPosts() {
//        guard let uid = Auth.auth().currentUser?.uid else { return }
//        let reference = Database.database().reference().child("posts").child(uid)
//
//        reference.queryOrdered(byChild: "date").observe(.childAdded, with: { (snapshot) in
//            print(snapshot.key)
//            print(snapshot.value)
//            
//            guard let dictionary = snapshot.value as? [String:Any] else { return }
//            let post = Post(dictionary: dictionary)
//            self.posts.append(post)
//            
//            self.collectionView?.reloadData()
//            
//        }) { (error) in
//            self.showErrorAlert(with: error.localizedDescription)
//        }
//    }

    // MARK:- UserProfileUn
    func show(_ controller: UIViewController) {
        present(controller, animated: true, completion: nil)
    }
    
    // MARK:- Setups
    private func setupPreferenceButton() {
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(named: "preference"), style: .plain, target: self, action: #selector(handleLogOutButton))
    }
    
    
    // MARK:- Objc methods
    @objc func handleLogOutButton() {
        let alertController = UIAlertController(title: "Log out", message: "Do you really want to do it ?", preferredStyle: .actionSheet)
        alertController.addAction(UIAlertAction(title: "Log out", style: .destructive, handler: { (_) in
            do {
                self.presenter?.didLogOut()
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
        header.presenter = presenter
            
        return header
    }


    // MARK:- Collection view data source
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return posts.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for:  indexPath) as? PostCollectionViewCell
        cell?.post = posts[indexPath.item]
        cell?.presenter = presenter
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
