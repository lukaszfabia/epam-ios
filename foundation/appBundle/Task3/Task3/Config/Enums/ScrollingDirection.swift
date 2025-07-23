//
//  ScrollingDirection.swift
//  Task3
//
//  Created by Lukasz Fabia on 23/07/2025.
//

import UIKit

enum ScrollingDirection: String, Codable {
    case vertical, horizontal
}


extension ScrollingDirection {
    var direction: UICollectionView.ScrollDirection{
        return self == .horizontal ? .horizontal : .vertical
    }
}
