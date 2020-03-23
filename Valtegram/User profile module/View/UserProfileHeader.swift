//
//  UserProfileHeader.swift
//  Valtegram
//
//  Created by Максим Алексеев on 11.03.2020.
//  Copyright © 2020 Максим Алексеев. All rights reserved.
//

import UIKit

class UserProfileHeader: UICollectionViewCell {
    //MARK:- Properties
    var presenter: UserProfileOutput?
    
    var user: User? {
        didSet {
            guard let usr = user, let url = URL(string: usr.profileImageURL) else { return }
            let image = presenter?.getProfileImage(url: url)
            profileImageView.image = image
            usernameLabel.text = user?.username
        }
    }
    
    // MARK:- Views
    private let profileImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.backgroundColor = .red
        return imageView
    }()
    
    private let usernameLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 15)
        label.text = "username"
        return label
    }()
    // Stackview's buttons
    private let gridButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(named: "menu"), for: .normal)
        button.setImage(UIImage(named: "menu-s"), for: .selected)
        return button
    }()
    
    private let listButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(named: "list"), for: .normal)
        button.setImage(UIImage(named: "list-s"), for: .selected)
        return button
    }()
    
    private let bookmarkButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(named: "bookmark"), for: .normal)
        button.setImage(UIImage(named: "bookmark-s"), for: .selected)
        
        return button
    }()
    
    // Statistics labels
    private let postsLabel: UILabel = {
        let label = UILabel()

        let attributedString = NSMutableAttributedString(string: "0\n", attributes: [NSAttributedString.Key.font:UIFont.boldSystemFont(ofSize: 15)])
        attributedString.append(NSAttributedString(string: "posts", attributes: [NSAttributedString.Key.foregroundColor:UIColor.lightGray, NSAttributedString.Key.font: UIFont.systemFont(ofSize: 13)]))
        
        label.attributedText = attributedString
        
        label.textAlignment = .center
        label.numberOfLines = 0
        return label
    }()
    
    private let followersLabel: UILabel = {
        let label = UILabel()

        let attributedString = NSMutableAttributedString(string: "0\n", attributes: [NSAttributedString.Key.font:UIFont.boldSystemFont(ofSize: 15)])
        attributedString.append(NSAttributedString(string: "followers", attributes: [NSAttributedString.Key.foregroundColor:UIColor.lightGray, NSAttributedString.Key.font: UIFont.systemFont(ofSize: 13)]))
        
        label.attributedText = attributedString
        label.textAlignment = .center
        label.numberOfLines = 0
        return label
    }()
    
    private let followingLabel: UILabel = {
        let label = UILabel()
        
        let attributedString = NSMutableAttributedString(string: "0\n", attributes: [NSAttributedString.Key.font:UIFont.boldSystemFont(ofSize: 15)])
        attributedString.append(NSAttributedString(string: "following", attributes: [NSAttributedString.Key.foregroundColor:UIColor.lightGray, NSAttributedString.Key.font: UIFont.systemFont(ofSize: 13)]))
        
        label.attributedText = attributedString
        
        label.textAlignment = .center
        label.numberOfLines = 0
        return label
    }()
    
    private let editProfileButton: UIButton = {
        let button = UIButton()
         
        button.setTitle("Edit profile", for: .normal)
        button.setTitleColor(UIColor.setAsRgb(red: 27, green: 67, blue: 51), for: .normal)
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 16)
        
        button.layer.borderColor = UIColor.setAsRgb(red: 27, green: 67, blue: 51).cgColor
        button.layer.borderWidth = 1
        button.layer.cornerRadius = 8
        return button
    }()
    
    // MARK:- Initializers
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        let viewsArray = [profileImageView, usernameLabel, gridButton, listButton, gridButton, bookmarkButton, postsLabel, followersLabel, followingLabel, editProfileButton]
        viewsArray.forEach{$0.translatesAutoresizingMaskIntoConstraints = false}
    
        setupImageView()
        setupToolBar()
        setupLabel()
        setupUserStats()
        setupEditButton()
        
        print(#function)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK:- Setups
    private func setupToolBar() {
        
        let stackView = UIStackView(arrangedSubviews: [listButton, gridButton, bookmarkButton])
        
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .horizontal
        stackView.distribution = .fillEqually
        
        addSubview(stackView)
        NSLayoutConstraint.activate([
            stackView.leftAnchor.constraint(equalTo: leftAnchor, constant: 0),
            stackView.rightAnchor.constraint(equalTo: rightAnchor, constant: 0),
            stackView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: 0),
            stackView.heightAnchor.constraint(equalToConstant: 50)
        ])
        
        let topLineView = UIView()
        topLineView.backgroundColor = UIColor.gray
        topLineView.translatesAutoresizingMaskIntoConstraints = false
        
        let bottomLineView = UIView()
        bottomLineView.backgroundColor = UIColor.gray
        bottomLineView.translatesAutoresizingMaskIntoConstraints = false
        
        
        addSubview(topLineView)
        NSLayoutConstraint.activate([
            topLineView.topAnchor.constraint(equalTo: stackView.topAnchor, constant: 0),
            topLineView.leftAnchor.constraint(equalTo: leftAnchor, constant: 0),
            topLineView.rightAnchor.constraint(equalTo: rightAnchor, constant: 0),
            topLineView.heightAnchor.constraint(equalToConstant: 0.7)
        ])
        
        addSubview(bottomLineView)
        NSLayoutConstraint.activate([
            bottomLineView.topAnchor.constraint(equalTo: stackView.bottomAnchor, constant: 0),
            bottomLineView.leftAnchor.constraint(equalTo: leftAnchor, constant: 0),
            bottomLineView.rightAnchor.constraint(equalTo: rightAnchor, constant: 0),
            bottomLineView.heightAnchor.constraint(equalToConstant: 0.7)
        ])
    }
    
    private func setupImageView() {
        addSubview(profileImageView)
        
        NSLayoutConstraint.activate([
            profileImageView.topAnchor.constraint(equalTo: topAnchor, constant: 12),
            profileImageView.leftAnchor.constraint(equalTo: leftAnchor, constant: 12),
            profileImageView.widthAnchor.constraint(equalToConstant: 100),
            profileImageView.heightAnchor.constraint(equalToConstant: 100),
        ])
        
        profileImageView.clipsToBounds = true
        profileImageView.layer.cornerRadius = 100/2
    }
    
    private func setupLabel() {
        addSubview(usernameLabel)
        NSLayoutConstraint.activate([
            usernameLabel.topAnchor.constraint(equalTo: profileImageView.bottomAnchor, constant: 4),
            usernameLabel.leftAnchor.constraint(equalTo: leftAnchor, constant: 25),
            usernameLabel.rightAnchor.constraint(equalTo: rightAnchor, constant: -15),
            usernameLabel.bottomAnchor.constraint(equalTo: gridButton.topAnchor, constant: 3),
        ])
    }
    
    private func setupUserStats() {
        let stackView = UIStackView(arrangedSubviews: [postsLabel, followersLabel, followingLabel])
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.distribution = .fillEqually
        
        addSubview(stackView)

        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: topAnchor, constant: 13),
            stackView.leftAnchor.constraint(equalTo: profileImageView.rightAnchor, constant: 18),
            stackView.rightAnchor.constraint(equalTo: rightAnchor, constant: 13),
            stackView.heightAnchor.constraint(equalToConstant: 50),
        ])
    }
    
    private func setupEditButton() {
        addSubview(editProfileButton)
        NSLayoutConstraint.activate([
            editProfileButton.topAnchor.constraint(equalTo: postsLabel.bottomAnchor, constant: 10),
            editProfileButton.leftAnchor.constraint(equalTo: postsLabel.leftAnchor, constant: 0),
            editProfileButton.rightAnchor.constraint(equalTo: followingLabel.rightAnchor, constant: 0),
            editProfileButton.heightAnchor.constraint(equalToConstant: 35),
        ])
    }
    
}
