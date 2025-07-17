//
//  ViewController.swift
//  AppStateObserver
//
//  Created by Lukasz Fabia on 15/07/2025.
//

import UIKit

class ViewController: UIViewController {
    
    private var observer: AppStateObserver? = nil

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        observer = AppStateObserver()
    }



}

