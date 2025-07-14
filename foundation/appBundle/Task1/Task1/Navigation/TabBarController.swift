//
//  TabBar.swift
//  Task1
//
//  Created by Lukasz Fabia on 11/07/2025.
//

import UIKit

class TabBarController: UITabBarController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        
        setupBar()
        setupNavigationItems()
    }
    
    
    private func setupBar() {
        tabBar.tintColor = .systemIndigo
    }
    
    private func setupNavigationItems(){
        let jsonService = JsonService()
        
        
        let saveNavigation = createNavigation(for: SaveViewController(service: jsonService), with: "Save", and: UIImage(systemName: "pencil"))
        
        let listNavigation = createNavigation(for: ListViewController(service: jsonService), with: "Notes", and: UIImage(systemName: "book.pages"))
        
        
        setViewControllers([
            saveNavigation, listNavigation
        ], animated: true)
    }
    
    private func createNavigation(for viewController: UIViewController, with title: String, and image: UIImage?) -> UINavigationController {
        let n = UINavigationController(rootViewController: viewController)
        n.tabBarItem.title = title
        n.tabBarItem.image = image
        n.viewControllers.first?.navigationItem.title = title
        n.viewControllers.first?.navigationController?.navigationBar.prefersLargeTitles = true
        
        return n
    }
}
