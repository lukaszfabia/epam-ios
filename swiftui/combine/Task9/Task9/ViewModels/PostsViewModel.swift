//
//  PostsViewModel.swift
//  Task9
//
//  Created by Lukasz Fabia on 02/08/2025.
//

import Combine

import Foundation

class PostsViewModel {
    @Published var isLoading: Bool = false
    @Published var error: String? = nil
    
    @Published var posts: [Post] = []
    
    private let networkService: any NetworkService
    private var subs = Set<AnyCancellable>()
    
    init(networkService: any NetworkService = JsonPlaceholderService()) {
        self.networkService = networkService
    }
    
    func fetchPosts() {
        error = nil
        isLoading = true
        
        let url = networkService.baseURL?.appending(path: "posts")
        
        networkService.fetch(url)
            .sink { [weak self] result in
                guard let self = self else { return }
                
                self.isLoading = false
    
                switch result {
                case .failure(let err):
                    print("Err: \(err.localizedDescription)")
                    self.error = "Something went wrong: \(err.localizedDescription)"
                case .finished:
                    break
                }
            } receiveValue: { [weak self] (posts: [Post]) in
                self?.posts = posts
            }
            .store(in: &subs)
    }
    
}
