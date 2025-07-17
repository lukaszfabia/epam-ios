//
//  UITabBarController.swift
//  StorageExample
//
//  Created by Lukasz Fabia on 16/07/2025.
//

import UIKit

extension UITabBarController {
    func createNavigationController(for vc: UIViewController, with title: String, and icon: String) -> UINavigationController {
        let n = UINavigationController(rootViewController: vc)
        
        n.viewControllers.first?.title = title
        n.navigationBar.prefersLargeTitles = true
        n.tabBarItem.image = UIImage(systemName: icon)
        n.tabBarItem.title = title
        
        return n
    }
}
