//
//  Information.swift
//  GymApp
//
//  Created by Lukasz Fabia on 19/06/2025.
//

import Foundation

protocol Information  {
    var id: UUID {get}
    var firstName: String {get}
    var lastName: String {get}
    var avatar: String {get} /// image from assets 
    
    var fullname: String {get}
}


extension Information {
    var fullname: String {
        "\(firstName) \(lastName)"
    }
}
