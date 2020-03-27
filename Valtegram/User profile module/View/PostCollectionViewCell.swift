//
//  PostCollectionViewCell.swift
//  Valtegram
//
//  Created by Максим Алексеев on 19.03.2020.
//  Copyright © 2020 Максим Алексеев. All rights reserved.
//

import UIKit

class PostCollectionViewCell: UICollectionViewCell {
    // MARK:- Views
    let photoImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.clipsToBounds = true
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFill
        return imageView
    }()
    // MARK:- Properties
    var post: Post? {
        didSet {
            print(post?.imageUrl)
        }
    }
    
    // MARK:- Private methods
    private func setupImageView() {
        addSubview(photoImageView)
        
        NSLayoutConstraint.activate([
            photoImageView.leftAnchor.constraint(equalTo: leftAnchor, constant: 0),
            photoImageView.rightAnchor.constraint(equalTo: rightAnchor, constant: 0),
            photoImageView.topAnchor.constraint(equalTo: topAnchor, constant: 0),
            photoImageView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: 0),
        ])
    }
    
    // MARK:- Inits
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupImageView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
