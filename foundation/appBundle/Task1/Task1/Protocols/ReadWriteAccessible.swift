//
//  ReadWriteAccessible.swift
//  Task1
//
//  Created by Lukasz Fabia on 10/07/2025.
//

import Foundation

protocol ReadWriteAccessible: Codable {
    static var ext: String {get}
    
    var filename: String? { get set }
}
