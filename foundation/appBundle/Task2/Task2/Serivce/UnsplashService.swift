//
//  UnsplashService.swift
//  Task2
//
//  Created by Lukasz Fabia on 15/07/2025.
//

import Foundation

enum UnsplashServiceErrors: Error {
    case failedToDownload, unknown, failedToDecode, badRequest, networkError
}

class UnsplashService: ImageService {
    private static let endpoint = "https://api.unsplash.com/photos"
    
    private struct ImageTypes {
        static let raw = "raw"
        static let full = "full"
        static let regural = "regular"
        static let small = "small"
        static let thumb = "thumb"
        static let small_s3 = "small_s3"
    }
    
    
    func fetchImageList(perPage: Int = 10) async throws -> [URL] {
        let accessKey = ""

        guard let url = URL(string: "https://api.unsplash.com/photos?per_page=\(perPage)") else {
            return []
        }

        var request = URLRequest(url: url)
        request.setValue("Client-ID \(accessKey)", forHTTPHeaderField: "Authorization")

        do {
            let (data, response) = try await URLSession.shared.data(for: request)

            guard let res = response as? HTTPURLResponse else {
                throw UnsplashServiceErrors.unknown
            }

            guard res.statusCode == 200 else {
                throw UnsplashServiceErrors.badRequest
            }

            do {
                let jsonObj = try JSONSerialization.jsonObject(with: data) as? [[String: Any]]

                let urls: [URL] = jsonObj?.compactMap { elem in
                    guard let urls = elem["urls"] as? [String: String],
                          let url = urls[ImageTypes.raw]
                            
                    else {
                        return nil
                    }
                    
                    return URL(string: url)
                } ?? []

                return urls

            } catch {
                throw UnsplashServiceErrors.failedToDecode
            }

        } catch let err as URLError {
            print("Error: ", err.localizedDescription)
            throw UnsplashServiceErrors.networkError
        } catch {
            print("Error: ", error.localizedDescription)
            throw UnsplashServiceErrors.unknown
        }
    }
    
    
}
