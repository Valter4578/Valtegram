//
//  ViewController.swift
//  Valtegram
//
//  Created by Максим Алексеев on 08.03.2020.
//  Copyright © 2020 Максим Алексеев. All rights reserved.
//

import UIKit
import Firebase


class ViewController: UIViewController {

    let photoPlusButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(named: "add"), for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    let emailTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "Email"
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.borderStyle = .roundedRect
        
        textField.addTarget(self, action: #selector(handleTextInputChange), for: .editingChanged)
        
        return textField
    }()

    
    let usernameTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "Username"
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.borderStyle = .roundedRect
        
        textField.addTarget(self, action: #selector(handleTextInputChange), for: .editingChanged)

        
        return textField
    }()
    
    let passwordTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "Password"
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.borderStyle = .roundedRect
        textField.isSecureTextEntry = true
        
        textField.addTarget(self, action: #selector(handleTextInputChange), for: .editingChanged)

        
        return textField
    }()

    
    let signUpButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Sign up", for: .normal)
        button.setTitleColor(UIColor.white, for: .normal)
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 17)
        button.backgroundColor = UIColor.setAsRgb(red: 27, green: 67, blue: 51)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.layer.cornerRadius = 8
        button.isEnabled = false
        
        button.addTarget(self, action: #selector(signUpTouched), for: .touchUpInside)
        
        return button
    }()

    // MARK:- Lifecycle yteiuytfghg
    override func viewDidLoad() {
        super.viewDidLoad()

        setupAddPhotoButton()
        setupTextFields()
        
        
    }
    
    private func setupTextFields() {
        
        let stackView = UIStackView(arrangedSubviews: [emailTextField, usernameTextField, passwordTextField, signUpButton ])
        stackView.distribution = .fillEqually
        stackView.spacing = 15
        stackView.axis = .vertical
        stackView.translatesAutoresizingMaskIntoConstraints = false
        
        view.addSubview(stackView)
        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: photoPlusButton.bottomAnchor, constant: 20),
            stackView.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 40),
            stackView.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -40),
            stackView.heightAnchor.constraint(equalToConstant: 200),
        ])
    }
    
    private func setupAddPhotoButton() {
        view.addSubview(photoPlusButton)

        photoPlusButton.heightAnchor.constraint(equalToConstant: 100).isActive = true
            photoPlusButton.widthAnchor.constraint(equalToConstant: 100).isActive = true
            photoPlusButton.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
            photoPlusButton.topAnchor.constraint(equalTo: view.topAnchor, constant: 50).isActive = true
        
        
    }

    
    // MARK:- Selectors
    @objc func signUpTouched() {

        guard let email = emailTextField.text else { return }
        guard let password = passwordTextField.text else { return }
        guard let username = usernameTextField.text else { return }
        
        Auth.auth().createUser(withEmail: email, password: password) { (result, error) in
            if let err = error {
                let alertController = UIAlertController(title: "Error", message: err.localizedDescription, preferredStyle: .alert)
                let alertAction = UIAlertAction(title: "OK", style: .cancel)
                alertController.addAction(alertAction)
                self.present(alertController, animated: true, completion: nil)
                return
            }
            
            print("User created ", result?.user.uid)
        }
    }
    
    @objc func handleTextInputChange() {
        let isFormValid = emailTextField.text?.count ?? 0 > 0 && usernameTextField.text?.count ?? 0 > 0 && passwordTextField.text?.count ?? 0 > 0
        
        if isFormValid {
            signUpButton.backgroundColor = UIColor.setAsRgb(red: 27, green: 67, blue: 51)
            signUpButton.isEnabled = true
        } else {
            signUpButton.backgroundColor = UIColor.setAsRgb(red: 78, green: 132, blue: 110)
            signUpButton.isEnabled = false 
        }
    }

}

