//
//  FileService.swift
//  Task1
//
//  Created by Lukasz Fabia on 10/07/2025.
//

import Foundation

enum FileServiceErrors: Error {
    case failedToSave, failedToEncode, directoryDoesNotExists, fileNotExists, failedToRead
}

extension FileServiceErrors: LocalizedError {
    var errorDescription: String? {
        switch self {
        case .directoryDoesNotExists: return "Directory does not exists."
        case .fileNotExists: return "Could not find destination file."
        case .failedToEncode: return "Failed to encode data."
        case .failedToRead: return "Failed to read data."
        case .failedToSave: return "Failed to save data."
            
        }
    }
}

extension JsonService {
    private func generateUniqueFileName() -> String {
        return Date().timeIntervalSinceNow.description
    }
}


//- Save user-entered text into a file in the Documents directory.
//- Retrieve and display the content of the saved file when requested.
//- Ensure the files are private and only accessible to the app.


class JsonService: FileService {
    
    private let documentsDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first
    
    func save<T>(_ obj: T) throws -> T where T: ReadWriteAccessible {
        guard let destination = documentsDirectory else {
            print("Failed to find documents directory")
            throw FileServiceErrors.directoryDoesNotExists
        }
        
        let filename = obj.filename ?? generateUniqueFileName()
        
        let path = destination.appendingPathComponent(filename, conformingTo: .json)
        
        var content: Data? = nil
        
        do {
            content = try JSONEncoder().encode(obj)
        } catch {
            throw FileServiceErrors.failedToEncode
        }
        
        do {
            guard let content = content else {throw FileServiceErrors.failedToEncode}
            try content.write(to: path, options: .atomic)
            

            if obj.filename != nil {
                return obj
            }
            
            var res = obj
            res.filename = filename
            
            return res
        
        } catch let err {
            print("Error: ", err.localizedDescription)
            throw FileServiceErrors.failedToSave
        }
        
    }
    
    func retrieve<T>(_ obj: T) throws -> T where T: ReadWriteAccessible {
        guard let destination = documentsDirectory else {
            print("Failed to find documents directory")
            throw FileServiceErrors.directoryDoesNotExists
        }
        
        guard let filename = obj.filename else {
            throw FileServiceErrors.fileNotExists
        }
        
        let path = destination.appendingPathComponent(filename, conformingTo: .json)
        
        var content: String? = nil
        
        do {
            content = try String(contentsOf: path, encoding: .utf8)
        
        } catch let err {
            print("Error: ", err.localizedDescription)
            throw FileServiceErrors.failedToRead
        }
        
        do {
            guard let content = content, let data = content.data(using: .utf8) else {throw FileServiceErrors.failedToRead}
   
            
            let decoded = try JSONDecoder().decode(T.self, from: data)
            
            return decoded
        } catch let err {
            print("Error: ",err.localizedDescription)
            throw FileServiceErrors.failedToEncode
        }
    
    }
    
    func getAll<T>() -> [T] where T : ReadWriteAccessible {
        guard let destination = documentsDirectory else {
            print("Failed to find documents directory")
            return []
        }
        
        var paths: [URL] = []
        
        do {
            paths = try FileManager.default.contentsOfDirectory(at: destination, includingPropertiesForKeys: nil, options: [])
        } catch let err {
            print("No files in dir: ", err.localizedDescription)
            return []
        }
        
        print(paths)
        
        var files: [T] = []
        
        for elem in paths where elem.pathExtension == T.ext {
            do {
                let data = try Data(contentsOf: elem)
                var decoded = try JSONDecoder().decode(T.self, from: data)
                decoded.filename = elem.deletingPathExtension().lastPathComponent
                files.append(decoded)
            } catch let err {
                print("Error: ", err.localizedDescription)
            }
        }
        
        print(files)
        
        return files
    }
    
}
