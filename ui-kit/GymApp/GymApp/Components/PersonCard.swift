//
//  TrainerCard.swift
//  GymApp
//
//  Created by Lukasz Fabia on 19/06/2025.
//
import UIKit

class PersonCard: UIView {

    private let hstack: UIStackView = {
        let stack = UIStackView()
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.spacing = 6
        stack.axis = .horizontal
        return stack
    }()

    private let fullnameLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 17, weight: .light)
        label.textColor = .systemIndigo
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    private let avatarImage: UIImageView = {
        let iv = UIImageView()
        iv.contentMode = .scaleAspectFill
        iv.clipsToBounds = true
        iv.translatesAutoresizingMaskIntoConstraints = false
        return iv
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupUI()
    }

    private func setupUI() {
        addSubview(hstack)
        hstack.addArrangedSubview(avatarImage)
        hstack.addArrangedSubview(fullnameLabel)

        NSLayoutConstraint.activate([
            avatarImage.widthAnchor.constraint(equalToConstant: 20),
            avatarImage.heightAnchor.constraint(equalTo: avatarImage.widthAnchor)
        ])
    }

    override func layoutSubviews() {
        super.layoutSubviews()
        avatarImage.layoutIfNeeded()
        avatarImage.layer.cornerRadius = avatarImage.frame.width / 2
    }

    func use(with info: any Information) {
        fullnameLabel.text = info.fullname
        avatarImage.image = UIImage(named: info.avatar)
    }
}
