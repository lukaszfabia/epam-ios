//
//  ImageData.swift
//  Task2
//
//  Created by Lukasz Fabia on 15/07/2025.
//

import Foundation

struct LoremPicsumData: Decodable, Image {
    
    let id: String
    let author: String
    let width: Int
    let height: Int
    let url: String
    let downloadUrl: String
    
    enum CodingKeys: String, CodingKey {
        case id
        case author
        case width
        case height
        case url
        case downloadUrl = "download_url"
    }
    
    var urlToUse: URL {
        URL(string: downloadUrl)!
    }
    
    var imageAuthor: String {
        author
    }
    
}
