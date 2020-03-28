//
//  HomeFeedCollectionViewCell.swift
//  Valtegram
//
//  Created by Максим Алексеев on 20.03.2020.
//  Copyright © 2020 Максим Алексеев. All rights reserved.
//

import UIKit

class HomeFeedCollectionViewCell: UICollectionViewCell {
    // MARK:- Properties
    var post: Post? {
        didSet {
            guard let post = post, let url = URL(string: post.imageUrl) else { return }
            postImageView.kf.setImage(with: url)
        }
    }
    
    // MARK:- Views
    let userProfileImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.backgroundColor = .yellow
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.layer.cornerRadius = imageView.bounds.width / 2
        return imageView
    }()
    
    let usernameLabel: UILabel = {
        let label = UILabel()
        label.text = "Username"
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 14)
        return label
    }()
    
    let dotsButton: UIButton = {
        let button = UIButton(type: .system)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("•••", for: .normal)
        button.setTitleColor(.black, for: .normal)
        return button
    }()
    
    let postImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.backgroundColor = .white
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        return imageView
    }()
    
    let likeButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setImage(#imageLiteral(resourceName: "heart").withRenderingMode(.alwaysOriginal), for: .normal)
        return button
    }()
    
    let commentButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setImage(#imageLiteral(resourceName: "comment").withRenderingMode(.alwaysOriginal), for: .normal)
        return button
    }()
    
    let sendButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setImage(#imageLiteral(resourceName: "paper-plane").withRenderingMode(.alwaysOriginal), for: .normal)
        return button
    }()
    
    let bookmarkButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setImage(#imageLiteral(resourceName: "bookmark").withRenderingMode(.alwaysOriginal), for: .normal)
        return button
    }()
    
    let descriptionLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 0
        
        let attributedText = NSMutableAttributedString(string: "Username ", attributes: [NSAttributedString.Key.font:UIFont.boldSystemFont(ofSize: 14)])
        
        attributedText.append(NSAttributedString(string: "Lorem ispum", attributes: [NSAttributedString.Key.font:UIFont.systemFont(ofSize: 14)]))
        
        attributedText.append(NSAttributedString(string: "\n1 month ago", attributes:
            [NSAttributedString.Key.font:UIFont.systemFont(ofSize: 14),
             NSAttributedString.Key.foregroundColor: UIColor.lightGray]))
        
        label.attributedText = attributedText
        
        return label
    }()
    
    // MARK:- Initializers
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupUserImageView()
        setupPostImageView()
        setupDotsButton()
        setupUsernameLabel()
        setupStackView()
        setupDescriptionLabel()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    // MARK:- Setups
    
    private func setupUserImageView() {
        addSubview(userProfileImageView)
                
        NSLayoutConstraint.activate([
            userProfileImageView.topAnchor.constraint(equalTo: topAnchor, constant: 7),
            userProfileImageView.leftAnchor.constraint(equalTo: leftAnchor, constant: 7),
            userProfileImageView.widthAnchor.constraint(equalToConstant: 50),
            userProfileImageView.heightAnchor.constraint(equalToConstant: 50),
        ])
    }

    private func setupPostImageView() {
        addSubview(postImageView)
                
        NSLayoutConstraint.activate([
            postImageView.topAnchor.constraint(equalTo: userProfileImageView.bottomAnchor, constant: 8),
            postImageView.leftAnchor.constraint(equalTo: leftAnchor, constant: 0),
            postImageView.rightAnchor.constraint(equalTo: rightAnchor, constant: 0),
            postImageView.heightAnchor.constraint(equalTo: widthAnchor, multiplier: 1),
        ])
    }
    
    private func setupUsernameLabel() {
        addSubview(usernameLabel)
        
        NSLayoutConstraint.activate([
            usernameLabel.topAnchor.constraint(equalTo: topAnchor, constant: 0),
            usernameLabel.bottomAnchor.constraint(equalTo: postImageView.topAnchor, constant: 0),
            usernameLabel.leftAnchor.constraint(equalTo: userProfileImageView.rightAnchor, constant: 10),
            usernameLabel.rightAnchor.constraint(equalTo: dotsButton.leftAnchor, constant: 0),
        ])
    }
    
    private func setupDotsButton() {
        addSubview(dotsButton)
        
        NSLayoutConstraint.activate([
            dotsButton.topAnchor.constraint(equalTo: topAnchor, constant: 0),
            dotsButton.bottomAnchor.constraint(equalTo: postImageView.topAnchor, constant: 0),
            dotsButton.rightAnchor.constraint(equalTo: rightAnchor, constant: 0),
            dotsButton.widthAnchor.constraint(equalToConstant: 50),
        ])
    }
    
    /// Stack view with action buttons
    private func setupStackView() {
        let stackView = UIStackView(arrangedSubviews: [likeButton, commentButton, sendButton])
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.distribution = .fillEqually
        
        addSubview(stackView)
        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: postImageView.bottomAnchor, constant: 0),
            stackView.leftAnchor.constraint(equalTo: leftAnchor, constant: 10),
            stackView.widthAnchor.constraint(equalToConstant: 150),
            stackView.heightAnchor.constraint(equalToConstant: 50),
        ])
    }
    
    private func setupBookmarkButton() {
        addSubview(bookmarkButton)
        
        NSLayoutConstraint.activate([
            bookmarkButton.topAnchor.constraint(equalTo: postImageView.bottomAnchor, constant: 0),
            bookmarkButton.rightAnchor.constraint(equalTo: rightAnchor, constant: 0),
            bookmarkButton.widthAnchor.constraint(equalToConstant: 50),
            bookmarkButton.heightAnchor.constraint(equalToConstant: 50),
        ])
    }
    
    private func setupDescriptionLabel() {
        addSubview(descriptionLabel)
        
        NSLayoutConstraint.activate([
            descriptionLabel.topAnchor.constraint(equalTo: likeButton.bottomAnchor, constant: 0),
            descriptionLabel.leftAnchor.constraint(equalTo: leftAnchor, constant: 10),
            descriptionLabel.rightAnchor.constraint(equalTo: rightAnchor, constant: 10),
            descriptionLabel.bottomAnchor.constraint(equalTo: bottomAnchor, constant: 0),
        ])
    }
}
