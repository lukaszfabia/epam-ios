//
//  AppStateObserver.swift
//  AppStateObserver
//
//  Created by Lukasz Fabia on 15/07/2025.
//

import Foundation
import UIKit

class AppStateObserver {
    init() {
        setupObservers()
    }
    
    private func setupObservers() {
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(appDidEnterBackground),
            name: UIApplication.didEnterBackgroundNotification,
            object: nil
        )
        
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(appWillEnterForeground),
            name: UIApplication.willEnterForegroundNotification,
            object: nil
        )
    }
    
    @objc private func appDidEnterBackground() {
        print("[appDidEnterBackground] I guess you are going to home screen of ur phone :)")
    }

    @objc private func appWillEnterForeground() {
        print("[appWillEnterForeground] one moment please i will go back to work")
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
}
