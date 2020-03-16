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
    
    // MARK:- Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        collectionView.backgroundColor = .white
        
        fetchUser()
        
        collectionView?.register(UserProfileHeader.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: "headerID")
        
        collectionView.register(UICollectionViewCell.self, forCellWithReuseIdentifier: cellId)
        
        setupPreferenceButton()
    }
    
    //MARK: - Private methods
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
        return 8
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for:  indexPath)
        cell.backgroundColor = .cyan
        
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
