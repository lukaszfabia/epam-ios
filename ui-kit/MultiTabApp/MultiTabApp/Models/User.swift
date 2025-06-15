//
//  User.swift
//  MultiTabApp
//
//  Created by Lukasz Fabia on 15/06/2025.
//

import Foundation

struct NotificationsPreferences {
    let email : Bool
    let sms : Bool
    let push: Bool
}

class User {
    
    var name: String? = nil
    
    var phone: String? = nil
    
    var preferences: Preference? = nil
    
    var exists: Bool {
        name != nil && phone != nil
    }
    
    enum Preference {
        case email, push, sms, none
        
        var name: String {
            switch self {
            case .email: return "Email"
            case .push: return "Push"
            case .sms: return "SMS"
            case .none: return "None"
            }
        }
    }
    
    
    func setUserDetails(name: String, phone: String) {
        self.name = name
        self.phone = phone
    }
    
    func setPreference(_ p: Preference) {
        self.preferences = p
    }
    
    func clearMe() {
        self.name = nil
        self.preferences = nil
        self.phone = nil
    }
}
