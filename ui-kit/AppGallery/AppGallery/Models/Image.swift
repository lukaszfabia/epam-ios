//
//  Image.swift
//  AppGallery
//
//  Created by Lukasz Fabia on 20/06/2025.
//

import Foundation

class Image: Identifiable, Comparable, Equatable {
    let id: UUID = UUID()
    let title: String
    let name : String
    let year: Int
    var isFavorite: Bool = false
    
    init(title: String, name: String, year: Int) {
        self.title = title
        self.name = name
        self.year = year
    }
    
    // MARK: operators defs
    
    static func < (lhs: Image, rhs: Image) -> Bool {
        return lhs.year < rhs.year
    }
    
    static func > (lhs: Image, rhs: Image) -> Bool {
        return lhs.year > rhs.year
    }
    
    static func == (lhs: Image, rhs: Image) -> Bool {
        return lhs.id == rhs.id
    }
    
    static func dummies() -> [Image] {
        return [
            Image(title: "Maciej Maciak Core", name: "maciej", year: 2023),
            Image(title: "Jenna Ortega", name: "jo", year: 2023),
            Image(title: "Matheus de Bohr", name: "test2", year: 2023),
            Image(title: "moje dziabko kupiłx mi Dubai Chocolate😭😭😭", name: "dubaichoco", year: 2022),
            Image(title: "Maciej Maciak Core", name: "maciej", year: 2023),
            Image(title: "Jenna Ortega", name: "jo", year: 2024),
            Image(title: "Matheus de Bohr", name: "test2", year: 2025),
            Image(title: "moje dziabko kupiłx mi Dubai Chocolate😭😭😭", name: "dubaichoco", year: 2023),
         ]
    }
}


