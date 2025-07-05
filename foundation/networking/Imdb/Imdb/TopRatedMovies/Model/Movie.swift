//
//  Movie.swift
//  Imdb
//
//  Created by Lukasz Fabia on 03/07/2025.
//


struct Movie: Decodable {
    let adult: Bool
    let backdrop_path: String
    let genre_ids: [Int]
    let id: Int
    let original_language: String
    let original_title: String
    let overview: String
    let popularity: Double
    let poster_path: String // our main img
    let release_date: String
    let title: String
    let video: Bool
    let vote_average: Double
    let vote_count: Int
    
    
    var year: String {
        let res = release_date.split(separator: "-")[0]
        return String(res)
    }
    
    var imageURL: String {
        return "\(EnvironmentVariables.baseImageUrl)/\(poster_path)"
    }
    
    var rating: String {
        String(format: "%.2f", vote_average)
    }

    static func dummy() -> Movie {
        return Movie(
            adult: true,
            backdrop_path: "/tmU7GeKVybMWFButWEGl2M4GeiP.jpg",
            genre_ids: [18, 80],
            id: 238,
            original_language: "en",
            original_title: "The Godfather",
            overview: "Spanning the years 1945 to 1955, a chronicle of the fictional Italian-American Corleone crime family. When organized crime family patriarch, Vito Corleone barely survives an attempt on his life, his youngest son, Michael steps in to take care of the would-be killers, launching a campaign of bloody revenge.",
            popularity: 26.4481,
            poster_path: "/3bhkrj58Vtu7enYsRolD1fZdja1.jpg",
            release_date: "1972-03-14",
            title: "The Godfather",
            video: false,
            vote_average: 8.688,
            vote_count: 21584
        )
    }
}
