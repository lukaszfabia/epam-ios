//
//  ConfigService.swift
//  Task3
//
//  Created by Lukasz Fabia on 23/07/2025.
//

import Foundation

class JsonConfigService: ConfigService {
    enum JsonConfigServiceError: Error {
        case fileNotFound, cannotReadUrl, failedToDecode
    }
    
    func loadConfig(with name: String) throws -> Config {
        guard let configPath = Bundle.main.url(forResource: name, withExtension: "json") else { throw JsonConfigServiceError.fileNotFound }
        
        let configContent: Data
        
        do {
            configContent = try Data(contentsOf: configPath)
        }
        catch {
            print("Error during getting data from url: \(error.localizedDescription)")
            throw JsonConfigServiceError.cannotReadUrl
        }
        
        
        do {
            let decoded = try JSONDecoder().decode(Config.self, from: configContent)
            
            print("Returning config: \(decoded)")
            
            return decoded
        } catch {
            print("Failed decode data: \(error.localizedDescription)")
            throw JsonConfigServiceError.failedToDecode
        }
        
    }
}
