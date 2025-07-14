//
//  Note.swift
//  Task1
//
//  Created by Lukasz Fabia on 10/07/2025.
//


import Foundation

struct JsonNote: ReadWriteAccessible {
    static var ext: String = "json"
    
    var filename: String?
    
    let content: String
}
