//
//  Trainer.swift
//  GymApp
//
//  Created by Lukasz Fabia on 19/06/2025.
//

import Foundation

struct Trainer: Information {
    let id: UUID = UUID()
    
    let firstName: String
    
    let lastName: String
    
    let avatar: String
    
    
    static func dummy() -> Trainer {
        return Trainer(firstName: "Mati", lastName: "Borek", avatar: "mati")
    }
}
