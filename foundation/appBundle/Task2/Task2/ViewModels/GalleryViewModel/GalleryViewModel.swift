//
//  GalleryViewModel.swift
//  Task2
//
//  Created by Lukasz Fabia on 24/07/2025.
//

import Foundation
import UIKit


@MainActor
protocol GalleryViewModel {
    var images: [Image] { get }
    var cacheService: any Cachable {get}
    var imageService: any ImageService {get}
    
    var page: Int {get set}
    var limit: Int {get set}
    
    var isLoading: Bool {get set}
    var error: String? {get set}
    
    func getImage(at index: IndexPath) async -> UIImage
    
    func fetchImages() async 
}


extension GalleryViewModel {
    func clearCache() {
        cacheService.clear()
    }
}
