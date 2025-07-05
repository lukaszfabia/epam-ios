//
//  MovieSerivce.swift
//  Imdb
//
//  Created by Lukasz Fabia on 03/07/2025.
//

import Foundation
import UIKit

final class TMDBApiService {
    
    static let service = TMDBApiService()
    
    enum TMDBErrors: Error {
        case failedToDecode
        case invalidURL
    }
    
    private enum AllowedMethods: String {
        case GET
    }
    
    private struct Response<T: Decodable>: Decodable {
        let page: Int
        let results: [T]
        let total_pages: Int
        let total_results: Int
 
    }
    
    // /tmU7GeKVybMWFButWEGl2M4GeiP.jpg
    func loadImage(endpoint: String, imageView: UIImageView) {
        guard let url = URL(string: endpoint) else {return}
        print("Requesting on: ", url.description)
        
        URLSession.shared.dataTask(with: URLRequest(url: url)) {data, response, error in
        
            if let err = error {
                print("Error during fetching image", err)
                
                
                DispatchQueue.main.async {
                    imageView.image = UIImage(systemName: "xmark")
                    imageView.image?.withTintColor(.systemGray)
                }
                
                return
            }
            
            
            guard let data = data else {
                DispatchQueue.main.async {
                    imageView.image = UIImage(systemName: "xmark")
                    imageView.image?.withTintColor(.systemGray)
                }
                
                return
            }
            
                
            let image = UIImage(data: data)
            
            DispatchQueue.main.async {
                imageView.image = image
            }
            
            
        }.resume()
    }
    
    func get<T: Decodable>(endpoint: String = "/movie/top_rated", page: Int = 1) async throws -> [T] {
        print("\(EnvironmentVariables.baseUrl)\(endpoint)")
        guard let url = URL(string: "\(EnvironmentVariables.baseUrl)\(endpoint)") else {
            throw TMDBErrors.invalidURL
        }
        
        
        var components = URLComponents(url: url, resolvingAgainstBaseURL: true)!
        let queryItems: [URLQueryItem] = [
            URLQueryItem(name: "language", value: "en-US"),
            URLQueryItem(name: "page", value: "\(page)"),
            URLQueryItem(name: "api_key", value: EnvironmentVariables.apiSecret)
        ]
        components.queryItems = queryItems
        
        var request = URLRequest(url: components.url!)
        request.httpMethod = AllowedMethods.GET.rawValue
        request.timeoutInterval = 10
        request.setValue("application/json", forHTTPHeaderField: "Accept")
        
        do {
            let (data, _) = try await URLSession.shared.data(for: request)
            print(String(decoding: data, as: UTF8.self))
            
      
            let wrapper = try JSONDecoder().decode(Response<T>.self, from: data)
            return wrapper.results
        } catch {
            print("Decoding error: \(error)")
            throw TMDBErrors.failedToDecode
        }
    }

}
