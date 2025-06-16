//
//  ConfirmDetailsViewController.swift
//  MultiTabApp
//
//  Created by Lukasz Fabia on 15/06/2025.
//


import Foundation
import UIKit

class ConfirmDetailsViewController: BaseViewController {
    var name: String = "Profile Information"

    private let container = UIView()
    private let buttonsContainer = UIView()

    private let nameLabel = UILabel()
    private let phoneLabel = UILabel()
    private let preferenceInfoLabel = UILabel()
    private let preferenceLabel = UILabel()

    private let restart = UIButton(type: .system)
    private let editPersonalInfo = UIButton(type: .system)
    private let editPreferences = UIButton(type: .system)

    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = name
        
        disableBack()
        setupConfirmButton()
        setupContainer()
        setupButtonContainer()
        setupLabels()
        setupConstrainsForElements()
        setupEditButtons()
        setupRestartProcessButton()
    }

    private func setupConfirmButton() {
        let confirm = UIBarButtonItem(title: "Confirm", style: .done, target: self, action: #selector(confirmNavigation))
        navigationItem.rightBarButtonItem = confirm
    }

    @objc private func confirmNavigation() {
        let successAlert = UIAlertController(
            title: "Success",
            message: "Congrats! \(Session.shared.temporaryUser.name ?? ""), successfully passed onboarding process.",
            preferredStyle: .alert
        )

        successAlert.addAction(UIAlertAction(title: "Cancel", style: .cancel))
        successAlert.addAction(UIAlertAction(title: "OK", style: .default, handler: { _ in
            Session.shared.create()
            
            let start = OnboardingViewController()
            self.navigationController?.setViewControllers([start], animated: true)
        }))

        present(successAlert, animated: true)
    }

    private func disableBack() {
        navigationItem.hidesBackButton = true
        navigationController?.interactivePopGestureRecognizer?.isEnabled = false
    }

    private func setupContainer() {
        view.addSubview(container)
        container.translatesAutoresizingMaskIntoConstraints = false

        container.layer.cornerRadius = 12
        container.backgroundColor = .systemGray6
        container.layer.shadowColor = UIColor.black.cgColor
        container.layer.shadowOpacity = 0.2
        container.layer.shadowOffset = CGSize(width: 0, height: 4)
        container.layer.shadowRadius = 6

        NSLayoutConstraint.activate([
            container.centerYAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerYAnchor, constant: -100),
            container.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 20),
            container.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -20),
        ])
    }

    private func setupButtonContainer() {
        view.addSubview(buttonsContainer)
        buttonsContainer.translatesAutoresizingMaskIntoConstraints = false

        buttonsContainer.layer.cornerRadius = 12
        buttonsContainer.backgroundColor = .systemGray6
        buttonsContainer.layer.shadowColor = UIColor.black.cgColor
        buttonsContainer.layer.shadowOpacity = 0.2
        buttonsContainer.layer.shadowOffset = CGSize(width: 0, height: 4)
        buttonsContainer.layer.shadowRadius = 6

        NSLayoutConstraint.activate([
            buttonsContainer.topAnchor.constraint(equalTo: container.bottomAnchor, constant: 20),
            buttonsContainer.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 20),
            buttonsContainer.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -20),
            buttonsContainer.heightAnchor.constraint(equalToConstant: 140)
        ])
    }

    private func setupLabels() {
        [nameLabel, phoneLabel, preferenceInfoLabel, preferenceLabel].forEach {
            $0.translatesAutoresizingMaskIntoConstraints = false
            container.addSubview($0)
        }

        nameLabel.text = Session.shared.temporaryUser.name
        nameLabel.font = .systemFont(ofSize: 25, weight: .bold)
        nameLabel.textColor = .systemGray
        nameLabel.textAlignment = .left

        phoneLabel.text = Session.shared.temporaryUser.phone
        phoneLabel.font = .systemFont(ofSize: 16, weight: .light)
        phoneLabel.textColor = .systemGray
        phoneLabel.textAlignment = .left

        preferenceInfoLabel.text = "Notifications by"
        preferenceInfoLabel.font = .systemFont(ofSize: 16, weight: .light)
        preferenceInfoLabel.textColor = .systemGray
        preferenceInfoLabel.textAlignment = .left

        preferenceLabel.text = Session.shared.temporaryUser.preferences?.name ?? "None"
        preferenceLabel.font = .systemFont(ofSize: 16, weight: .heavy)
        preferenceLabel.textColor = .systemGray
        preferenceLabel.textAlignment = .left
    }

    private func setupConstrainsForElements() {
        NSLayoutConstraint.activate([
            nameLabel.topAnchor.constraint(equalTo: container.topAnchor, constant: 20),
            nameLabel.leadingAnchor.constraint(equalTo: container.leadingAnchor, constant: 20),
            nameLabel.trailingAnchor.constraint(equalTo: container.trailingAnchor, constant: -20),

            phoneLabel.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: 10),
            phoneLabel.leadingAnchor.constraint(equalTo: nameLabel.leadingAnchor),
            phoneLabel.trailingAnchor.constraint(equalTo: nameLabel.trailingAnchor),

            preferenceInfoLabel.topAnchor.constraint(equalTo: phoneLabel.bottomAnchor, constant: 20),
            preferenceInfoLabel.leadingAnchor.constraint(equalTo: nameLabel.leadingAnchor),
            preferenceInfoLabel.trailingAnchor.constraint(equalTo: nameLabel.trailingAnchor),

            preferenceLabel.topAnchor.constraint(equalTo: preferenceInfoLabel.bottomAnchor, constant: 5),
            preferenceLabel.leadingAnchor.constraint(equalTo: nameLabel.leadingAnchor),
            preferenceLabel.trailingAnchor.constraint(equalTo: nameLabel.trailingAnchor),
            preferenceLabel.bottomAnchor.constraint(equalTo: container.bottomAnchor, constant: -20)
        ])
    }

    private func setupRestartProcessButton() {
        buttonsContainer.addSubview(restart)
        restart.translatesAutoresizingMaskIntoConstraints = false
        restart.setTitle("Start over", for: .normal)
        restart.setTitleColor(.white, for: .normal)
        restart.backgroundColor = .systemRed
        restart.layer.cornerRadius = 12

        restart.addTarget(self, action: #selector(restartProcess), for: .touchUpInside)

        NSLayoutConstraint.activate([
            restart.bottomAnchor.constraint(equalTo: buttonsContainer.bottomAnchor, constant: -10),
            restart.leadingAnchor.constraint(equalTo: buttonsContainer.leadingAnchor, constant: 10),
            restart.trailingAnchor.constraint(equalTo: buttonsContainer.trailingAnchor, constant: -10),
            restart.heightAnchor.constraint(equalToConstant: 44)
        ])
    }

    private func setupEditButtons() {
        [editPreferences, editPersonalInfo].forEach {
            buttonsContainer.addSubview($0)
            $0.translatesAutoresizingMaskIntoConstraints = false
            $0.setTitleColor(.white, for: .normal)
            $0.backgroundColor = .systemIndigo
            $0.layer.cornerRadius = 12
        }

        editPreferences.setTitle("Edit preferences", for: .normal)
        editPersonalInfo.setTitle("Edit personal info", for: .normal)

        editPreferences.addTarget(self, action: #selector(gotoEditPreferences), for: .touchUpInside)
        editPersonalInfo.addTarget(self, action: #selector(gotoEditProfile), for: .touchUpInside)

        NSLayoutConstraint.activate([
            editPreferences.topAnchor.constraint(equalTo: buttonsContainer.topAnchor, constant: 10),
            editPreferences.leadingAnchor.constraint(equalTo: buttonsContainer.leadingAnchor, constant: 10),
            editPreferences.trailingAnchor.constraint(equalTo: buttonsContainer.centerXAnchor, constant: -5),
            editPreferences.heightAnchor.constraint(equalToConstant: 44),

            editPersonalInfo.topAnchor.constraint(equalTo: buttonsContainer.topAnchor, constant: 10),
            editPersonalInfo.leadingAnchor.constraint(equalTo: buttonsContainer.centerXAnchor, constant: 5),
            editPersonalInfo.trailingAnchor.constraint(equalTo: buttonsContainer.trailingAnchor, constant: -10),
            editPersonalInfo.heightAnchor.constraint(equalToConstant: 44)
        ])
    }

    @objc private func restartProcess() {
        let onboarding = OnboardingViewController()
        navigationController?.setViewControllers([onboarding], animated: true)
    }

    @objc private func gotoEditPreferences() {
        let next = PreferencesViewController()
        navigationController?.pushViewController(next, animated: true)
    }

    @objc private func gotoEditProfile() {
        let next = PersonalInfoViewController()
        navigationController?.pushViewController(next, animated: true)
    }
}
