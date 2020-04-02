//
//  SearchCollectionViewCell.swift
//  Valtegram
//
//  Created by Максим Алексеев on 01.04.2020.
//  Copyright © 2020 Максим Алексеев. All rights reserved.
//

import UIKit

final class SearchCollectionViewCell: UICollectionViewCell {
    // MARK:- Properties
    var user: User? {
        didSet {
            usernameLabel.text = user?.username
            guard let usr = user,let url = URL(string: usr.profileImageURL) else { return }
            profileImageView.kf.setImage(with: url)
        }
    }
    
    // MARK:- Views
    let profileImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.backgroundColor = .red
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.layer.cornerRadius = 25
        return imageView
    }()
    
    let usernameLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "username"
        label.font = UIFont.systemFont(ofSize: 14)
        return label
    }()
    
    let lineView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .lightGray
        return view
    }()
    
    // MARK:- Initializers
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .white
        setupImageView()
        setupLabel()
        setupLineView() 
    }
        
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK:- Setups
    private func setupImageView() {
        addSubview(profileImageView)
        
        NSLayoutConstraint.activate([
            profileImageView.leftAnchor.constraint(equalTo: leftAnchor, constant: 10),
            profileImageView.widthAnchor.constraint(equalToConstant: 50),
            profileImageView.heightAnchor.constraint(equalToConstant: 50),
            profileImageView.centerYAnchor.constraint(equalTo: centerYAnchor, constant: 0),
        ])
    }
    
    private func setupLabel() {
        addSubview(usernameLabel)
        
        NSLayoutConstraint.activate([
            usernameLabel.topAnchor.constraint(equalTo: topAnchor, constant: 0),
            usernameLabel.rightAnchor.constraint(equalTo: rightAnchor, constant: 0),
            usernameLabel.leftAnchor.constraint(equalTo: profileImageView.rightAnchor, constant: 10),
            usernameLabel.bottomAnchor.constraint(equalTo: bottomAnchor, constant: 0),
        ])
    }
    
    private func setupLineView() {
        addSubview(lineView)
        
        NSLayoutConstraint.activate([
            lineView.leftAnchor.constraint(equalTo: usernameLabel.leftAnchor, constant: 0),
            lineView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: 0),
            lineView.rightAnchor.constraint(equalTo: rightAnchor, constant: -50),
            lineView.heightAnchor.constraint(equalToConstant: 1)
        ])
    }
}
