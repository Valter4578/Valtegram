//
//  SignUpViewController.swift
//  Valtegram
//
//  Created by Максим Алексеев on 08.03.2020.
//  Copyright © 2020 Максим Алексеев. All rights reserved.
//

import UIKit

class SignUpViewController: UIViewController {
    // MARK:- Properties
    var presenter: SignUpPresenter!
    
    // MARK:- Private properties
    private var username: String?
    private var email: String?
    private var password: String?
    
    // MARK:- Views
    let photoPlusButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(named: "add"), for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        
        button.addTarget(self, action: #selector(photoPlusButtonTapped), for: .touchUpInside)
        
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
        button.backgroundColor = UIColor.setAsRgb(red: 14, green: 186, blue: 129)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.layer.cornerRadius = 8
        button.isEnabled = false
        
        button.addTarget(self, action: #selector(signUpTouched), for: .touchUpInside)
        
        return button
    }()
    
    lazy var loginButton: UIButton = {
        let button = UIButton(type: .system)
        button.translatesAutoresizingMaskIntoConstraints = false
        
        let attributedString = LogInViewController.makeAttributedButtonTitle(greenText: "Login ", grayText: "if you have account")
        button.setAttributedTitle(attributedString, for: .normal)
        
        button.addTarget(self, action: #selector(handleLoginButton), for: .touchUpInside)
        return button
    }()

    // MARK:- Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white

        setupAddPhotoButton()
        setupTextFields()
        setupLoginButton()
        
        
    }
    
    // MARK:- Setups
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

        NSLayoutConstraint.activate([
            photoPlusButton.heightAnchor.constraint(equalToConstant: 100),
            photoPlusButton.widthAnchor.constraint(equalToConstant: 100),
            photoPlusButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            photoPlusButton.topAnchor.constraint(equalTo: view.topAnchor, constant: 50),
        ])
    }
    
    private func setupLoginButton() {
        view.addSubview(loginButton)
        
        NSLayoutConstraint.activate([
            loginButton.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 0),
            loginButton.rightAnchor.constraint(equalTo: view.rightAnchor, constant: 0),
            loginButton.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -40),
            loginButton.heightAnchor.constraint(equalToConstant: 45),
        ])
    }

    // MARK:- Private methods 
    private func showErrorAlert(with errorText: String) {
        let alertController = UIAlertController(title: "Error", message: errorText, preferredStyle: .alert)
        let alertAction = UIAlertAction(title: "OK", style: .cancel)
        alertController.addAction(alertAction)
        self.present(alertController, animated: true, completion: nil)
        
        print(errorText)
    }
        
    // MARK:- Selectors
    @objc func signUpTouched() {

        email = emailTextField.text
        password = passwordTextField.text
        username = usernameTextField.text
        
        guard let image = self.photoPlusButton.imageView?.image else { return }
        guard let data = image.jpegData(compressionQuality: 0.2) else { return }
        
        
        guard let mail = email else { return }
        guard let password = password else { return }
        guard let usrName = username else { return }
        
        presenter.createUser(email: mail, password: password, imageToUpload: image, data: data, username: usrName)
        
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

    @objc func photoPlusButtonTapped() {
        let imagePickerController = UIImagePickerController()
        imagePickerController.delegate = self
        imagePickerController.allowsEditing = true
        
        present(imagePickerController, animated: true, completion: nil)
        
    }
    
    @objc func handleLoginButton() {
        navigationController?.popViewController(animated: true)
    }
}

extension SignUpViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let editedImage = info[.editedImage]as? UIImage {
            photoPlusButton.setImage(editedImage, for: .normal)
        } else if let originalImage = info[.originalImage] as? UIImage {
            photoPlusButton.setImage(originalImage, for: .normal)
        }
                
        photoPlusButton.layer.cornerRadius = photoPlusButton.frame.width/2
        photoPlusButton.layer.masksToBounds = true
        
        dismiss(animated: true, completion: nil)
    }
}
