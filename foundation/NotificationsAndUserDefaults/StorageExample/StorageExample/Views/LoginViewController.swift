//
//  ViewController.swift
//  StorageExample
//
//  Created by Lukasz Fabia on 16/07/2025.
//

import UIKit
import Foundation

class LoginViewController: UIViewController {
    
    private let loginViewModel: LoginViewModel
    
    init(loginViewModel: LoginViewModel) {
        self.loginViewModel = loginViewModel
        
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private let vStack: UIStackView = {
        let stack = UIStackView()
        
        stack.axis = .vertical
        
        stack.spacing = 15
        stack.alignment = .fill
        stack.distribution = .fill
        
        stack.translatesAutoresizingMaskIntoConstraints = false
        
        return stack
    }()
    
    private let passwordField: UITextField = {
        let field = UITextField()
        field.borderStyle = .roundedRect
        field.isSecureTextEntry = true
        field.clearButtonMode = .always
        field.textContentType = .password
        field.placeholder = "Password"
        field.setContentHuggingPriority(.required, for: .vertical)
        field.setContentCompressionResistancePriority(.required, for: .vertical)
        return field
    }()
    
    private let emailField: UITextField = {
        let field = UITextField()
        field.borderStyle = .roundedRect
        field.clearButtonMode = .always
        field.placeholder = "Email"
        field.keyboardType = .emailAddress
        field.textContentType = .emailAddress
        field.setContentHuggingPriority(.required, for: .vertical)
        field.setContentCompressionResistancePriority(.required, for: .vertical)
        return field
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        navigationItem.rightBarButtonItem = .init(title: "Login", style: .plain, target: self, action: #selector(handleLogin))
        navigationItem.rightBarButtonItem?.isEnabled = false
        
        setupUI()
        setupHandlers()
        setupDelegates()
        setupGestures()
    }
    
    //MARK: setups
    
    private func setupHandlers() {
        emailField.addTarget(self, action: #selector(validateFields), for: .editingChanged)
        passwordField.addTarget(self, action: #selector(validateFields), for: .editingChanged)
    }
    
    private func setupDelegates() {
        passwordField.delegate = self
        emailField.delegate = self
    }
    
    private func setupGestures() {
        view.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(endEditing)))
    }
    
    
    private func setupUI(){
        view.addSubview(vStack)
    
        vStack.addArrangedSubview(emailField)
        vStack.addArrangedSubview(passwordField)
        
        
        NSLayoutConstraint.activate([
            vStack.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 16),
            vStack.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -16),
            vStack.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 16),
        ])
        
    }
    
}

// Actions etc.
extension LoginViewController {
    @objc private func handleLogin() {
        guard
            let password = passwordField.text,
            let email = emailField.text
        else {return}
        
        loginViewModel.login(email: email, password: password)
        
        guard let window = view.window else {return}
        
        window.rootViewController = LoggedInTabBarController(storage: loginViewModel.storage, session: loginViewModel.session)
        
        UIView.transition(with: window, duration: 0.3, options: .transitionCrossDissolve, animations: nil)
        
    }
    
    @objc private func validateFields() {
        navigationItem.rightBarButtonItem?.isEnabled =
        loginViewModel.isPasswordValid(passwordField.text)
        &&
        loginViewModel.isEmailValid(emailField.text)
    }
    
    
    @objc private func endEditing() {
        view.endEditing(true)
    }
}


extension LoginViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if textField == emailField {
            passwordField.becomeFirstResponder()
        } else {
            textField.resignFirstResponder()
        }
        return true
    }

}
