//
//  SharedObject.swift
//  Task7
//
//  Created by Lukasz Fabia on 08/08/2025.
//

import Observation

@Observable
class SharedObject {
    var counter: Int = 0
    
    func increment() {
        counter += 1
    }
}
