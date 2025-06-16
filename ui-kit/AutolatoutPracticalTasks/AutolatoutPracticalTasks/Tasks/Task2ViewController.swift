//
//  Task2.swift
//  AutolatoutPracticalTasks
//
//  Created by Kakhaberi Kiknadze on 20.03.25.
// 

import UIKit

// Build a UI programmatically with a UIButton positioned below a UILabel.
// The button should be centered horizontally and have a fixed distance from the label.
// Adjust the layout to handle different screen sizes.
final class Task2ViewController: UIViewController {    
    private let button = UIButton()
    private let label = UILabel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupLabel()
        setupButton()
    }

    
    func setupButton() {
        view.addSubview(button)
        button.setTitle("Get Started", for: .normal)
        button.setTitleColor(.systemIndigo, for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            button.centerXAnchor.constraint(equalTo: label.centerXAnchor),
            button.topAnchor.constraint(equalTo: label.bottomAnchor, constant: 12),
            
            
            //apply the same width as label
            button.widthAnchor.constraint(equalTo: label.widthAnchor),
            button.heightAnchor.constraint(equalToConstant: 15)
        ])
    }

    
    func setupLabel() {
        view.addSubview(label)
        label.text = "Go is awsome :)"
        label.adjustsFontSizeToFitWidth = true
        label.font = .systemFont(ofSize: 20, weight: .bold)
        label.textColor = .blue
        label.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            label.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            label.centerYAnchor.constraint(equalTo: view.centerYAnchor),
        ])
    }
}

#Preview {
    Task2ViewController()
}
