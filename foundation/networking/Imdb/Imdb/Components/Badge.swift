//
//  Badge.swift
//  Imdb
//
//  Created by Lukasz Fabia on 05/07/2025.
//

import UIKit


class Badge: UILabel {
    
    private let padding = UIEdgeInsets(top: 4, left: 8, bottom: 4, right: 8)
    
    private var bgColor: UIColor
    private var textCol: UIColor

    init(with background: UIColor, textColor: UIColor = .label) {
        self.bgColor = background
        self.textCol = textColor
        super.init(frame: .zero)
        setup()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }


    private func setup() {
        translatesAutoresizingMaskIntoConstraints = false
        backgroundColor = bgColor.withAlphaComponent(0.8)
        textColor = textCol
        textAlignment = .center
        font = .systemFont(ofSize: 11, weight: .semibold)
        numberOfLines = 1
        clipsToBounds = true
        layer.cornerRadius = 12
        layer.borderColor = bgColor.cgColor
        layer.borderWidth = 1
        
        setContentHuggingPriority(.required, for: .horizontal)
    }

    override func drawText(in rect: CGRect) {
        super.drawText(in: rect.inset(by: padding))
    }

    override var intrinsicContentSize: CGSize {
        let size = super.intrinsicContentSize
        return CGSize(
            width: size.width + padding.left + padding.right,
            height: size.height + padding.top + padding.bottom
        )
    }
}
