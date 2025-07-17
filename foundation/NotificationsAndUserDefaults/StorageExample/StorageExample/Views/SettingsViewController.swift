//
//  SettingsViewController.swift
//  StorageExample
//
//  Created by Lukasz Fabia on 16/07/2025.
//

import UIKit

class SettingsViewController: UIViewController {
    
    private let settingsViewModel: SettingsViewModel
    
    private let switchLabel: UILabel = {
        let s = UILabel()
        s.text = "Dark theme"
        s.font = .systemFont(ofSize: 17, weight: .medium)
        s.textColor = .label
        
        return s
    }()
    
    private let hStack: UIStackView = {
        let stack = UIStackView()
        stack.axis = .horizontal
        stack.distribution = .fill
        stack.translatesAutoresizingMaskIntoConstraints = false
        return stack
    }()
    
    init(settingsViewModel: SettingsViewModel) {
        self.settingsViewModel = settingsViewModel
        
        themeSwitch.isOn = settingsViewModel.isDarkTheme
        
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("not impl")
    }
    
    private let themeSwitch = UISwitch()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(
            image: UIImage(systemName: "rectangle.portrait.and.arrow.forward"),
            style: .plain,
            target: self,
            action: #selector(handleLogout)
        )
        
        
        setupUI()
        setupHandlers()
    }
    
    private func setupUI() {
        view.addSubview(hStack)
        hStack.addArrangedSubview(switchLabel)
        hStack.addArrangedSubview(themeSwitch)
        
        
        NSLayoutConstraint.activate([
            hStack.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20),
            hStack.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 20),
            hStack.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -20),
        ])
    }
    
    private func setupHandlers() {
        themeSwitch.addTarget(self, action: #selector(themeSwitchChanged), for: .valueChanged)
    }
}

extension SettingsViewController {
    @objc private func themeSwitchChanged(_ sender: UISwitch) {
        
        guard let window = view.window else {return}
        
        settingsViewModel.toggleTheme(isOn: sender.isOn)
        
        print("Dark mode is: \(sender.isOn)")
        
        window.overrideUserInterfaceStyle = settingsViewModel.isDarkTheme ? .dark : .light
        
        UIView.transition(with: window, duration: 0.3, options: .transitionCrossDissolve, animations: nil)
    }
    
    @objc private func handleLogout() {
        
        settingsViewModel.logout()
        
        guard let window = view.window else {return}
        
        window.rootViewController = LoggedOutTabBarController(storage: settingsViewModel.storage, session: settingsViewModel.session)
        
        window.overrideUserInterfaceStyle = settingsViewModel.isDarkTheme ? .dark : .light
        
        UIView.transition(with: window, duration: 0.3, options: .transitionCrossDissolve, animations: nil)
        
    }
}
