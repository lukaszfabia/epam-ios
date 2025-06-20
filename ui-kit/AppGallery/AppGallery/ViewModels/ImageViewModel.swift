//
//  ImageViewModel.swift
//  AppGallery
//
//  Created by Lukasz Fabia on 20/06/2025.
//

import Foundation

class ImageViewModel {
    private var imagesGroupedByYear: [Int: [Image]] = [:]
    private var sortedYears: [Int] = []

    init(_ imgs: [Image]) {
        setupImages(imgs)
    }

    private func setupImages(_ imgs: [Image]) {
        for image in imgs {
            imagesGroupedByYear[image.year, default: []].append(image)
        }
        
        sortedYears = imagesGroupedByYear.keys.sorted(by: {$0 > $1})
    }

    func numberOfSections() -> Int {
        return sortedYears.count
    }

    func numberOfItems(in section: Int) -> Int {
        let year = sortedYears[section]
        return imagesGroupedByYear[year]?.count ?? 0
    }

    func year(at section: Int) -> Int {
        return sortedYears[section]
    }

    func image(at indexPath: IndexPath) -> Image? {
        let year = sortedYears[indexPath.section]
        return imagesGroupedByYear[year]?[indexPath.item]
    }

    func toggleFavorite(at indexPath: IndexPath) -> (Bool, String)? {
        let year = sortedYears[indexPath.section]
        
        guard let image = imagesGroupedByYear[year]?[indexPath.item] else { return nil }
        
        image.isFavorite.toggle()
        
        imagesGroupedByYear[year]?[indexPath.item] = image
        return (image.isFavorite, image.title)
    }

    func deleteImage(at indexPath: IndexPath) {
        let year = sortedYears[indexPath.section]
        imagesGroupedByYear[year]?.remove(at: indexPath.item)
        
        if imagesGroupedByYear[year]?.isEmpty == true {
            imagesGroupedByYear.removeValue(forKey: year)
            sortedYears.removeAll { $0 == year }
        }
    }
}
