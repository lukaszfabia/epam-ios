//
//  Movie.swift
//  Imdb
//
//  Created by Lukasz Fabia on 03/07/2025.
//


struct Movie: Decodable {
    let adult: Bool
    let backdropPath: String
    let genreIds: [Int]
    let id: Int
    let originalLanguage: String
    let originalTitle: String
    let overview: String
    let popularity: Double
    let posterPath: String // our main img
    let releaseDate: String
    let title: String
    let video: Bool
    let voteAverage: Double
    let voteCount: Int
    
    
    enum CodingKeys: String, CodingKey {
        case adult
        case backdropPath = "backdrop_path"
        case genreIds = "genre_ids"
        case id
        case originalLanguage = "original_language"
        case originalTitle = "original_title"
        case overview
        case popularity
        case posterPath = "poster_path"
        case releaseDate = "release_date"
        case title
        case video
        case voteAverage = "vote_average"
        case voteCount = "vote_count"
    }
    
    
    var year: String {
        let res = releaseDate.split(separator: "-")[0]
        return String(res)
    }
    
    var imageURL: String {
        return "\(EnvironmentVariables.baseImageUrl)/\(posterPath)"
    }
    
    var rating: String {
        String(format: "%.2f", voteAverage)
    }

    static func dummy() -> Movie {
        return Movie(
            adult: true,
            backdropPath: "/tmU7GeKVybMWFButWEGl2M4GeiP.jpg",
            genreIds: [18, 80],
            id: 238,
            originalLanguage: "en",
            originalTitle: "The Godfather",
            overview: "Spanning the years 1945 to 1955, a chronicle of the fictional Italian-American Corleone crime family. When organized crime family patriarch, Vito Corleone barely survives an attempt on his life, his youngest son, Michael steps in to take care of the would-be killers, launching a campaign of bloody revenge.",
            popularity: 26.4481,
            posterPath: "/3bhkrj58Vtu7enYsRolD1fZdja1.jpg",
            releaseDate: "1972-03-14",
            title: "The Godfather",
            video: false,
            voteAverage: 8.688,
            voteCount: 21584
        )
    }
}
