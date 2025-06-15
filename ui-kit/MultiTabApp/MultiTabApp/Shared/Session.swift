//
//  Session.swift
//  MultiTabApp
//
//  Created by Lukasz Fabia on 15/06/2025.
//

import Foundation
class Session {
    static let shared = Session()
   
    static var user = User()
    private init(){}
}
