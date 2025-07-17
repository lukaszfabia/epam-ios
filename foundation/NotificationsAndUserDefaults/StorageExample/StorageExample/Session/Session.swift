//
//  Session.swift
//  StorageExample
//
//  Created by Lukasz Fabia on 16/07/2025.
//

class Session {
    
    let storage: any Storable
    
    init(storage: any Storable) {
        self.storage = storage
    }
    
    var isLoggedIn: Bool {
        storage.get(from: .isLoggedIn) as? Bool ?? false
    }
}
