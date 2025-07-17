//
//  ViewController.swift
//  Keyboard
//
//  Created by Lukasz Fabia on 15/07/2025.
//

import UIKit

class ViewController: UIViewController {
    
    private var keyboard: KeyboardHandler?
    private var bottom: NSLayoutConstraint!
    
    
    private let vStack: UIStackView = {
        let stack = UIStackView()
        stack.axis = .vertical
        
        stack.spacing = 6
        stack.distribution = .fillEqually
        stack.alignment = .fill
        
        stack.translatesAutoresizingMaskIntoConstraints = false
        return stack
    }()
    
    private let nameField: UITextField =  {
        let field = UITextField()
        field.placeholder = "Name"
        field.borderStyle = .roundedRect
        return field
    }()
    
    private let promptLabel: UILabel = {
        let label = UILabel()
        label.font = .boldSystemFont(ofSize: 25)
        label.textColor = .label
        label.text = "Hello!"
        
        return label
    }()
    
    private let saveButton: UIButton = {
        var config = UIButton.Configuration.filled()
        
        config.baseBackgroundColor = .systemIndigo
        config.baseForegroundColor = .white
        
        config.cornerStyle = .capsule
        
        let button = UIButton(configuration: config)
        button.setImage(UIImage(systemName: "arrow.right"), for: .normal)

        
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        view.backgroundColor = .systemBackground
        
        setupUI()
        setupHandlers()
        setupGestures()
        
        nameField.delegate = self
        
        keyboard = KeyboardHandler(fn: {height in
            self.bottom.constant = -height
            self.view.layoutIfNeeded()
        })
    }
    
    private func setupGestures() {
        view.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(endEditing)))
    }
    
    @objc private func endEditing() {
        view.endEditing(true)
    }
    
    private func setupHandlers() {
        saveButton.addTarget(self, action: #selector(saveFromTextField), for: .touchUpInside)
    }
    
    @objc private func saveFromTextField(_ sender: UIButton) {
        guard let text = nameField.text else {return}
        
        UIView.animate(withDuration: 0.3) {
            self.promptLabel.text = "Hello \(text)!"
            self.nameField.text = ""
            self.promptLabel.layoutIfNeeded()
        }
    }
    
    private func setupUI() {
        view.addSubview(vStack)
        
        vStack.addArrangedSubview(promptLabel)
        vStack.addArrangedSubview(nameField)
        vStack.addArrangedSubview(saveButton)
        
        bottom = vStack.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        
        
        NSLayoutConstraint.activate([
            vStack.topAnchor.constraint(greaterThanOrEqualTo: view.safeAreaLayoutGuide.topAnchor, constant: 20),
            vStack.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 10),
            vStack.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -10),
            bottom,
        ])
    }
}



extension ViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        
        return true
    }
}
