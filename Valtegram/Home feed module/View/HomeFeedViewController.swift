//
//  HomeFeedViewController.swift
//  Valtegram
//
//  Created by Максим Алексеев on 20.03.2020.
//  Copyright © 2020 Максим Алексеев. All rights reserved.
//

import UIKit
import Firebase

class HomeFeedViewController: UICollectionViewController {
    // MARK:- Properties
    var posts = [Post]()
    // MARK:- Constants
    let cellId = "homeFeedCell"
    
    // MARK:- Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView?.backgroundColor = .yellow
        
        collectionView?.register(UICollectionViewCell.self, forCellWithReuseIdentifier: cellId)
        
        setupNavigationItems()
        
        fetchPosts()
    
    }
    
    // MARK:- Setups
    private func setupNavigationItems() {
        let image = UIImage(named: "valtegram")
        let imageView = UIImageView(image: image)
        imageView.contentMode = .scaleToFill
        navigationItem.titleView = imageView
    }
    // MARK:- Private methods
    
    private func showErrorAlert(with errorText: String) {
        let alertController = UIAlertController(title: "Error", message: errorText, preferredStyle: .alert)
        let alertAction = UIAlertAction(title: "OK", style: .cancel)
        alertController.addAction(alertAction)
        self.present(alertController, animated: true, completion: nil)
        
        print(errorText)
    }
        
    private func fetchPosts() {
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
            
            self.collectionView.reloadData()
        }) { (error) in
            self.showErrorAlert(with: error.localizedDescription)
        }
    }
    
    
    
    // MARK:- CollectionViewDataSource
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return posts.count
    }
    
    // MARK:- CollectionViewDelegate

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath)

        return cell
    }
}

extension HomeFeedViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: view.frame.width, height: 250)
    }
}
