//
//  SharePhotoViewController.swift
//  Valtegram
//
//  Created by Максим Алексеев on 19.03.2020.
//  Copyright © 2020 Максим Алексеев. All rights reserved.
//

import UIKit

class SharePhotoViewController: UIViewController {
    // MARK:- Properties
    var image: UIImage? {
        didSet {
            imageView.image = image
        }
    }
    
    // MARK:- Views
    let containerView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .white
        return view
    }()
    
    let imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.backgroundColor = .blue
        imageView.clipsToBounds = true
        imageView.contentMode = .scaleAspectFill
        return imageView
    }()
    
    let textView: UITextView = {
        let textView = UITextView()
        textView.translatesAutoresizingMaskIntoConstraints = false
        textView.font = UIFont.systemFont(ofSize: 15)
        return textView
    }()
    
    
    // MARK:- Propeties
    override var prefersStatusBarHidden: Bool {
        return true
    }
    
    // MARK:- Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .lightGray
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Upload", style: .plain, target: self, action: #selector(handleShareButton))
        
        setupContainerView()
    }
    // MARK:- Setups
    
    private func setupContainerView() {
        
        view.addSubview(containerView)
        
        NSLayoutConstraint.activate([
            containerView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 0),
            containerView.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 0),
            containerView.rightAnchor.constraint(equalTo: view.rightAnchor, constant: 0),
            containerView.heightAnchor.constraint(equalToConstant: 100),
        ])
        
        containerView.addSubview(imageView)
        
        NSLayoutConstraint.activate([
            imageView.topAnchor.constraint(equalTo: containerView.topAnchor, constant: 8),
            imageView.leftAnchor.constraint(equalTo: containerView.leftAnchor, constant: 8),
            imageView.bottomAnchor.constraint(equalTo: containerView.bottomAnchor, constant: -8),
            imageView.widthAnchor.constraint(equalToConstant: 84),
        ])
        
        containerView.addSubview(textView)
        
        NSLayoutConstraint.activate([
            textView.topAnchor.constraint(equalTo: containerView.topAnchor, constant: 0),
            textView.leftAnchor.constraint(equalTo: imageView.rightAnchor, constant: 5),
            textView.rightAnchor.constraint(equalTo: containerView.rightAnchor, constant: 0),
            textView.bottomAnchor.constraint(equalTo: containerView.bottomAnchor, constant: 0),
        ])
    }
    
    // MARK:- Objc methods
    @objc func handleShareButton() {
        
    }
}
