//
//  CollectionViewCell.swift
//  Task3
//
//  Created by Lukasz Fabia on 23/07/2025.
//

import UIKit

class CollectionViewCell: UICollectionViewCell {
    
    private let imageView: UIImageView  = {
        let iv = UIImageView()
        iv.contentMode = .scaleAspectFit
        iv.translatesAutoresizingMaskIntoConstraints = false
        iv.layer.cornerRadius = 12
        
        iv.clipsToBounds = true
        
        return iv
    }()
    
    private let titleLabel: UILabel = {
        let l = UILabel()
        l.translatesAutoresizingMaskIntoConstraints = false
        l.font = .systemFont(ofSize: 14, weight: .light)
        l.textColor = .secondaryLabel
        l.adjustsFontSizeToFitWidth = true
        l.setContentHuggingPriority(.required, for: .vertical)
        l.setContentCompressionResistancePriority(.required, for: .vertical)

        return l
    }()
    
    required init?(coder: NSCoder) {
        fatalError("not impl")
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setup()
    }
    
    
    private func setup() {
        contentView.addSubview(titleLabel)
        contentView.addSubview(imageView)
        
        NSLayoutConstraint.activate([
            imageView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 10),
            imageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 10),
            imageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -10),

            titleLabel.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: 2),
            titleLabel.centerXAnchor.constraint(equalTo: imageView.centerXAnchor),
            titleLabel.bottomAnchor.constraint(lessThanOrEqualTo: contentView.bottomAnchor, constant: -5)
        ])


    }
    
    
    func use(with imageInfo: Image, onErrorIcon: String) {
        let image = UIImage(named: imageInfo.path) ?? UIImage(systemName: onErrorIcon) ?? UIImage(systemName: "xmark")
        
        imageView.image = image

        
        titleLabel.text = imageInfo.title
    }

}
