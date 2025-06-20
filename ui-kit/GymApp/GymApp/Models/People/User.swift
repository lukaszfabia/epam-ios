//
//  User.swift
//  GymApp
//
//  Created by Lukasz Fabia on 19/06/2025.
//

import Foundation

struct User: Information {
    let id: UUID = UUID()
    
    let firstName: String
    
    let lastName: String
    
    let avatar: String
}
