//
//  ProfileViewController.swift
//  MultiTabApp
//
//  Created by Lukasz Fabia on 14/06/2025.
//

import Foundation
import UIKit

class ProfileViewController: BaseViewController {
    var name : String = "Profile"
    private let editButton = UIButton()
    private let nameLabel = UILabel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = name
        setupNavigationButtons()
        setupLabel()
        setupButton()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        print("[ProfileViewController]: viewWillAppear")
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        print("[ProfileViewController]: viewDidAppear")
    }

    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        print("[ProfileViewController]: viewWillLayoutSubviews")
    }

    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        print("[ProfileViewController]: viewDidLayoutSubviews")
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        print("[ProfileViewController]: viewWillDisappear")
    }

    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        print("[ProfileViewController]: viewDidDisappear")
    }
    
    private func setupNavigationButtons() {
        let editNameButton = UIBarButtonItem(
            image: UIImage(systemName: "pencil.slash"),
            style: .plain,
            target: self,
            action: #selector(promptForNewName)
        )
        
        let anonymousButton = UIBarButtonItem(
            image: UIImage(systemName: "person.crop.circle.fill"),
            style: .plain,
            target: self,
            action: #selector(setAnonymousName)
        )
        
        navigationItem.rightBarButtonItems = [anonymousButton, editNameButton]
    }
    
    @objc private func promptForNewName() {
        let alert = UIAlertController(title: "Edit Name", message: "Enter a new username", preferredStyle: .alert)
        
        alert.addTextField { textField in
            textField.placeholder = "New name"
        }
        
        let confirmAction = UIAlertAction(title: "OK", style: .default) { [weak self] _ in
            guard let self = self else { return }
            let newName = alert.textFields?.first?.text?.trimmingCharacters(in: .whitespacesAndNewlines)
            if let name = newName, !name.isEmpty {
                self.nameLabel.text = name
                Session.user.name = name
            } else {
                self.nameLabel.text = "Default"
            }
        }
        
        alert.addAction(confirmAction)
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel))
        
        present(alert, animated: true)
    }

    @objc private func setAnonymousName() {
        nameLabel.text = "Anonymous"
        Session.user.clearMe()
    }

    
    private func setupButton() {
        view.addSubview(editButton)
        editButton.translatesAutoresizingMaskIntoConstraints = false
        
        editButton.setTitle("Edit profile", for: .normal)
        editButton.addTarget(self, action: #selector(navigateToEditProfile), for: .touchUpInside)
        editButton.setTitleColor(.white, for: .normal)
        
        editButton.backgroundColor = .systemIndigo
        editButton.layer.cornerRadius = 12
        
        NSLayoutConstraint.activate([
            editButton.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: 20),
            editButton.centerXAnchor.constraint(equalTo: view.centerXAnchor, constant: 20),
            editButton.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.5),
            editButton.heightAnchor.constraint(equalToConstant: 60),
        ])
    }

    @objc private func navigateToEditProfile() {
        let next = EditProfileViewController()
        
        navigationController?.title = next.name
        
        navigationController?.pushViewController(next, animated: true)
    }
    
    private func setupLabel() {
        view.addSubview(nameLabel)
        nameLabel.translatesAutoresizingMaskIntoConstraints = false
        
        nameLabel.text = Session.user.name ?? "Default"
        
        nameLabel.font = .systemFont(ofSize: 40, weight: .heavy)
        
        NSLayoutConstraint.activate([
            nameLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20),
            nameLabel.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 20),
        ])
        
    }
}
