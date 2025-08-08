//
//  UserValidator.swift
//  Task5
//
//  Created by Lukasz Fabia on 08/08/2025.
//

import Foundation

struct UserValidator {
    func validate(_ str: String) -> Bool {
        let strWithoutWhiteSpaces = str.trimmingCharacters(in: .whitespacesAndNewlines)
        
        guard !strWithoutWhiteSpaces.isEmpty else {return false}
        
        return true
    }
}
