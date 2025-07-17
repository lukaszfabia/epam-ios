//
//  TabBarController.swift
//  StorageExample
//
//  Created by Lukasz Fabia on 16/07/2025.
//

import UIKit
import Foundation

class LoggedOutTabBarController: UITabBarController {
    
    private let storage: any Storable
    private let session: Session
    
    init(storage: any Storable, session: Session) {
        self.storage = storage
        self.session = session
        
        
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("not impl")
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        registerNavigation()
    }
    
    private func registerNavigation() {
        let login = createNavigationController(for: LoginViewController(loginViewModel: LoginViewModel(storage: storage, session: session)), with: "Login", and: "person.badge.key")
        setViewControllers([login], animated: true)
    }
}
