//
//  LoremPicsumService.swift
//  Task2
//
//  Created by Lukasz Fabia on 24/07/2025.
//

import Foundation

class LoremPicsumService: ImageService {
    private var urlBuilder = URLComponents()
    
    private let session: URLSession
    
    enum LoremPicsumServiceError: Error {
        case invalidUrl, networkError, decodingError, invalidResponse
    }
    
    init(session: URLSession = URLSession.shared) {
        self.session = session
        
        self.urlBuilder.host = "picsum.photos"
        self.urlBuilder.scheme = "https"
        self.urlBuilder.path = "/v2/list"
    }
    
    private func buildUrl(page: Int, limit: Int) -> URL? {
        urlBuilder.queryItems = [
            .init(name: "page", value: "\(page)"),
            .init(name: "limit", value: "\(limit)"),
        ]
        
        return urlBuilder.url
    }
    
    
    func fetchImageList(page: Int, limit: Int) async throws -> [any Image] {
        guard let url = buildUrl(page: page, limit: limit) else {throw LoremPicsumServiceError.invalidUrl}
        
        do {
            let (data, response) = try await session.data(from: url)
            
            guard let httpResponse = response as? HTTPURLResponse else {throw LoremPicsumServiceError.invalidResponse}
            
            guard (200..<300).contains(httpResponse.statusCode) else {throw LoremPicsumServiceError.invalidResponse}
            
            
            do {
                let decoded = try JSONDecoder().decode([LoremPicsumData].self, from: data)
                
                
                return decoded
            } catch let err {
                print("Failed to decode JSON: \(err.localizedDescription)")
                throw LoremPicsumServiceError.decodingError
            }
            
            
        } catch let err {
            print("Error: \(err.localizedDescription)")
            throw LoremPicsumServiceError.networkError
        }
        
    }
    
    
}
