//
//  Storable.swift
//  StorageExample
//
//  Created by Lukasz Fabia on 16/07/2025.
//

protocol Storable {
    func set(on key: StorageKeys, value: Any)
    
    func remove(on key: StorageKeys)
    
    func get(from key: StorageKeys) -> Any?
}
