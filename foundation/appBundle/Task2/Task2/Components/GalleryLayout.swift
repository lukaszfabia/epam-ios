//
//  GalleryLayout.swift
//  Task2
//
//  Created by Lukasz Fabia on 24/07/2025.
//

import UIKit

class GalleryLayout: UICollectionViewFlowLayout {
    override func prepare() {
        super.prepare()

        scrollDirection = .vertical
        minimumLineSpacing = 0
        sectionInset = .zero

        guard let collectionView = collectionView else { return }

        let width = collectionView.bounds.width
        let height = collectionView.bounds.height

        itemSize = CGSize(width: width, height: height)
    }
}
