//
//  ListCell.swift
//  Task1
//
//  Created by Lukasz Fabia on 14/07/2025.
//

import UIKit

final class ListCell: UITableViewCell {
    
    static let reuseID = "ListCell"
    
    private let hStack: UIStackView = {
        let stack = UIStackView()
        stack.axis = .horizontal
        stack.alignment = .center
        stack.spacing = 8
        stack.translatesAutoresizingMaskIntoConstraints = false
        return stack
    }()
    
    private let name: UILabel = {
        let label = UILabel()
        label.numberOfLines = 1
        label.font = .systemFont(ofSize: 16, weight: .regular)
        label.textColor = .label
        return label
    }()
    
    private let rightArrowView: UIImageView = {
        let imageView = UIImageView(image: UIImage(systemName: "chevron.right"))
        imageView.tintColor = .systemGray2
        imageView.contentMode = .scaleAspectFit
        imageView.setContentHuggingPriority(.required, for: .horizontal)
        imageView.setContentCompressionResistancePriority(.required, for: .horizontal)
        return imageView
    }()
    
    private var note: JsonNote?

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setup()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func use(with note: JsonNote) {
        self.note = note
        name.text = note.filename ?? "(No Name)"
    }

    private func setup() {
        contentView.addSubview(hStack)
        hStack.addArrangedSubview(name)
        hStack.addArrangedSubview(rightArrowView)
        
        NSLayoutConstraint.activate([
            hStack.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 10),
            hStack.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -10),
            hStack.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            hStack.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            
            rightArrowView.widthAnchor.constraint(equalToConstant: 12),
            rightArrowView.heightAnchor.constraint(equalToConstant: 12),
        ])
    }
}
