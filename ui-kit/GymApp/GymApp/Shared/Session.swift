//
//  Session.swift
//  GymApp
//
//  Created by Lukasz Fabia on 19/06/2025.
//


import Foundation
class Session {
    static let shared = Session()
   
    /// default user
    var user = User(firstName: "Lukasz", lastName: "Fabia", avatar: "mati")
    

    private init(){}
}
