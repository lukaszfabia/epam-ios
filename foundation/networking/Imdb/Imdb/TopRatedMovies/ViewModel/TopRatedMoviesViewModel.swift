//
//  TopRatedMoviesViewModel.swift
//  Imdb
//
//  Created by Lukasz Fabia on 03/07/2025.
//

import Foundation

@MainActor
final class TopRatedMoviesViewModel {
    private var page = 1
    
    var moviesUpdate: (() -> Void)?
    var onLoading: ((Bool) -> Void)?
    var onLoadingMore: ((Bool) -> Void)?
    var onError: ((Error?) -> Void)?
    
    var genresDict: [Int: String] = [:]

    
    var topRatedMovies: [Movie] = [] {
        didSet {
            moviesUpdate?()
        }
    }
    
    var isLoading: Bool = false {
        didSet {
            onLoading?(isLoading)
        }
    }
    
    var isLoadingMore: Bool = false {
        didSet {
            onLoadingMore?(isLoadingMore)
        }
    }
    
    
    var error: Error? = nil {
        didSet {
            onError?(error)
        }
    }

    
    var numberOfRows: Int {
        topRatedMovies.count
    }
    
    init() {
        fetchGenres()
    }
    
    func fetchGenres() {
        isLoading = true
        
        Task {
            
            defer {isLoading = false}
            
            do {
                let genres: [Genre] = try await TMDBApiService.service.loadListData()
                genresDict = Dictionary(uniqueKeysWithValues: genres.map { ($0.id, $0.name) })

            } catch let err  {
                error = err
            }
        }
    }
    
    func fetchTopMovies() {
        isLoading = true

        Task {
            defer { isLoading = false }

            do {
                let movies: [Movie] = try await TMDBApiService.service.get()
                topRatedMovies = movies
                error = nil
            } catch {
                self.error = error
            }
        }
    }

    
    func fetchMore() {
        guard !isLoadingMore, error == nil else { return }

        
        isLoadingMore = true
        page+=1
        
        
        Task {
            
            defer {isLoadingMore = false}
            
            do {
                topRatedMovies.append(contentsOf: try await TMDBApiService.service.get(page: page))
                error = nil
            } catch let err {
                error = err
            }
        }
    }
    
    subscript(index: Int) -> Movie? {
        return topRatedMovies[index]
    }
    
    func getGenres(for movie: Movie) -> [String] {
        let genres = movie.genreIds.compactMap{genresDict[$0]}

        return genres
    }
    
}
