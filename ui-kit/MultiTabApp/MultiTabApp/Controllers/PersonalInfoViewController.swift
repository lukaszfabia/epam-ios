//
//  PersonalInfoViewController.swift
//  MultiTabApp
//
//  Created by Lukasz Fabia on 14/06/2025.
//

import UIKit

class PersonalInfoViewController: BaseViewController {
    var name: String = "Personal Info"
    
    private let formContainer = UIView()
    private let nameField = UITextField()
    private let phoneField = UITextField()
    private let confirmButton = UIButton()
    private let nameLabel = UILabel()
    private let phoneLabel = UILabel()

    
    private var keyboard: KeyboardHandler?
    private var bottom: NSLayoutConstraint!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = name
        
        setupTextFields()
        setupConfirmButton()
        setupFormContainer()
        
        setupGestures()
        
        defaultValuesIfExists()
        
        
        keyboard = KeyboardHandler(fn: {height in
            self.bottom.constant = -height
            self.view.layoutIfNeeded()
        })
        
        enableButton(false)
    }
    
    // For keybaord
    private func setupGestures() {
        view.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(endEditing)))
    }
    
    @objc private func endEditing() {
        view.endEditing(true)
    }
    
    private func setupFormContainer() {
        view.addSubview(formContainer)
        
        formContainer.addSubview(nameField)
        formContainer.translatesAutoresizingMaskIntoConstraints = false
        bottom = confirmButton.bottomAnchor.constraint(equalTo: formContainer.bottomAnchor)
        
        NSLayoutConstraint.activate([
            formContainer.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            formContainer.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 20),
            formContainer.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -20),
            bottom,
            
            nameLabel.topAnchor.constraint(equalTo: formContainer.topAnchor, constant: 12),
            nameLabel.leadingAnchor.constraint(equalTo: formContainer.leadingAnchor),
            nameLabel.trailingAnchor.constraint(equalTo: formContainer.trailingAnchor),
            
            nameField.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: 4),
            nameField.leadingAnchor.constraint(equalTo: formContainer.leadingAnchor),
            nameField.trailingAnchor.constraint(equalTo: formContainer.trailingAnchor),

            phoneLabel.topAnchor.constraint(equalTo: nameField.bottomAnchor, constant: 12),
            phoneLabel.leadingAnchor.constraint(equalTo: formContainer.leadingAnchor),
            phoneLabel.trailingAnchor.constraint(equalTo: formContainer.trailingAnchor),
            
            phoneField.topAnchor.constraint(equalTo: phoneLabel.bottomAnchor, constant: 4),
            phoneField.leadingAnchor.constraint(equalTo: formContainer.leadingAnchor),
            phoneField.trailingAnchor.constraint(equalTo: formContainer.trailingAnchor),

            confirmButton.topAnchor.constraint(equalTo: phoneField.bottomAnchor, constant: 20),
            confirmButton.centerXAnchor.constraint(equalTo: formContainer.centerXAnchor),
            confirmButton.widthAnchor.constraint(equalTo: formContainer.widthAnchor, multiplier: 0.5),
            confirmButton.heightAnchor.constraint(equalToConstant: 50)
        ])

    }
    
    private func setupConfirmButton() {
        formContainer.addSubview(confirmButton)
        confirmButton.setTitle("Confirm", for: .normal)
        confirmButton.setTitleColor(.white, for: .normal)
        confirmButton.backgroundColor = .systemIndigo
        confirmButton.titleLabel?.font = .systemFont(ofSize: 20, weight: .medium)
        confirmButton.layer.cornerRadius = 20
        
        confirmButton.addTarget(self, action: #selector(confirm), for: .touchUpInside)
        
        confirmButton.translatesAutoresizingMaskIntoConstraints = false
    }
    
    private func defaultValuesIfExists() {
        let name = Session.shared.temporaryUser.name ?? ""
        nameField.text = name
        
        let phone = Session.shared.temporaryUser.phone ?? ""
        phoneField.text = phone
    }
    
    
    private func setupTextFields() {
        formContainer.addSubview(nameLabel)
        formContainer.addSubview(nameField)
        formContainer.addSubview(phoneLabel)
        formContainer.addSubview(phoneField)

        nameLabel.text = "Name"
        nameLabel.font = .systemFont(ofSize: 16, weight: .medium)
        
        phoneLabel.text = "Phone"
        phoneLabel.font = .systemFont(ofSize: 16, weight: .medium)

        nameField.placeholder = "Joe Doe"
        phoneField.placeholder = "eg. 999243566"
        phoneField.borderStyle = .roundedRect
        nameField.borderStyle = .roundedRect
        phoneField.keyboardType = .phonePad
        
        // actions
        nameField.addTarget(self, action: #selector(onChange), for: .editingChanged)
        phoneField.addTarget(self, action: #selector(onChange), for: .editingChanged)


        nameLabel.translatesAutoresizingMaskIntoConstraints = false
        nameField.translatesAutoresizingMaskIntoConstraints = false
        phoneLabel.translatesAutoresizingMaskIntoConstraints = false
        phoneField.translatesAutoresizingMaskIntoConstraints = false
    }

    @objc func onChange() {
        let nameIsValid = Validator.validateName(name: nameField.text ?? "")
        let phoneIsValid = Validator.validatePhone(number: phoneField.text ?? "")
        
        changeBorders(fields: [nameField], success: nameIsValid)
        changeBorders(fields: [phoneField], success: phoneIsValid)
        
        enableButton(nameIsValid && phoneIsValid)
    }

    
    @objc func confirm() {
        guard
            let phone = phoneField.text,
            let name = nameField.text else {return}
        
        Session.shared.temporaryUser.setUserDetails(name: name, phone: phone)
        
        createConfirmationAlert(for: name, with: phone)
    }
    
    private func createConfirmationAlert(for name: String, with phone: String) {
        let message = "Please confirm your name and phone number. Name: \(name), Phone: \(phone)."
        
        let alert = UIAlertController(title: "Confirm Information", message: message, preferredStyle: .alert)
        
        alert.addAction(UIAlertAction(title: "Confirm", style: .default, handler: { [weak self] _ in
            
            
            let next = PreferencesViewController()
            self?.navigationController?.title = next.name
            self?.navigationController?.pushViewController(next, animated: true)
        }))
        
        alert.addAction(UIAlertAction(title: "Edit", style: .cancel))
        
        present(alert, animated: true)
    }

    
    private func changeBorders(fields: [UITextField], success: Bool = true) {
        fields.forEach { field in
            field.layer.borderColor = success ? UIColor.green.cgColor : UIColor.red.cgColor
            field.layer.borderWidth = 1.0
            field.layer.cornerRadius = 8
        }
    }
    
    private func enableButton(_ valid: Bool) {
        confirmButton.isUserInteractionEnabled = valid
        confirmButton.backgroundColor = valid ? .systemIndigo : .systemGray
    }
    
}
