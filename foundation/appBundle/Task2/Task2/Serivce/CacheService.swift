//
//  CacheService.swift
//  Task2
//
//  Created by Lukasz Fabia on 15/07/2025.
//

import Foundation
import UIKit

class CacheService {
    
    private let temporaryDirectory = FileManager.default.temporaryDirectory
    
    init() {
        listenOnMemoryWarnings()
    }
    
    
    func listenOnMemoryWarnings() {
        NotificationCenter.default.addObserver(self, selector: #selector(handleMemoryWarn), name: UIApplication.didReceiveMemoryWarningNotification, object: nil)
    }
    
    @objc func handleMemoryWarn() {
        
    }
    
    func save(){}
    func load(image imageView: UIImageView) {}
    func clear(){}
}
