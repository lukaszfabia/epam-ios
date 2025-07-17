//
//  ViewController.swift
//  CustomNotificationSystem
//
//  Created by Lukasz Fabia on 15/07/2025.
//

import UIKit

// Controller which listens on changes
class ReceiverViewController: UIViewController {
    
    private let currentValueInfo: UILabel = {
       let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .systemFont(ofSize: 24, weight: .heavy)
        label.adjustsFontSizeToFitWidth = true
        
        return label
    }()
    

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        setupUI()
        setupObservers()
        
        currentValueInfo.text = "0"
    }

    
    private func setupUI() {
        view.addSubview(currentValueInfo)
        
        
        NSLayoutConstraint.activate([
            currentValueInfo.centerXAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerXAnchor),
            currentValueInfo.centerYAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerYAnchor),
        ])
    }
    
    private func setupObservers() {
        NotificationCenter.default.addObserver(self, selector: #selector(handleIncrementation), name: Notification.Name("ValueIncremented"), object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(handleReset), name: Notification.Name("ResetRequested"), object: nil)
    }
    
    @objc private func handleReset(nofitication: Notification) {
        UIView.animate(withDuration: 0.3) {
            self.currentValueInfo.text = "0"
            self.view.layoutIfNeeded()
        }
    }
    
    @objc private func handleIncrementation(notification: Notification) {
        print("Got new notification !!!")
        guard let value = notification.userInfo?["value"] as? String
        else {
            print("Failed to get value")
            return
        }
        
        UIView.animate(withDuration: 0.3) {
            self.currentValueInfo.text = value
            self.view.layoutIfNeeded()
        }
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self)
    }

}

