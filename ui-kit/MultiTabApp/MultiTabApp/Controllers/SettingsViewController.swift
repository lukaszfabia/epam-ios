//
//  SettingsViewController.swift
//  MultiTabApp
//
//  Created by Lukasz Fabia on 14/06/2025.
//

import Foundation
import UIKit

class SettingsViewController: BaseViewController {
    var name: String = "Settings"
    
    private let toggler = UISwitch()
    private let container = UIView()
    private let label = UILabel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = name
        setupContainer()
        setupComponets()
    }
    
    private func setupContainer() {
        view.addSubview(container)
        container.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            container.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            container.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            container.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            container.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 10),
            container.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -10),
        ])
    }
    
    private func setupComponets() {
        container.addSubview(label)
        container.addSubview(toggler)
        toggler.translatesAutoresizingMaskIntoConstraints = false
        label.translatesAutoresizingMaskIntoConstraints = false
        
        changeLabelContent(false)
        label.textColor = .label
        label.textAlignment = .center
        
        toggler.addTarget(self, action: #selector(handleToggle), for: .valueChanged)
        
        NSLayoutConstraint.activate([
            label.topAnchor.constraint(equalTo: container.topAnchor, constant: 20),
            label.leadingAnchor.constraint(equalTo: container.leadingAnchor, constant: 20),
            
            toggler.topAnchor.constraint(equalTo: container.topAnchor, constant: 20),
            toggler.trailingAnchor.constraint(equalTo: container.trailingAnchor, constant: -20),
            
            label.centerYAnchor.constraint(equalTo: toggler.centerYAnchor), // centering label to toggler
        ])
    }
    
    @objc func handleToggle(_ sender: UISwitch) {
        changeLabelContent(sender.isOn)
    }
    
    
    private func changeLabelContent(_ isOn: Bool) {
        label.text = "Navigation is \(isOn ? "easy": "hard :(")"
    }
    
}
