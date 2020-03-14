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
            setupProfileImage()
        }
    }
    // MARK:- Views
    let profileImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.backgroundColor = .red
        imageView.translatesAutoresizingMaskIntoConstraints = false 
        
        print("DEADBEEF")
        
        return imageView
    }()
    
    
    
    
    // MARK:- Private functions
    private func setupProfileImage() {
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
    
    
    
    
    // MARK:- Initializers
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        backgroundColor = .gray
        
        addSubview(profileImageView)
        
        NSLayoutConstraint.activate([
            profileImageView.topAnchor.constraint(equalTo: topAnchor, constant: 12),
            profileImageView.leftAnchor.constraint(equalTo: leftAnchor, constant: 12),
            profileImageView.widthAnchor.constraint(equalToConstant: 100),
            profileImageView.heightAnchor.constraint(equalToConstant: 100),
        ])
        
        profileImageView.clipsToBounds = true
        profileImageView.layer.cornerRadius = 100/2
    
        print(#function)

    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
