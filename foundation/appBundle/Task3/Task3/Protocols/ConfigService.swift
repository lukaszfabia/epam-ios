//
//  ConfigService.swift
//  Task3
//
//  Created by Lukasz Fabia on 23/07/2025.
//

protocol ConfigService {
    func loadConfig(with name: String) throws -> Config
}
