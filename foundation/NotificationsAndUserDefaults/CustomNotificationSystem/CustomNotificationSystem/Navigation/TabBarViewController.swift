//
//  TabBarViewController.swift
//  CustomNotificationSystem
//
//  Created by Lukasz Fabia on 15/07/2025.
//

import UIKit

class TabBarViewController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        setup()
        
    }
    
    func setup() {
        let sender = createNavigationController(for: SenderViewController(), with: "Sender", and: "paperplane")
        let receiver = createNavigationController(for: ReceiverViewController(), with: "Receiver", and: "ear")
        
        
        setViewControllers([receiver,sender], animated: true)
    }
    
    func createNavigationController(for vc: UIViewController, with title: String, and icon: String) -> UINavigationController {
        let navVc = UINavigationController(rootViewController: vc)
        navVc.tabBarItem.title = title
        navVc.tabBarItem.image = UIImage(systemName: icon)
        navVc.viewControllers.first?.navigationController?.title = title
        navVc.navigationItem.largeTitleDisplayMode = .always
        
        return navVc
    }

}
