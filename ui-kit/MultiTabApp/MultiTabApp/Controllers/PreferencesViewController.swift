//
//  PreferencesViewController.swift
//  MultiTabApp
//
//  Created by Lukasz Fabia on 15/06/2025.
//

import Foundation
import UIKit

class PreferencesViewController: BaseViewController {
    var name = "Preferences"
    
    private let preferenceInfo = UILabel()
    private let selectPreferenceButton = UIButton(type: .system)

    override func viewDidLoad() {
        super.viewDidLoad()
        title = name
        setupButton()
        setupLabel()
        setupFinishButton()
        defaultValueIfExists()
    }
    
    private func setupFinishButton() {
        let nextButton = UIBarButtonItem(title: "Next", style: .done, target: self, action: #selector(navigateToEndView))
        navigationItem.rightBarButtonItem = nextButton
        
    }
    
    @objc private func navigateToEndView() {
        let end = ConfirmDetailsViewController()
        navigationController?.title = end.name
        navigationController?.pushViewController(end, animated: true)
    }

    
    private func defaultValueIfExists() {
        let preference = Session.user.preferences ?? .none
        
        preferenceInfo.text = preference == .none ? "Not selected" :"Selected \(preference.name)"
    }
    
    private func setupButton() {
        selectPreferenceButton.setTitle("Select Notification Preference", for: .normal)
        selectPreferenceButton.setTitleColor(.white, for: .normal)
        selectPreferenceButton.backgroundColor = .systemIndigo
        selectPreferenceButton.layer.cornerRadius = 20
        selectPreferenceButton.titleLabel?.font = .systemFont(ofSize: 18, weight: .medium)
        selectPreferenceButton.addTarget(self, action: #selector(showActionSheet), for: .touchUpInside)
        selectPreferenceButton.translatesAutoresizingMaskIntoConstraints = false
        
        view.addSubview(selectPreferenceButton)
        
        NSLayoutConstraint.activate([
            selectPreferenceButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            selectPreferenceButton.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            selectPreferenceButton.widthAnchor.constraint(equalToConstant: 280),
            selectPreferenceButton.heightAnchor.constraint(equalToConstant: 50),
        ])
    }
    
    private func setupLabel() {
        preferenceInfo.text = "No preference selected"
        preferenceInfo.textAlignment = .center
        preferenceInfo.font = .systemFont(ofSize: 20, weight: .regular)
        preferenceInfo.textColor = .darkGray
        preferenceInfo.adjustsFontSizeToFitWidth = true
        preferenceInfo.translatesAutoresizingMaskIntoConstraints = false
        
        view.addSubview(preferenceInfo)
        
        NSLayoutConstraint.activate([
            preferenceInfo.topAnchor.constraint(equalTo: selectPreferenceButton.bottomAnchor, constant: 24),
            preferenceInfo.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            preferenceInfo.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
        ])
    }
    
    @objc private func showActionSheet() {
        let alert = UIAlertController(
            title: "Select Notification Preference",
            message: nil,
            preferredStyle: .actionSheet
        )
        
        alert.addAction(UIAlertAction(title: "Email", style: .default) { _ in
            self.savePreference(.email)
        })
        
        alert.addAction(UIAlertAction(title: "SMS", style: .default) { _ in
            self.savePreference(.sms)
        })
        
        alert.addAction(UIAlertAction(title: "Push", style: .default) { _ in
            self.savePreference(.push)
        })
        
        alert.addAction(UIAlertAction(title: "Delete", style: .destructive){ _ in
            self.savePreference(.none)
        })
        
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel))
        
        if let popover = alert.popoverPresentationController {
            popover.sourceView = self.selectPreferenceButton
            popover.sourceRect = self.selectPreferenceButton.bounds
        }
        
        present(alert, animated: true)
    }
    
    private func savePreference(_ preference: User.Preference) {
        preferenceInfo.text = preference == .none ? "Not selected" :"Selected \(preference.name)"
        
        Session.user.setPreference(preference)
    }
}
