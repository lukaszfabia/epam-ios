//
//  TabViewController.swift
//  MultiTabApp
//
//  Created by Lukasz Fabia on 14/06/2025.
//

import UIKit

class TabBarController: UITabBarController {
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTabs()
        setupBar()
    }
    
    private func setupBar() {
        tabBar.backgroundColor = .systemOrange
        tabBar.tintColor = .white
        tabBar.unselectedItemTintColor = .gray

    }
    
    private func setupTabs() {
        let onboarding = createNavigation(for: OnboardingViewController(), with: "Onboarding", and: UIImage(systemName: "sparkles"))
        let profile = createNavigation(for: ProfileViewController(), with: "Profile", and: UIImage(systemName: "person.crop.circle"))
        let settings = createNavigation(for: SettingsViewController(), with: "Settings", and: UIImage(systemName: "gear"))
        
        setViewControllers([
            onboarding,
            profile,
            settings,
        ], animated: true)
    }
    
    private func createNavigation(for viewController: UIViewController, with title: String, and image: UIImage?) -> UINavigationController {
        let n = UINavigationController(rootViewController: viewController)
        n.tabBarItem.title = title
        n.tabBarItem.image = image
        n.viewControllers.first?.navigationItem.title = title
        return n
    }
}
