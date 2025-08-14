//
//  UIKitCard.swift
//  Task2
//
//  Created by Lukasz Fabia on 14/08/2025.
//

import UIKit

fileprivate let stackPadding: CGFloat = 10.0

class UIKitCard: UIView {
    
    private let vStack: UIStackView = {
        let stack = UIStackView()
        
        stack.translatesAutoresizingMaskIntoConstraints = false
        
        stack.backgroundColor = .systemBlue.withAlphaComponent(0.05)
        stack.layer.cornerRadius = 10
        stack.layer.borderWidth = 1
        stack.layer.borderColor = .init(red: 0, green: 0, blue: 1, alpha: 0.7)
        stack.layoutMargins = .init(top: stackPadding, left: stackPadding, bottom: stackPadding, right: stackPadding)
        stack.isLayoutMarginsRelativeArrangement = true
        stack.axis = .vertical
        
        stack.spacing = 8
        
        stack.distribution = .fillProportionally
        
        return stack
    }()
    
    private let titleLabel: UILabel = {
       let label = UILabel()
        label.font = .systemFont(ofSize: 24, weight: .heavy)
        label.numberOfLines = 1
        label.textColor = .label
        return label
    }()
    
    private let subtitleLabel: UILabel = {
       let label = UILabel()
        label.font = .systemFont(ofSize: 18, weight: .semibold)
        label.textColor = .secondaryLabel
        label.numberOfLines = 1
        return label
    }()
    
    private let descLabel: UILabel = {
       let label = UILabel()
        label.font = .systemFont(ofSize: 14, weight: .regular)
        label.numberOfLines = 0
        label.textColor = .label
        return label
    }()

    var title: String
    var subtitle: String
    var desc: String
    
    init(title: String, subtitle: String, desc: String) {
        self.title = title
        self.desc = desc
        self.subtitle = subtitle
        
        super.init(frame: .zero)
        
        setLabelText()
        
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setLabelText() {
        titleLabel.text = title
        subtitleLabel.text = subtitle
        descLabel.text = desc
    }
    
    private func setupUI() {
        addSubview(vStack)
        
        vStack.addArrangedSubview(titleLabel)
        vStack.addArrangedSubview(subtitleLabel)
        vStack.addArrangedSubview(descLabel)
        
        NSLayoutConstraint.activate([
            vStack.topAnchor.constraint(equalTo: topAnchor),
            vStack.leadingAnchor.constraint(equalTo: leadingAnchor),
            vStack.trailingAnchor.constraint(equalTo: trailingAnchor),
        ])
    }
}
