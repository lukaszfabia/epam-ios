//
//  LocalStorage.swift
//  StorageExample
//
//  Created by Lukasz Fabia on 16/07/2025.
//

import Foundation

class LocalStorage: Storable {
    
    private let storage: UserDefaults
    
    init() {
        storage = UserDefaults.standard
    }
    
    
    func set(on key: StorageKeys, value: Any) {
        print("Setting \(value) on \(key)")
        storage.set(value, forKey: key.rawValue)
    }
    
    func remove(on key: StorageKeys) {
        print("Removing object under \(key)")
        storage.removeObject(forKey: key.rawValue)
    }
    
    func get(from key: StorageKeys) -> Any? {
        print("Getting object from \(key)=\(storage.object(forKey: key.rawValue) ?? "nil") ")
        return storage.object(forKey: key.rawValue)
    }
    
}
