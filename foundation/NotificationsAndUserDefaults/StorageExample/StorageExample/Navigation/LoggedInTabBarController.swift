//
//  TabBarController.swift
//  StorageExample
//
//  Created by Lukasz Fabia on 16/07/2025.
//

import UIKit

class LoggedInTabBarController: UITabBarController {
    
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
        
        registerNavigation()
    }
    
    private func registerNavigation() {
        let settings = createNavigationController(for: SettingsViewController(settingsViewModel: SettingsViewModel(storage: storage, sessoin: session)), with: "Settings", and: "gear")
        let search = createNavigationController(for: SearchPeopleViewController(searchPeopleViewModel: SearchPeopleViewModel(storage: storage, session: session)), with: "Search", and: "magnifyingglass")
        setViewControllers([settings, search], animated: false)
    }

}
