//
//  Task4ViewController.swift
//  AutolatoutPracticalTasks
//
//  Created by Kakhaberi Kiknadze on 20.03.25.
//

import UIKit

// Create a view with two subviews aligned vertically when in Compact width, Regular height mode.
// If the orientation changes to Compact-Compact, same 2 subviews should be aligned horizontally.
// Hou can use iPhone 16 simulator for testing.
final class Task4ViewController: UIViewController {
    
    private let firstSubview = UIView()
    private let secondSubview = UIView()
    
    private var horizontalConstraints: [NSLayoutConstraint] = []
    private var verticalConstraints: [NSLayoutConstraint] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
        setupHorizontalLayout()
        setupVerticalLayout()
        registerForTraitChanges()
        
        changeLayout(traitCollection)
    }
    
    private func registerForTraitChanges() {
        let sizeTraits: [UITrait] = [UITraitVerticalSizeClass.self, UITraitHorizontalSizeClass.self]
        registerForTraitChanges(sizeTraits) { (self: Self, previousTraitCollection: UITraitCollection) in
            print("Trait collection changed:", self.traitCollection)
            
            if self.didLayoutChange(prev: previousTraitCollection, current: self.traitCollection) {
                return
            }
            
            self.changeLayout(self.traitCollection)
        }
    }
    
    private func didLayoutChange(prev: UITraitCollection, current: UITraitCollection) -> Bool {
        return current.horizontalSizeClass == prev.horizontalSizeClass &&
               current.verticalSizeClass == prev.verticalSizeClass
    }
    
    private func deactivateConstraints() {
        NSLayoutConstraint.deactivate(horizontalConstraints + verticalConstraints)
    }
    
    private func changeLayout(_ trait: UITraitCollection) {
        deactivateConstraints()
        
        
        if trait.horizontalSizeClass == .compact && trait.verticalSizeClass == .compact {
            NSLayoutConstraint.activate(horizontalConstraints)
        } else {
            NSLayoutConstraint.activate(verticalConstraints)
        }
        
        UIView.animate(withDuration: 0.25) {
            self.view.layoutIfNeeded()
        }
    }
    
    private func setupViews() {
        view.addSubview(firstSubview)
        view.addSubview(secondSubview)
        
        firstSubview.translatesAutoresizingMaskIntoConstraints = false
        secondSubview.translatesAutoresizingMaskIntoConstraints = false
        
        firstSubview.backgroundColor = .systemGray
        firstSubview.layer.cornerRadius = 8
        secondSubview.backgroundColor = .systemGray2
        secondSubview.layer.cornerRadius = 8
    }
    
    private func setupHorizontalLayout() {
        horizontalConstraints = [
            firstSubview.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 20),
            firstSubview.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            firstSubview.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.4),
            firstSubview.heightAnchor.constraint(equalToConstant: 150),
            
            secondSubview.leadingAnchor.constraint(equalTo: firstSubview.trailingAnchor, constant: 20),
            secondSubview.centerYAnchor.constraint(equalTo: firstSubview.centerYAnchor),
            secondSubview.widthAnchor.constraint(equalTo: firstSubview.widthAnchor),
            secondSubview.heightAnchor.constraint(equalTo: firstSubview.heightAnchor)
        ]
    }
    
    private func setupVerticalLayout() {
        verticalConstraints = [
            firstSubview.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20),
            firstSubview.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            firstSubview.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.8),
            firstSubview.heightAnchor.constraint(equalToConstant: 150),
            
            secondSubview.topAnchor.constraint(equalTo: firstSubview.bottomAnchor, constant: 20),
            secondSubview.centerXAnchor.constraint(equalTo: firstSubview.centerXAnchor),
            secondSubview.widthAnchor.constraint(equalTo: firstSubview.widthAnchor),
            secondSubview.heightAnchor.constraint(equalToConstant: 150),
        ]

    }
}

#Preview {
    Task4ViewController()
}
