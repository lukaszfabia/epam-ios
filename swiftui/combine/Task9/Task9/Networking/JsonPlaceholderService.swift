//
//  NetworkService.swift
//  Task9
//
//  Created by Lukasz Fabia on 02/08/2025.
//

import Foundation
import Combine

class JsonPlaceholderService: NetworkService {
    var baseURL: URL? {
        URL(string: "https://jsonplaceholder.typicode.com")
    }
    
    enum JsonPlaceholderServiceErrors: Error {
        case invalidURL, badResponse, failedToDecode
    }
    
    private let session: URLSession
    
    init(session: URLSession = .shared) {
        self.session = session
    }
    
    func fetch<T>(_ url: URL?) -> AnyPublisher<[T], any Error> where T: Decodable {
        guard let url = url else { return Fail(error: JsonPlaceholderServiceErrors.invalidURL).eraseToAnyPublisher() }
        
        let publisher = session.dataTaskPublisher(for: url)
            .tryMap { (data, response) in
                guard let httpResponse = response as? HTTPURLResponse,
                      (200..<300).contains(httpResponse.statusCode) else { throw JsonPlaceholderServiceErrors.badResponse }
                
                return data
            }
            .decode(type: [T].self, decoder: JSONDecoder())
            .receive(on: DispatchQueue.main)
            .eraseToAnyPublisher()
        
        return publisher
    }
}
