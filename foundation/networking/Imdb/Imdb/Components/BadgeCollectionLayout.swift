//
//  BadgeCollectionLayout.swift
//  Imdb
//
//  Created by Lukasz Fabia on 08/07/2025.
//

import UIKit

class BadgeCollectionLayout: UICollectionViewFlowLayout {
    override init() {
        super.init()
        scrollDirection = .vertical
        minimumLineSpacing = 5
        minimumInteritemSpacing = 5
        estimatedItemSize = UICollectionViewFlowLayout.automaticSize
        sectionInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
