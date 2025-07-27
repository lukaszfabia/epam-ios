//
//  GalleryViewModel.swift
//  Task2
//
//  Created by Lukasz Fabia on 24/07/2025.
//

import Foundation
import UIKit

class GalleryViewModelImpl: GalleryViewModel {
    
    var isLoading: Bool = false
    
    var error: String? = nil
    
    var page: Int = 0
    
    var limit: Int = 10
    
    var cacheService: any Cachable
    
    var imageService: any ImageService
    
    var images: [any Image]
    
    init(cacheService: any Cachable = CacheService(), imageService: any ImageService = LoremPicsumService(), images: [any Image] = []) {
        self.cacheService = cacheService
        self.imageService = imageService
        self.images = images
    }
    
    func getImage(at index: IndexPath) async -> UIImage {
        let url = images[index.row].urlToUse
        return await cacheService.load(from: url)
    }

    func fetchImages() async {
        isLoading = true
        defer { isLoading = false }
        
        page += 1
        
        do {
            let fetchedImages = try await imageService.fetchImageList(page: page, limit: limit)
            self.images = fetchedImages
            
            print(fetchedImages)
        } catch {
            self.handleError()
        }
    }

    
    private func handleError() {
        self.error = "Failed to fetch images"
        self.images = []
    }

}
