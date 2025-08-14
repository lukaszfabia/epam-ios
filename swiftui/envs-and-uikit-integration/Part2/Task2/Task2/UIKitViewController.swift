//
//  UIKitViewController.swift
//  Task2
//
//  Created by Lukasz Fabia on 14/08/2025.
//

import UIKit

class UIKitViewController: UIViewController {
    
    private let label = UILabel()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "UIKit VC"
        
        view.backgroundColor = .systemBackground

        // Do any additional setup after loading the view.
        
        navigationItem.rightBarButtonItem = .init(title: "Close", style: .plain, target: self, action: #selector(closeSheet))
        
        setupUI()
    }
    
    private func setupUI() {
        view.addSubview(label)
        label.translatesAutoresizingMaskIntoConstraints = false
        
        label.text = "Hello, from UIKit!"
        label.font = .systemFont(ofSize: 20, weight: .semibold)
        
        NSLayoutConstraint.activate([
            label.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            label.centerYAnchor.constraint(equalTo: view.centerYAnchor),
        ])
    }
    
    @objc
    private func closeSheet() {
        dismiss(animated: true)
    }
}
