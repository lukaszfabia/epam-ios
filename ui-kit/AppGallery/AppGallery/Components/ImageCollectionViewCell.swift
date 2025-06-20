//
//  ImageCollectionViewCell.swift
//  AppGallery
//
//  Created by Lukasz Fabia on 20/06/2025.
//

import UIKit

protocol ImageCellDelegate: AnyObject {
    func imageCollectionViewCellHandleFavButtonTap(_ cell: ImageCollectionViewCell)
}

class ImageCollectionViewCell: UICollectionViewCell {
    
    weak var alertDelegate: ImageCellDelegate?
    private var image: Image?
    
    private let imageView: UIImageView = {
        let iv = UIImageView()
        iv.contentMode = .scaleAspectFill
        iv.clipsToBounds = true
        iv.layer.cornerRadius = 8
        iv.translatesAutoresizingMaskIntoConstraints = false
        return iv
    }()
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 15, weight: .light)
        label.textColor = .secondaryLabel
        label.numberOfLines = 2
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let favButton: UIButton = {
        let btn = UIButton()
        btn.tintColor = .systemRed
        btn.backgroundColor = .clear
        btn.translatesAutoresizingMaskIntoConstraints = false
        btn.setImage(UIImage(systemName: "heart"), for: .normal)
        btn.setImage(UIImage(systemName: "heart.fill"), for: .selected)
        return btn
    }()
    
    private let infoStack: UIStackView = {
        let stack = UIStackView()
        stack.axis = .horizontal
        stack.spacing = 8
        stack.alignment = .center
        stack.distribution = .fill
        stack.translatesAutoresizingMaskIntoConstraints = false
        return stack
    }()

    private let mainStack: UIStackView = {
        let stack = UIStackView()
        stack.axis = .vertical
        stack.spacing = 8
        stack.distribution = .fill
        stack.translatesAutoresizingMaskIntoConstraints = false
        return stack
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)

        contentView.addSubview(mainStack)
        mainStack.addArrangedSubview(imageView)
        mainStack.addArrangedSubview(infoStack)
        
        infoStack.addArrangedSubview(titleLabel)
        infoStack.addArrangedSubview(favButton)
        
        NSLayoutConstraint.activate([
            mainStack.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 10),
            mainStack.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 10),
            mainStack.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -10),
            mainStack.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -10),

            imageView.heightAnchor.constraint(equalTo: imageView.widthAnchor),
            favButton.heightAnchor.constraint(equalTo: favButton.widthAnchor),
        ])
        
        registerHandlers()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    
    // MARK: Setup cell content
    
    func use(with image: Image) {
        self.image = image
        imageView.image = UIImage(named: image.name)
        titleLabel.text = image.title
        favButton.isSelected = image.isFavorite
    }
    
    // MARK: Handlers
    
    private func registerHandlers() {
        favButton.addTarget(self, action: #selector(handleFavButtonTap), for: .touchUpInside)
    }
    
    @objc private func handleFavButtonTap() {
        alertDelegate?.imageCollectionViewCellHandleFavButtonTap(self)
    }
}
