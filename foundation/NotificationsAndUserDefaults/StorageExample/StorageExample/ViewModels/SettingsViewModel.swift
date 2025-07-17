//
//  SettingsViewModel.swift
//  StorageExample
//
//  Created by Lukasz Fabia on 16/07/2025.
//

import Foundation
import UIKit


class SettingsViewModel {
    
    let storage: any Storable
    let session: Session
    
    var onLogout: (() -> Void)?
    
    init(storage: any Storable, sessoin: Session) {
        self.storage = storage
        self.session = sessoin
    }
    
    func toggleTheme(isOn: Bool) {
        storage.set(on: .theme, value: isOn ? UIUserInterfaceStyle.dark.rawValue : UIUserInterfaceStyle.light.rawValue)
    }
    
    var isDarkTheme: Bool {
        if let savedTheme = storage.get(from: .theme) as? Int {
            return savedTheme == UIUserInterfaceStyle.dark.rawValue
        }
        return UITraitCollection.current.userInterfaceStyle == .dark
    }
    
    func logout() {
        //clean up users data
        [StorageKeys.email, StorageKeys.password, StorageKeys.isLoggedIn, StorageKeys.theme, StorageKeys.phrases].forEach { key in
            storage.remove(on: key)
        }
    }
    
}
