//
//  HomeFeedCollectionViewCell.swift
//  Valtegram
//
//  Created by Максим Алексеев on 20.03.2020.
//  Copyright © 2020 Максим Алексеев. All rights reserved.
//

import UIKit

class HomePostCollectionViewCell: UICollectionViewCell {
    // MARK:- Properties
    var post: Post? {
        didSet {
            guard let post = post, let url = URL(string: post.imageUrl) else { return }
            photoImageView.kf.setImage(with: url)
        }
    }
    
    // MARK:- Views
    let photoImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.backgroundColor = .cyan
        return imageView
    }()
    // MARK:- Initializers
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupImageView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    // MARK:- Setups
    private func setupImageView() {
        addSubview(photoImageView)
        
        NSLayoutConstraint.activate([
            photoImageView.topAnchor.constraint(equalTo: topAnchor, constant: 0),
            photoImageView.leftAnchor.constraint(equalTo: leftAnchor, constant: 0),
            photoImageView.rightAnchor.constraint(equalTo: rightAnchor, constant: 0),
            photoImageView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: 0),
        ])
    }
    
    
}
