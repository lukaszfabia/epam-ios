//
//  CacheService.swift
//  Task2
//
//  Created by Lukasz Fabia on 15/07/2025.
//

import Foundation
import UIKit

class CacheService: Cachable {
    private let questionMarkImage = UIImage(systemName: "questionmark")!
    
    private let fileManager: FileManager
    private let temporaryDirectory: URL
    private let session: URLSession
    
    enum CacheServiceError: Error {
        case fileAlreadyExists, unknown, invalidURL, failedToSave
    }
    
    init(fileManager: FileManager = .default, session: URLSession = .shared) {
        self.fileManager = fileManager
        self.session = session
        self.temporaryDirectory = fileManager.temporaryDirectory
        
        listenOnMemoryWarnings()
    }
    
    func listenOnMemoryWarnings() {
        NotificationCenter.default.addObserver(self, selector: #selector(handleMemoryWarn), name: UIApplication.didReceiveMemoryWarningNotification, object: nil)
    }

        
    @objc func handleMemoryWarn() {
        print("System needs more memory, clearing...")
        clear()
    }
    
    func load(from url : URL) async -> UIImage {
        
        if let cachedImage = retrieve(from: url) {
            return cachedImage
        }
        
        let downloadedImage = await download(from: url)
        
        return downloadedImage
    }
    
    func clear() {
        print("Clearing")
        do {
            let files = try fileManager.contentsOfDirectory(atPath: temporaryDirectory.path)
            files.forEach { filename in
                do {
                    try fileManager.removeItem(at: temporaryDirectory.appendingPathComponent(filename))
                } catch let err {
                    print("Error during removing file: \(err.localizedDescription)")
                }
            }
        } catch let err {
            print("Error: \(err.localizedDescription)")
        }
    }
    
    func retrieve(from url: URL) -> UIImage? {
        let filename = getHashValue(for: url)
        
        print("Trying to retrieve: \(filename)")
        
        let pathToCheck = temporaryDirectory.appendingPathComponent(filename)
        
        if fileManager.fileExists(atPath: pathToCheck.path){
            do {
                let data = try Data(contentsOf: pathToCheck)
                
                print("Going to use cached :)")
                
                return UIImage(data: data)
                
            } catch let err {
                print("Error: \(err.localizedDescription)")
                
                return nil
            }
        }
        
        print("File not found in temporary directory")
        
        return nil
    }
    
    func download(from url: URL) async -> UIImage {
        print("Downloading image from \(url)")
        do {
            let (data, response) = try await session.data(from: url)
            guard let httpResponse = response as? HTTPURLResponse else {
                return questionMarkImage
            }
            
            guard (200..<300).contains(httpResponse.statusCode) else {
                return questionMarkImage
            }
            
            print("Successfully downloaded!")
            
            let filename = getHashValue(for: url)
            
            let destination = temporaryDirectory.appendingPathComponent(filename)
            
            try save(data, to: destination)
            
            return UIImage(data: data) ?? questionMarkImage
            
        } catch let err {
            print("Failed to download image: \(err.localizedDescription)")
            
            return questionMarkImage
        }
    }
    
    func save(_ data: Data, to url: URL) throws {
        
        print("Saving to temporary dir...")
        do {
            try data.write(to: url)
        } catch {
            throw CacheServiceError.failedToSave
        }
    }
    
    private func getHashValue(for filename: URL) -> String {
        return "\(filename.absoluteString.hashValue).jpg"
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self)
    }

}
