//
//  FormModel.swift
//  Task5
//
//  Created by Lukasz Fabia on 08/08/2025.
//

import Observation

@Observable
class FormModel {
    var user: User = .init(email: "", name: "")
    
    private let validator: UserValidator = .init()
    
    var isUserInvalid: Bool {
        !(validator.validate(user.email) && validator.validate(user.name))
    }
}
