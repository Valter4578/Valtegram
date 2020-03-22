//
//  LogInViewController.swift
//  Valtegram
//
//  Created by Максим Алексеев on 16.03.2020.
//  Copyright © 2020 Максим Алексеев. All rights reserved.
//

import UIKit
import Firebase

class LogInViewController: UIViewController, LoginViewInput {

    
    // MARK:- Properties
    var presenter: LoginViewOutput!
    
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
    
    
    lazy var emailTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "Email"
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.borderStyle = .roundedRect
        textField.addTarget(self, action: #selector(handleTextInputChange), for: .editingChanged)
        return textField
    }()
    
    lazy var passwordTextField: UITextField = {
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
        button.addTarget(self, action: #selector(handleLoginButton), for: .touchUpInside)
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

    private func showErrorAlert(with errorText: String) {
        let alertController = UIAlertController(title: "Error", message: errorText, preferredStyle: .alert)
        let alertAction = UIAlertAction(title: "OK", style: .cancel)
        alertController.addAction(alertAction)
        self.present(alertController, animated: true, completion: nil)
        
        print(errorText)
    }
    
    // MARK:- Objc methods
    @objc func handleSignUpButton() {
        let signUpViewController = SignUpViewController()
        navigationController?.pushViewController(signUpViewController, animated: true)
    }
    
    @objc func handleTextInputChange() {
        let isFormValid = emailTextField.text?.count ?? 0 > 0 && passwordTextField.text?.count ?? 0 > 0
        
        if isFormValid {
            logInButton.backgroundColor = UIColor.setAsRgb(red: 27, green: 67, blue: 51)
            logInButton.isEnabled = true
        } else {
            logInButton.backgroundColor = UIColor.setAsRgb(red: 78, green: 132, blue: 110)
            logInButton.isEnabled = false
        }
    }
    
    @objc func handleLoginButton() {
        guard let email = emailTextField.text else { return }
        guard let password = passwordTextField.text else { return }
//        Auth.auth().signIn(withEmail: email, password: password) { (result, error) in
//            if let err = error {
//                self.showErrorAlert(with: err.localizedDescription)
//            }
//
//            print("Succssesfuly loged in with user: ", result?.user.uid ?? "")
//            // Update ui
//            guard let tabBarVC = UIApplication.shared.keyWindow?.rootViewController as? TabBarController else { return }
//            tabBarVC.setupViewControllers()
//            self.dismiss(animated: true, completion: nil)
//        }
        
        presenter.didPressLogin(email: email, password: password)
    }
    
    // MARK:- LoginViewInput
    
    func cancel(_ animated: Bool) {
        dismiss(animated: animated, completion: nil)
    }
}
