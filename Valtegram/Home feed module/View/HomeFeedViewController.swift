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
    var presenter: HomeFeedOutput! 
    // MARK:- Constants
    let cellId = "homeFeedCell"
    
    // MARK:- Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView?.backgroundColor = .yellow
        
        collectionView?.register(HomePostCollectionViewCell.self, forCellWithReuseIdentifier: cellId)
        
        setupNavigationItems()
        
        presenter.fetchPosts {
            self.collectionView.reloadData()
        }
    }
    
    // MARK:- Setups
    private func setupNavigationItems() {
        let image = UIImage(named: "valtegram")
        let imageView = UIImageView(image: image)
        imageView.contentMode = .scaleToFill
        navigationItem.titleView = imageView
    }
    
    // MARK:- CollectionViewDataSource
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return presenter.posts.count
    }
    
    // MARK:- CollectionViewDelegate

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath) as! HomePostCollectionViewCell

        cell.post = presenter.posts[indexPath.item]
        
        return cell
    }
}

extension HomeFeedViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: view.frame.width, height: 250)
    }
}
