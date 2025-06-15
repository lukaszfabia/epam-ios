//
//  EditProfileViewController.swift
//  MultiTabApp
//
//  Created by Lukasz Fabia on 15/06/2025.
//

import Foundation
import UIKit

class EditProfileViewController: BaseViewController {
    
    var name : String = "Edit profile"
    
    private let label = UILabel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = name 
        setupLabel()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        print("[EditProfileViewController]: viewWillAppear")
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        print("[EditProfileViewController]: viewDidAppear")
    }

    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        print("[EditProfileViewController]: viewWillLayoutSubviews")
    }

    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        print("[EditProfileViewController]: viewDidLayoutSubviews")
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        print("[EditProfileViewController]: viewWillDisappear")
    }

    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        print("[EditProfileViewController]: viewDidDisappear")
    }
    
    private func setupLabel() {
        view.addSubview(label)
        label.translatesAutoresizingMaskIntoConstraints = false
        
        label.text = "Dziabko"
        
        label.font = .systemFont(ofSize: 20, weight: .heavy)
        
        NSLayoutConstraint.activate([
            label.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant : 20),
            label.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 20)
        ])
    }
    
}
