//
//  Task3ViewController.swift
//  AutolatoutPracticalTasks
//
//  Created by Kakhaberi Kiknadze on 20.03.25.
//

import UIKit
import Combine

// Lay out login screen as in the attached screen recording.
// 1. Content should respect safe area guides
// 2. Content should be visible on all screen sizes
// 3. Content should be spaced on bottom as in the recording
// 4. When keyboard appears, content should move up
// 5. When you tap the screen and keyboard gets dismissed, content should move down
// 6. You can use container views/layout guides or any option you find useful
// 7. Content should have horizontal spacing of 16
// 8. Title and description labels should have a vertical spacing of 12 from each other
// 9. Textfields should have a spacing of 40 from top labels
// 10. Login button should have 16 spacing from textfields
final class Task3ViewController: UIViewController {
    // FOR ME
    // hanlding keyboard: https://github.com/jrasmusson/ios-professional-course/blob/main/Password-Reset/7-Dealing-Keyboards/README.md
    
    private let titleLabel = UILabel()
    private let bodyLabel = UILabel()
    private let usernameField = UITextField()
    private let passwordField = UITextField()
    private let logInButton = UIButton()

    private let contentView = UIView()
    
    private struct Config {
        let duration: Double
        let keyboardHeight: CGFloat
    }
    
    /// for moving container up and down when keyboard shows and disappears
    private var contentViewBottom: NSLayoutConstraint!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupView()
        setupGestures()
        setupKeyboardNotifications()
    }
    
    private func setupGestures() {
        view.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(endEditing)))
    }
    
    @objc private func endEditing() {
        view.endEditing(true)
    }
    
    private func setupKeyboardNotifications() {
        // observe showing keyboard
        NotificationCenter.default.addObserver(
            self, // listen on my Task3VC
            selector: #selector(keyboardWillShow(notification:)), // handler
            name: UIResponder.keyboardWillShowNotification, // name of the event
            object: nil // every keyboard
        )
        
        // observe hide event
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(keyboardWillHide(notification:)),
            name: UIResponder.keyboardWillHideNotification,
            object: nil
        )
    }
    
    private func getKeyboardConfig(_ n: Notification) -> Config? {
        // get user info
        guard let userInfo = n.userInfo else {return nil}
        
        // get keyboard props
        guard let keyboardFrame = userInfo[UIResponder.keyboardFrameEndUserInfoKey] as? CGRect else {return nil}
        
        // get animation duration
        guard let duration = userInfo[UIResponder.keyboardAnimationDurationUserInfoKey] as? Double
        else {return nil}
        
        return Config(duration: duration, keyboardHeight: keyboardFrame.height)
    }
    
    @objc private func keyboardWillShow(notification: Notification) {
        guard let config = getKeyboardConfig(notification) else {return}

        UIView.animate(withDuration: config.duration) {
            self.contentViewBottom.constant = -config.keyboardHeight
            self.view.layoutIfNeeded()
        }

    }
    
    @objc private func keyboardWillHide(notification: Notification) {
        guard let config = getKeyboardConfig(notification) else {return}

        UIView.animate(withDuration: config.duration) {
            self.contentViewBottom.constant = 0
            self.view.layoutIfNeeded()
        }
    }
    
    private func setupView() {
        setupLabels()
        setupTextFields()
        setupButton()
        setupContainerView()
    }
    
    private func setupContainerView() {
        view.addSubview(contentView)
//        contentView.backgroundColor = .gray   //debug
        contentView.translatesAutoresizingMaskIntoConstraints = false
        
        // init pos
        contentViewBottom = contentView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        
        NSLayoutConstraint.activate([
            contentViewBottom,
            contentView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 16),
            contentView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -16)
        ])
    }
    
    private func setupLabels() {
        contentView.addSubview(titleLabel)
        contentView.addSubview(bodyLabel)
        
        titleLabel.text = "Sign In"
        titleLabel.font = .boldSystemFont(ofSize: 32)
        bodyLabel.numberOfLines = 3
        bodyLabel.text = """
        Lorem ipsum dolor sit amet, consectetur adipiscing elit,
        sed do eiusmod tempor incididunt ut labore
        """
        
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        bodyLabel.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: contentView.topAnchor),
            titleLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            titleLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            
            bodyLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 12),
            bodyLabel.leadingAnchor.constraint(equalTo: titleLabel.leadingAnchor),
            bodyLabel.trailingAnchor.constraint(equalTo: titleLabel.trailingAnchor),
        ])
    }
    
    private func setupTextFields() {
        contentView.addSubview(usernameField)
        contentView.addSubview(passwordField)
        
        usernameField.placeholder = "Enter username"
        passwordField.placeholder = "Enter password"
        usernameField.borderStyle = .roundedRect
        passwordField.borderStyle = .roundedRect
        
        usernameField.translatesAutoresizingMaskIntoConstraints = false
        passwordField.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            usernameField.topAnchor.constraint(equalTo: bodyLabel.bottomAnchor, constant: 40),
            usernameField.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            usernameField.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            
            passwordField.topAnchor.constraint(equalTo: usernameField.bottomAnchor, constant: 12),
            passwordField.leadingAnchor.constraint(equalTo: usernameField.leadingAnchor),
            passwordField.trailingAnchor.constraint(equalTo: usernameField.trailingAnchor),
        ])
    }
    
    private func setupButton() {
        contentView.addSubview(logInButton)
        
        logInButton.setTitle("Log In", for: .normal)
        logInButton.setTitleColor(.tintColor, for: .normal)
        
        logInButton.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            logInButton.topAnchor.constraint(equalTo: passwordField.bottomAnchor, constant: 16),
            logInButton.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            logInButton.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
        ])
    }
    
    deinit {
        // clean up our observers 
        NotificationCenter.default.removeObserver(self)
    }
}

#Preview {
    Task3ViewController()
}
