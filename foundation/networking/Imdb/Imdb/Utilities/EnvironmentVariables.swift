//
//  SecretKeys.swift
//  Imdb
//
//  Created by Lukasz Fabia on 05/07/2025.
//

import Foundation

struct EnvironmentVariables {
    
    private struct Keys {
         static let apiSecretKey = "API_SECRET"
    }
    
    static var apiSecret : String {
        Bundle.main.object(forInfoDictionaryKey: Keys.apiSecretKey) as? String ?? ""
    }
    
    static let baseUrl = "https://api.themoviedb.org/3"
    
    static let baseImageUrl = "https://image.tmdb.org/t/p/w500"
}
