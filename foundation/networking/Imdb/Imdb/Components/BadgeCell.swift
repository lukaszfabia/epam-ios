//
//  BadgeCollectionViewCell.swift
//  Imdb
//
//  Created by Lukasz Fabia on 08/07/2025.
//

import UIKit

class BadgeCell: UICollectionViewCell {
    
    private let label: UILabel = {
        let l = UILabel()
        l.translatesAutoresizingMaskIntoConstraints = false
        l.textAlignment = .center
        l.numberOfLines = 1
        l.font = .systemFont(ofSize: 14, weight: .medium)
        l.textColor = .white
        return l
    }()
    
    private var isAdult: Bool = false

    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setup() {
        contentView.addSubview(label)
        contentView.clipsToBounds = true
        
        let paddingY: CGFloat = 6
        let paddingX: CGFloat = 12

        NSLayoutConstraint.activate([
            label.topAnchor.constraint(equalTo: contentView.topAnchor, constant: paddingY),
            label.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -paddingY),
            label.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: paddingX),
            label.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -paddingX),
            
            label.heightAnchor.constraint(greaterThanOrEqualToConstant: 20)
        ])
    }

    override func layoutSubviews() {
        super.layoutSubviews()
        contentView.layer.cornerRadius = contentView.frame.height / 2
    }

    func use(with text: String, isAdult: Bool = false) {
        label.text = text
        contentView.backgroundColor = isAdult
            ? UIColor.systemRed.withAlphaComponent(0.7)
            : UIColor.systemGray.withAlphaComponent(0.3)
        
        contentView.layer.borderColor = isAdult
            ? UIColor.systemRed.cgColor
            : UIColor.systemGray4.cgColor
        contentView.layer.borderWidth = 1
    }
}
