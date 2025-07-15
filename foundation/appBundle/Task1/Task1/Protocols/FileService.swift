//
//  FileService.swift
//  Task1
//
//  Created by Lukasz Fabia on 10/07/2025.
//

import Foundation

protocol FileService {
    func save<T: ReadWriteAccessible>(_ obj : T) throws -> T
    func retrieve<T: ReadWriteAccessible>(_ obj : T) throws -> T
    
    func getAll<T: ReadWriteAccessible>() -> [T]
}


extension FileService {
    var uniqueFileName: String {
        Date().timeIntervalSince1970.description
    }
}
