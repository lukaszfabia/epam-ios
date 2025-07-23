//
//  FlowLayout.swift
//  Task3
//
//  Created by Lukasz Fabia on 23/07/2025.
//

import UIKit

class VerticalFlowLayout: UICollectionViewFlowLayout {
    private let grid: Grid

    init(grid: Grid) {
        self.grid = grid
        super.init()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func prepare() {
        super.prepare()

        guard let collectionView = collectionView else { return }

        scrollDirection = grid.scrollingDirection.direction

        let spacing: CGFloat = grid.spacing
        minimumInteritemSpacing = spacing
        minimumLineSpacing = spacing
        sectionInset = UIEdgeInsets(top: grid.padding, left: grid.padding, bottom: grid.padding, right: grid.padding)

        let cols = grid.cols ?? Grid.defaultCols

        let totalSpacing = spacing * CGFloat(cols + 1)
        let availableWidth = collectionView.bounds.width - totalSpacing

        let itemWidth = availableWidth / CGFloat(cols)
        let itemHeight = itemWidth * 1.1

        itemSize = CGSize(width: itemWidth, height: itemHeight)
    }

}
