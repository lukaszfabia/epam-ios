//
//  Session.swift
//  MultiTabApp
//
//  Created by Lukasz Fabia on 15/06/2025.
//

import Foundation
class Session {
    static let shared = Session()
   
    /// saved user
    var user = User()
    
    /// used for collect data during onboarding process
    var temporaryUser = User()
    private init(){}
    
    
    func create() {
        print("Creating new user...")
        self.user = self.temporaryUser
    }
}
