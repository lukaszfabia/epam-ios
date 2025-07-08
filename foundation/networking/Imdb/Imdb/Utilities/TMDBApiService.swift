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
        case badRequest
    }
    
    private enum AllowedMethods: String {
        case GET
    }
    
    private func prepareRequest(url: URL, page: Int? = nil) throws -> URLRequest {
        var components = URLComponents(url: url, resolvingAgainstBaseURL: true)!
        var queryItems: [URLQueryItem] = [
            URLQueryItem(name: "language", value: "en-US"),
            URLQueryItem(name: "api_key", value: EnvironmentVariables.apiSecret)
        ]
        
        if let page = page {
            queryItems.append(URLQueryItem(name: "page", value: "\(page)"))
        }
        
        
        components.queryItems = queryItems
        
        var request = URLRequest(url: components.url!)
        request.httpMethod = AllowedMethods.GET.rawValue
        request.timeoutInterval = 10
        request.setValue("application/json", forHTTPHeaderField: "Accept")
        
        return request
    }
    
    func loadListData<T: Decodable>(url: String = "\(EnvironmentVariables.baseUrl)/genre/movie/list") async throws -> [T] {
        guard let url = URL(string: url) else {
            throw TMDBErrors.invalidURL
        }
        
        let request = try prepareRequest(url: url)
        
        do {
            // second school of fetching 
            let (data, _) = try await URLSession.shared.data(for: request)
            
            let decoded = try JSONDecoder().decode(ListResponseDTO<T>.self, from: data)
            
            return decoded.items
        } catch let err{
            print("Error:", err)
            throw TMDBErrors.failedToDecode
        }
    }
    
    // /tmU7GeKVybMWFButWEGl2M4GeiP.jpg
    func loadImage(endpoint: String, imageView: UIImageView) {
        guard let url = URL(string: endpoint) else {return}
        print("Requesting on: ", url.description)
        
        // first way to fetch
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
        guard let url = URL(string: "\(EnvironmentVariables.baseUrl)\(endpoint)") else {
            throw TMDBErrors.invalidURL
        }
        
        let request = try prepareRequest(url: url, page: page)
        
        do {
            let (data, _) = try await URLSession.shared.data(for: request)
            print(String(decoding: data, as: UTF8.self))
            
      
            let wrapper = try JSONDecoder().decode(PaginatedReponseDTO<T>.self, from: data)
            return wrapper.results
        } catch {
            print("Decoding error: \(error)")
            throw TMDBErrors.failedToDecode
        }
    }

}
