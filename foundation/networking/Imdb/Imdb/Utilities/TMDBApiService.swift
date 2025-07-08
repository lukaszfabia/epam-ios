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
    private let acceptedRange = (200..<300)
    
    enum TMDBErrors: Error {
        case failedToDecode
        case invalidURL
        case unknown
        case networkError
        case httpError
    }
    
    private enum AllowedMethods: String {
        case GET
    }
    
    private func checkResponse(_ response: URLResponse) throws {
        guard let httpResponse = response as? HTTPURLResponse else {
            throw TMDBErrors.networkError
        }

        let statusCode = httpResponse.statusCode
        guard acceptedRange.contains(statusCode) else {
            throw TMDBErrors.httpError
        }
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
    
    private func setPlaceholderImage(imageView: UIImageView) {
        imageView.image = UIImage(systemName: "xmark")?.withTintColor(.systemGray, renderingMode: .alwaysOriginal)
    }
    
    func loadListData<T: Decodable>(url: String = "\(EnvironmentVariables.baseUrl)/genre/movie/list") async throws -> [T] {
        guard let url = URL(string: url) else {
            throw TMDBErrors.invalidURL
        }
        
        let request = try prepareRequest(url: url)
        
        do {
            // second school of fetching 
            let (data, response) = try await URLSession.shared.data(for: request)
            
            try checkResponse(response)
            
            do {
                let decoded = try JSONDecoder().decode(ListResponseDTO<T>.self, from: data)
                
                return decoded.items
            } catch {
                throw TMDBErrors.failedToDecode
            }
        } catch let err as URLError {
            print("Error:", err)
            throw TMDBErrors.networkError
        } catch {
            throw TMDBErrors.unknown
        }
    }
    
    // /tmU7GeKVybMWFButWEGl2M4GeiP.jpg
    func loadImage(endpoint: String, imageView: UIImageView) {
        guard let url = URL(string: endpoint) else {
            setPlaceholderImage(imageView: imageView)
            return
        }
        
        URLSession.shared.dataTask(with: url) { data, response, error in
            DispatchQueue.main.async {
                if let error = error {
                    print("Image fetch error:", error)
                    self.setPlaceholderImage(imageView: imageView)
                    return
                }

                guard let data = data, let image = UIImage(data: data) else {
                    print("Invalid image data")
                    self.setPlaceholderImage(imageView: imageView)
                    return
                }

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
            let (data, response) = try await URLSession.shared.data(for: request)
            

            try checkResponse(response)
      
            do {
                let wrapper = try JSONDecoder().decode(PaginatedReponseDTO<T>.self, from: data)
                return wrapper.results
            } catch {
                print("Decoding error: \(error)")
                throw TMDBErrors.failedToDecode
            }
        }
        catch let err as URLError {
            print("Net error")
            throw TMDBErrors.networkError
        }
        catch let err {
            print("Error", err.localizedDescription)
            throw TMDBErrors.unknown
        }
    }

}
