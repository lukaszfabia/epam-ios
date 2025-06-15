//
//  Validator.swift
//  MultiTabApp
//
//  Created by Lukasz Fabia on 15/06/2025.
//

import Foundation


struct Validator {
    
    private enum Regex: String {
        case phone = #"^\d{3}\d{3}\d{3}$"# // 999111111 Ok
    }
    
    static func validatePhone(number: String)-> Bool {
        let predicate = NSPredicate(format: "SELF MATCHES %@", Regex.phone.rawValue)
        return predicate.evaluate(with: number)
    }
    
    static func validateName(name: String) -> Bool {
        return !name.isEmpty
    }
}
