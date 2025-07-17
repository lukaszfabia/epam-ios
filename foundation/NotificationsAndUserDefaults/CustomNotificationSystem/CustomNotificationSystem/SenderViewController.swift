//
//  ViewController.swift
//  CustomNotificationSystem
//
//  Created by Lukasz Fabia on 15/07/2025.
//

import UIKit

// Controller which sends 'events' to listener
class SenderViewController: UIViewController {
    
    private var currentValue = 0
    
    private let resetButton: UIButton = {
        var config = UIButton.Configuration.bordered()
        config.cornerStyle = .capsule
        config.baseBackgroundColor = .systemGray6
        
        let button = UIButton(type: .system)
        
        button.configuration = config
        button.setImage(UIImage(systemName: "arrow.counterclockwise"), for: .normal)
        button.tintColor = .label
        
        
        return button
    }()
    
    private let hStack: UIStackView = {
        let stack = UIStackView()
        stack.axis = .horizontal
        stack.spacing = 8
        stack.alignment = .center
        stack.distribution = .fillProportionally
        stack.translatesAutoresizingMaskIntoConstraints = false
        
        return stack
    }()
    
    
    private let incrementer: UIButton = {
        var config = UIButton.Configuration.filled()
        config.cornerStyle = .dynamic
        config.baseBackgroundColor = .systemIndigo
        config.baseForegroundColor = .white
        
        let button = UIButton(type: .system)
        
        button.configuration = config
        
        button.insetsLayoutMarginsFromSafeArea = false
        button.layoutMargins = .init(top: 5, left: 5, bottom: 5, right: 5)
        button.setImage(UIImage(systemName: "plus"), for: .normal)
        button.tintColor = .label
        button.translatesAutoresizingMaskIntoConstraints = false
        
        
        return button
    }()
    

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        setupUI()
        setupHandlers()
    }


    
    private func setupUI() {
        view.addSubview(hStack)
        
        hStack.addArrangedSubview(incrementer)
        hStack.addArrangedSubview(resetButton)
        
        
        NSLayoutConstraint.activate([
            hStack.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            hStack.centerYAnchor.constraint(equalTo: view.centerYAnchor),
        ])
    }
    
    private func setupHandlers() {
        incrementer.addTarget(self, action: #selector(increment), for: .touchUpInside)
        resetButton.addTarget(self, action: #selector(reset), for: .touchUpInside)
    }
    
    @objc private func reset(_ sener: UIButton) {
        print("Requesting for reset!!!")
        currentValue = 0
        NotificationCenter.default.post(name: Notification.Name("ResetRequested"), object:nil)
    }

    @objc private func increment(_ sender: UIButton) {
        print("Creating new notification!")
        
        currentValue+=1
        NotificationCenter.default.post(name: Notification.Name("ValueIncremented"), object: nil, userInfo: ["value": "\(currentValue)"])
    }
    
    
}

