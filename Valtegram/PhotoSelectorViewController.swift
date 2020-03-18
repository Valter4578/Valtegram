//
//  PhotoSelectorViewController.swift
//  Valtegram
//
//  Created by Максим Алексеев on 18.03.2020.
//  Copyright © 2020 Максим Алексеев. All rights reserved.
//

import UIKit
import Photos

class PhotoSelectorViewController: UICollectionViewController {
    // MARK:- Properties
    override var prefersStatusBarHidden: Bool {
        return true
    }
    
    let cellId = "photoSelectorCell"
    let headerId = "photoSelectorHeader"
    
    var images = [UIImage]()
    
    // MARK:- Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        collectionView.backgroundColor = .green
        
        setupNavigationController()
        
        collectionView.register(PhotoSelctorCell.self, forCellWithReuseIdentifier: cellId)
        collectionView.register(UICollectionViewCell.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: headerId)
        
        fetchPhotos()
    }
    
    // MARK:- Setups
    private func setupNavigationController() {
        navigationController?.navigationBar.tintColor = .black
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Cancel", style: .plain, target: self, action: #selector(handleCancelButton))
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Next", style: .plain, target: self, action: #selector(handleNextButton))

    }
    
    // MARK:- Private functions
    private func fetchPhotos() {
        let options = PHFetchOptions()
        options.fetchLimit = 20
        let allPhotos = PHAsset.fetchAssets(with: .image, options: options)
        allPhotos.enumerateObjects { (asset, count, stop) in
            
            let imageManager = PHImageManager.default()
            let targetSize = CGSize(width: 350, height: 350)
            let options = PHImageRequestOptions()
            options.isSynchronous = true
            imageManager.requestImage(for: asset, targetSize: targetSize, contentMode: .aspectFit, options: options) { (image, info) in
                
                guard let img = image else { return }
                self.images.append(img)
                
                if count == allPhotos.count - 1 {
                    self.collectionView.reloadData()
                }
            }
        }
    }
    
    // MARK:- Objc methods
    
    @objc func handleCancelButton() {
        dismiss(animated: true, completion: nil)
    }
    
    @objc func handleNextButton() {
        
    }
    
    // MARK:- CollectionViewDelegate
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath) as! PhotoSelctorCell
        cell.photoImageView.image = images[indexPath.item]
        
        return cell
    }
    // MARK:- CollectionViewDataSource

    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return images.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        let header = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: headerId, for: indexPath )
        header.backgroundColor = .yellow
        return header
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        let size = view.frame.width
        return CGSize(width: size, height: size)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 1, left: 0, bottom: 0, right: 0)
    }
}
 
// MARK:- CollectionViewDelegateFlowLayout
extension PhotoSelectorViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let size = (view.frame.width - 3 ) / 4
        return CGSize(width: size, height: size)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 1
    }
}
