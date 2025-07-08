//
//  BadgeCollection.swift
//  Imdb
//
//  Created by Lukasz Fabia on 08/07/2025.
//

import UIKit

private let reuseIdentifier = "Badge"

final class BadgeCollection: UIView, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    var items: [String] = []
    
    private lazy var collectionView: UICollectionView = {
        let layout = BadgeCollectionLayout()
        let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
        cv.translatesAutoresizingMaskIntoConstraints = false
        cv.dataSource = self
        cv.delegate = self
        
        cv.register(BadgeCell.self, forCellWithReuseIdentifier: reuseIdentifier)
        
        cv.isScrollEnabled = false
        cv.backgroundColor = .clear
        
        cv.setContentHuggingPriority(.required, for: .vertical)
        cv.setContentCompressionResistancePriority(.required, for: .vertical)

        return cv
    }()

    init(items: [String]? = nil) {
        self.items = items ?? []
        super.init(frame: .zero)
        setupUI()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setupUI() {
        addSubview(collectionView)

        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: topAnchor),
            collectionView.bottomAnchor.constraint(equalTo: bottomAnchor),
            collectionView.leadingAnchor.constraint(equalTo: leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: trailingAnchor),
            
            collectionView.heightAnchor.constraint(greaterThanOrEqualToConstant: 40)
        ])
    }

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        items.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as? BadgeCell else {
            return UICollectionViewCell()
        }

        cell.use(with: items[indexPath.item])
        return cell
    }
    
    func reloadData() {
        collectionView.reloadData()
    }
}
