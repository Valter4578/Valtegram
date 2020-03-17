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
    lazy var signUpButton: UIButton = {
        let button = UIButton(type: .system)
        button.translatesAutoresizingMaskIntoConstraints = false
        
        let attributedString = LogInViewController.makeAttributedButtonTitle(greenText: "Sign up ", grayText: "if you don't have account")
        button.setAttributedTitle(attributedString, for: .normal)
        
        button.addTarget(self, action: #selector(handleSignUpButton), for: .touchUpInside)
        return button
    }()
    
    let logoContainerView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = UIColor.setAsRgb(red: 14, green: 186, blue: 129)
        let originalImage = UIImage(named: "valtegram")
        let img = originalImage?.tinted(with: .white)
        let logoImageView = UIImageView(image: img)
        logoImageView.translatesAutoresizingMaskIntoConstraints = false
        logoImageView.contentMode = .scaleAspectFill
        view.addSubview(logoImageView)
        NSLayoutConstraint.activate([
            logoImageView.heightAnchor.constraint(equalToConstant: 150),
            logoImageView.widthAnchor.constraint(equalToConstant: 200),
            logoImageView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            logoImageView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
        ])
        return view
    }()
    
    
    let emailTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "Email"
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.borderStyle = .roundedRect
        
        
        return textField
    }()
    
    let passwordTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "Password"
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.borderStyle = .roundedRect
        textField.isSecureTextEntry = true
        
        return textField
    }()
    
    let logInButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Login", for: .normal)
        button.setTitleColor(UIColor.white, for: .normal)
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 17)
        button.backgroundColor = UIColor.setAsRgb(red: 14, green: 186, blue: 129)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.layer.cornerRadius = 8
        button.isEnabled = false
                
        return button
    }()
    
    
    // MARK:- Variabels
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
        
    // MARK:- Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        setupSingUpButton()
        setupLogoContainer()
        setupStackView()
        
        navigationController?.isNavigationBarHidden = true
        
    }
    
    // MARK:- Setups
    private func setupSingUpButton() {
        view.addSubview(signUpButton)
        
        NSLayoutConstraint.activate([
            signUpButton.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 0),
            signUpButton.rightAnchor.constraint(equalTo: view.rightAnchor, constant: 0),
            signUpButton.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -40),
            signUpButton.heightAnchor.constraint(equalToConstant: 45),
        ])
    }
    
    private func setupLogoContainer() {
        view.addSubview(logoContainerView)
        
        NSLayoutConstraint.activate([
            logoContainerView.topAnchor.constraint(equalTo: view.topAnchor, constant: 0),
            logoContainerView.rightAnchor.constraint(equalTo: view.rightAnchor, constant: 0),
            logoContainerView.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 0),
            logoContainerView.heightAnchor.constraint(equalToConstant: 150),
        ])
    }
    
    private func setupImageView(for imageView: UIImageView) {
        view.addSubview(imageView)
        NSLayoutConstraint.activate([
            imageView.heightAnchor.constraint(equalToConstant: 60),
            imageView.widthAnchor.constraint(equalToConstant: 200),
            imageView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            imageView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
        ])
    }
    
    /// Stack view with password,email textfields and with login button
    private func setupStackView() {
        let stackView = UIStackView(arrangedSubviews: [emailTextField, passwordTextField, logInButton])
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.spacing = 10
        stackView.distribution = .fillEqually
        
        
        view.addSubview(stackView)
        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: logoContainerView.bottomAnchor, constant: 60),
            stackView.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 50),
            stackView.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -50),
            stackView.heightAnchor.constraint(equalToConstant: 150)
        ])
    }
    
    // MARK:- Private functions
    static func makeAttributedButtonTitle(greenText: String, grayText: String) -> NSMutableAttributedString {
        let attributedTitle = NSMutableAttributedString(string: greenText, attributes:
            [NSAttributedString.Key.font: UIFont.systemFont(ofSize: 16),
            NSAttributedString.Key.foregroundColor: UIColor.setAsRgb(red: 14, green: 186, blue: 129)])
        let grayText = NSAttributedString(string: grayText, attributes: [NSAttributedString.Key.foregroundColor:UIColor.lightGray,
            NSAttributedString.Key.font: UIFont.systemFont(ofSize: 16)])
        
        attributedTitle.append(grayText)
        
        return attributedTitle
    }

    
    // MARK:- Objc methods
    @objc func handleSignUpButton() {
        let signUpViewController = SignUpViewController()
        navigationController?.pushViewController(signUpViewController, animated: true)
    }
}
