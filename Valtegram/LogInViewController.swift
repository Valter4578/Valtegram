//
//  LogInViewController.swift
//  Valtegram
//
//  Created by Максим Алексеев on 16.03.2020.
//  Copyright © 2020 Максим Алексеев. All rights reserved.
//

import UIKit

class LogInViewController: UIViewController {
    // MARK:- Views
    let signUpButton: UIButton = {
        let button = UIButton(type: .system)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("Sign Up if you don't have account", for: .normal)
        button.titleLabel?.textColor = UIColor.black
        button.addTarget(self, action: #selector(handleSignUpButton), for: .touchUpInside)
        return button
    }()
    
    
    // MARK:- Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        setupSingUpButton()
        
        navigationController?.isNavigationBarHidden = true 
    }
    
    // MARK:- Setups
    private func setupSingUpButton() {
        view.addSubview(signUpButton)
        
        NSLayoutConstraint.activate([
            signUpButton.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 0),
            signUpButton.rightAnchor.constraint(equalTo: view.rightAnchor, constant: 0),
            signUpButton.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: 10),
            signUpButton.heightAnchor.constraint(equalToConstant: 45),
        ])
    }
    
    // MARK:- Objc methods
    @objc func handleSignUpButton() {
        let signUpViewController = SignUpViewController()
        navigationController?.pushViewController(signUpViewController, animated: true)
    }
}
