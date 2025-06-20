//
//  TrainerCard.swift
//  GymApp
//
//  Created by Lukasz Fabia on 19/06/2025.
//
import UIKit

class PersonCard: UIView {

    private let container: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
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
        addSubview(container)
        container.addSubview(avatarImage)
        container.addSubview(fullnameLabel)

        NSLayoutConstraint.activate([
            container.topAnchor.constraint(equalTo: topAnchor),
            container.bottomAnchor.constraint(equalTo: bottomAnchor),
            container.leadingAnchor.constraint(equalTo: leadingAnchor),
            container.trailingAnchor.constraint(equalTo: trailingAnchor),

            avatarImage.leadingAnchor.constraint(equalTo: container.leadingAnchor),
            avatarImage.centerYAnchor.constraint(equalTo: container.centerYAnchor),
            avatarImage.widthAnchor.constraint(equalToConstant: 20),
            avatarImage.heightAnchor.constraint(equalToConstant: 20),

            fullnameLabel.leadingAnchor.constraint(equalTo: avatarImage.trailingAnchor, constant: 12),
            fullnameLabel.centerYAnchor.constraint(equalTo: avatarImage.centerYAnchor),
            fullnameLabel.trailingAnchor.constraint(equalTo: container.trailingAnchor)
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
