//
//  ImageFlowLayout.swift
//  AppGallery
//
//  Created by Lukasz Fabia on 20/06/2025.
//

import UIKit

class ImageFlowLayout: UICollectionViewFlowLayout {
    private var verticalColumnsAmount = 2.0
    private var horizontalColumnsAmount = 4.0
    
    private func getColumns(for view: UICollectionView) -> CGFloat {
        let isVertical = view.bounds.height > view.bounds.width
        
        return isVertical ? verticalColumnsAmount : horizontalColumnsAmount
    }
    
    override func prepare() {
        super.prepare()
        guard let collectionView = collectionView else { return }
        
        sectionInset = .init(top: 20, left: 10, bottom: 10, right: 10)
        minimumInteritemSpacing = 10
        minimumLineSpacing = 10
        
        let columns = getColumns(for: collectionView)
        // spacing = 10 * (2 - 1) + 20 = 30 vertical
        // spacing = 10 * (4 - 1) + 20 = 50 horizontal
        let spacing = minimumInteritemSpacing * (columns - 1) + sectionInset.left + sectionInset.right
        
        // to prevent neg values jsut take the only pos values
        // safewdt = width (depens of the ip) - spacing
        let safeWidth = max(collectionView.bounds.width - spacing, 1)
    
        let itemWidth = floor(safeWidth / columns) 
        
        itemSize = .init(width: itemWidth, height: itemWidth + 40)
        headerReferenceSize = .init(width: collectionView.bounds.width, height: 60)
    }
}

