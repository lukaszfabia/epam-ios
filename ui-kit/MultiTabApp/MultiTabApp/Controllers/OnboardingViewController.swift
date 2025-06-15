//
//  OnboardingViewController.swift
//  MultiTabApp
//
//  Created by Lukasz Fabia on 14/06/2025.
//

import UIKit

class OnboardingViewController: BaseViewController {
    var name: String = "Onboarding"
    private let gettingStartedButton = UIButton()
   
    override func viewDidLoad() {
        super.viewDidLoad()
        title = name
        setupGettingStartedButton()
    }
    
    private func setupGettingStartedButton() {
        view.addSubview(gettingStartedButton)
        gettingStartedButton.translatesAutoresizingMaskIntoConstraints = false
        
        let exists = Session.user.exists
        
        gettingStartedButton.setTitle(exists ? "Restart" : "Start", for: .normal)
        gettingStartedButton.backgroundColor = exists ? .systemGreen : .systemBlue
        
        gettingStartedButton.setTitleColor(.white, for: .normal)
        gettingStartedButton.titleLabel?.font = .systemFont(ofSize: 20, weight: .medium)
        gettingStartedButton.layer.cornerRadius = 20
        
        gettingStartedButton.addTarget(self, action: #selector(navigateToPersonalInfo), for: .touchUpInside)
        
        NSLayoutConstraint.activate([
            gettingStartedButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            gettingStartedButton.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            gettingStartedButton.widthAnchor.constraint(equalToConstant: 200),
            gettingStartedButton.heightAnchor.constraint(equalToConstant: 50),
        ])
    }
    
    @objc private func navigateToPersonalInfo() {
        let next = PersonalInfoViewController()
        next.title = next.name
        
        Session.user.clearMe()
        
        navigationController?.pushViewController(next, animated: true)
    }

    
}
