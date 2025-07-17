//
//  LoginViewModel.swift
//  StorageExample
//
//  Created by Lukasz Fabia on 16/07/2025.
//

class LoginViewModel {
    let storage: any Storable
    let session: Session
    
    init(storage: any Storable, session: Session) {
        self.storage = storage
        self.session = session
    }
    
    func login(email: String, password: String) {
        print("Logging, user with: \(email)")
        storage.set(on: .email, value: email)
        storage.set(on: .password, value: password)
        storage.set(on: .isLoggedIn, value: true)
    }
    
 
    // here we can specify more validation cases
    
    func isPasswordValid(_ text: String?) -> Bool {
        guard let text = text else {return false}
        return !text.isEmpty
    }
    
    func isEmailValid(_ text: String?) -> Bool {
        guard let text = text else {return false}
        return !text.isEmpty
    }
}
