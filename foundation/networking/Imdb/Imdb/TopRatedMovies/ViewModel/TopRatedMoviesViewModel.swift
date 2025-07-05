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
    
    
    func fetchTopMovies() {
        isLoading = true
        
        
        Task {
            
            defer {isLoading = false}
            
            do {
                topRatedMovies.append(contentsOf: try await TMDBApiService.service.get())
            } catch let err {
                error = err
            }
        }
    }
    
    func fetchMore() {
        isLoadingMore = true
        page+=1
        
        
        Task {
            
            defer {isLoadingMore = false}
            
            do {
                topRatedMovies.append(contentsOf: try await TMDBApiService.service.get(page: page))
            } catch let err {
                error = err
            }
        }
    }
    
    subscript(index: Int) -> Movie? {
        return topRatedMovies[index]
    }
    
}
