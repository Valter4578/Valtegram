//
//  UserProfileHeader.swift
//  Valtegram
//
//  Created by Максим Алексеев on 11.03.2020.
//  Copyright © 2020 Максим Алексеев. All rights reserved.
//

import UIKit
import Firebase

class UserProfileHeader: UICollectionViewCell {
    //MARK:- Properties
    var user: User? {
        didSet {
            setProfileImage()
            usernameLabel.text = user?.username
        }
    }
    // MARK:- Views
    let profileImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.backgroundColor = .red
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    
    let usernameLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.boldSystemFont(ofSize: 15)
        label.text = "username"
        return label
    }()
    // Stackview's buttons
    let gridButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setImage(UIImage(named: "menu"), for: .normal)
        button.setImage(UIImage(named: "menu-s"), for: .selected)
        return button
    }()
    
    let listButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setImage(UIImage(named: "list"), for: .normal)
        button.setImage(UIImage(named: "list-s"), for: .selected)
        return button
    }()
    
    let bookmarkButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setImage(UIImage(named: "bookmark"), for: .normal)
        button.setImage(UIImage(named: "bookmark-s"), for: .selected)
        
        return button
    }()
    
    // Statistics labels
    let postsLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false

        let attributedString = NSMutableAttributedString(string: "0\n", attributes: [NSAttributedString.Key.font:UIFont.boldSystemFont(ofSize: 15)])
        attributedString.append(NSAttributedString(string: "posts", attributes: [NSAttributedString.Key.foregroundColor:UIColor.lightGray, NSAttributedString.Key.font: UIFont.systemFont(ofSize: 13)]))
        
        label.attributedText = attributedString
        
        label.textAlignment = .center
        label.numberOfLines = 0
        return label
    }()
    
    let followersLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false

        let attributedString = NSMutableAttributedString(string: "0\n", attributes: [NSAttributedString.Key.font:UIFont.boldSystemFont(ofSize: 15)])
        attributedString.append(NSAttributedString(string: "followers", attributes: [NSAttributedString.Key.foregroundColor:UIColor.lightGray, NSAttributedString.Key.font: UIFont.systemFont(ofSize: 13)]))
        
        label.attributedText = attributedString
        
        label.textAlignment = .center
        label.numberOfLines = 0
        return label
    }()
    
    let followingLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        
        let attributedString = NSMutableAttributedString(string: "0\n", attributes: [NSAttributedString.Key.font:UIFont.boldSystemFont(ofSize: 15)])
        attributedString.append(NSAttributedString(string: "following", attributes: [NSAttributedString.Key.foregroundColor:UIColor.lightGray, NSAttributedString.Key.font: UIFont.systemFont(ofSize: 13)]))
        
        label.attributedText = attributedString
        
        label.textAlignment = .center
        label.numberOfLines = 0
        return label
    }()
    
    
    let editProfileButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
         
        button.setTitle("Edit profile", for: .normal)
        button.setTitleColor(UIColor.setAsRgb(red: 27, green: 67, blue: 51), for: .normal)
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 16)
        
        button.layer.borderColor = UIColor.setAsRgb(red: 27, green: 67, blue: 51).cgColor
        button.layer.borderWidth = 1
        button.layer.cornerRadius = 8
        return button
    }()
    
    // MARK:- Private functions
    private func setProfileImage() {
        guard let usr = user else { return }
        guard let url = URL(string: usr.profileImageURL) else { return }
        URLSession.shared.dataTask(with: url) { (data, response, error) in
            if let err = error {
                print(err.localizedDescription)
                return
            }
            
            print(data)
            guard let data = data else { return }
            let image = UIImage(data: data)
            
            
            DispatchQueue.main.async {
                self.profileImageView.image = image
            }
        }.resume()
        
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
    
    // MARK:- Initializers
    override init(frame: CGRect) {
        super.init(frame: frame)
    
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
}