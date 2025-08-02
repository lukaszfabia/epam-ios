//
//  NetworkService.swift
//  Task9
//
//  Created by Lukasz Fabia on 02/08/2025.
//

import Combine
import Foundation

protocol NetworkService {
    var baseURL: URL? { get }
    
    func fetch<T>(_ url: URL?) -> AnyPublisher<[T], Error> where T: Decodable
}
