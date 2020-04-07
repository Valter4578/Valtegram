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
    // MARK:- Properties
    var presenter: UserProfileOutput!
    var userId: String? 
    
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
                let logInViewController = LogInViewController()
                let navigationController = UINavigationController(rootViewController: logInViewController)
                self.present(navigationController, animated: true, completion: nil)
            }
        }
        
        collectionView.backgroundColor = .white
        
        presenter.fetchUser()
        
        collectionView?.register(UserProfileHeader.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: "headerID")
        
        collectionView.register(PostCollectionViewCell.self, forCellWithReuseIdentifier: cellId)
        
        setupPreferenceButton()

        presenter.fetchPost {
              self.collectionView.reloadData()
        }
    }
    
    //MARK: - Private methods
    private func showErrorAlert(with errorText: String) {
           let alertController = UIAlertController(title: "Error", message: errorText, preferredStyle: .alert)
           let alertAction = UIAlertAction(title: "OK", style: .cancel)
           alertController.addAction(alertAction)
           self.present(alertController, animated: true, completion: nil)
           
           print(errorText)
    }
    
    // MARK:- Setups
    private func setupPreferenceButton() {
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(named: "preference"), style: .plain, target: self, action: #selector(handleLogOut))
    }
}

// MARK:- UserProfileInput 
extension UserProfileViewController: UserProfileViewInput {
    func show(_ viewController: UIViewController) {
        present(viewController, animated: true, completion: nil)
    }
    
    // MARK:- Objc methods
    @objc func handleLogOut() {
        let alertController = UIAlertController(title: "Log out", message: "Do you really want to do it ?", preferredStyle: .actionSheet)
        alertController.addAction(UIAlertAction(title: "Log out", style: .destructive, handler: { (_) in
            do {
                self.presenter.didLogOut()
            } catch {
                print(error)
            }
        }))
        
        alertController.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        present(alertController, animated: true)
    }
    
    func setUser(_ user: User) {
        title = user.username
        collectionView.reloadData()
    }
}

// MARK:- Collection view delegate
extension UserProfileViewController {
    override func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        let header = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: "headerID", for: indexPath) as! UserProfileHeader
        
//        if let user = presenter.user {
//            header.user = user
//            header.isCurrentsUsersProfile = presenter.isCurrentUser(uid: user.uid)
//        }
        
        if let user = presenter.user {
            header.user = user
            header.presenter = presenter
        }
        return header
    }
}

// MARK:- Collection view data source
extension UserProfileViewController {
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return presenter.posts.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for:  indexPath) as! PostCollectionViewCell
        cell.post = presenter.posts[indexPath.item]
        return cell
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
