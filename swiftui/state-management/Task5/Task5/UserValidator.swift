//
//  UserValidator.swift
//  Task5
//
//  Created by Lukasz Fabia on 08/08/2025.
//

import Foundation

struct UserValidator {
    func validate(email: String) -> Bool {
        let emailRegex = "^[A-Z0-9._%+-]+@[A-Z0-9.-]+\\.[A-Z]{2,64}$"
        let emailPredicate = NSPredicate(format: "SELF MATCHES[c] %@", emailRegex)
        return emailPredicate.evaluate(with: email)
    }
    
    func validate(name: String) -> Bool {
        let nameWithoutWhiteSpaces = name.trimmingCharacters(in: .whitespacesAndNewlines)
        
        guard !nameWithoutWhiteSpaces.isEmpty else {return false}
        
        return true
    }
}
