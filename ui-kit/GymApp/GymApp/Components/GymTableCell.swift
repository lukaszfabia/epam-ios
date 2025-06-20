//
//  CustomTableCell.swift
//  GymApp
//
//  Created by Lukasz Fabia on 19/06/2025.
//

import UIKit

final class GymTableCell: UITableViewCell {
    
    // MARK: - Properties
    weak var delegateForAlerts: GymCellAlertDisplaying?
    private var gymClass: GymClass?
    
    // MARK: Stacks
    
    private let timeVStack: UIStackView = {
       let stack = UIStackView()
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.axis = .vertical
        stack.alignment = .center
        stack.spacing = 6
        return stack
    }()
    
    private let detailsVStack: UIStackView = {
       let stack = UIStackView()
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.axis = .vertical
        stack.alignment = .leading
        stack.spacing = 6
        return stack
    }()
    
    private let mainHStack: UIStackView = {
       let stack = UIStackView()
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.axis = .horizontal
        stack.alignment = .leading
        stack.spacing = 14
        return stack
    }()
    
    private let classNameHStack: UIStackView = {
       let stack = UIStackView()
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.axis = .horizontal
        stack.alignment = .leading
        stack.spacing = 4
        return stack
    }()
    
    // MARK: - UI Components
    private let containerView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.clipsToBounds = true
        return view
    }()
    
    private let timeLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .systemPink
        label.textAlignment = .center
        label.font = .systemFont(ofSize: 25, weight: .semibold)
        return label
    }()
    
    private let durationLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .systemPurple
        label.textAlignment = .center
        label.font = .systemFont(ofSize: 15, weight: .light)
        return label
    }()
    
    private let favButton: UIButton = {
        let button = UIButton()
        let config = UIImage.SymbolConfiguration(pointSize: 20, weight: .regular)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.tintColor = .systemRed
        button.setImage(UIImage(systemName: "heart", withConfiguration: config), for: .normal)
        button.setImage(UIImage(systemName: "heart.fill", withConfiguration: config), for: .selected)
        return button
    }()
    
    private let classLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .systemFont(ofSize: 25, weight: .light)
        return label
    }()
    
    private let trainerCard: PersonCard = {
        let card = PersonCard()
        card.translatesAutoresizingMaskIntoConstraints = false
        return card
    }()
    
    private let actionButton: UIButton = {
        let button = UIButton(type: .system)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.layer.borderWidth = 1.0
        button.clipsToBounds = true
        button.layer.borderColor = UIColor.label.cgColor
        button.tintColor = .label
        button.backgroundColor = .clear
        button.setImage(UIImage(systemName: "plus"), for: .normal)
        return button
    }()
    
    // MARK: - Lifecycle
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupView()
        setupActions()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        actionButton.layer.cornerRadius = actionButton.bounds.width / 2
    }
    
    func use(with gymClass: GymClass) {
        self.gymClass = gymClass
        trainerCard.use(with: gymClass.trainer)
        updateLabels(with: gymClass)
        updateButtons(with: gymClass)
    }
    
    // MARK: - Private Methods
    private func setupView() {
        selectionStyle = .blue
        contentView.addSubview(containerView)
        
        containerView.addSubview(actionButton)
        containerView.addSubview(mainHStack)
        mainHStack.addArrangedSubview(timeVStack)
        mainHStack.addArrangedSubview(detailsVStack)
        
        timeVStack.addArrangedSubview(timeLabel)
        timeVStack.addArrangedSubview(durationLabel)
        
        detailsVStack.addArrangedSubview(classNameHStack)
        detailsVStack.addArrangedSubview(trainerCard)
    
        classNameHStack.addArrangedSubview(favButton)
        classNameHStack.addArrangedSubview(classLabel)
        
        
        NSLayoutConstraint.activate([
            containerView.topAnchor.constraint(equalTo: contentView.topAnchor),
            containerView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 10),
            containerView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -10),
            containerView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
        
            mainHStack.leadingAnchor.constraint(equalTo: containerView.leadingAnchor),
            mainHStack.centerYAnchor.constraint(equalTo: containerView.centerYAnchor),
            
            favButton.centerYAnchor.constraint(equalTo: classNameHStack.centerYAnchor),
            
            actionButton.trailingAnchor.constraint(equalTo: containerView.trailingAnchor),
            actionButton.centerYAnchor.constraint(equalTo: containerView.centerYAnchor),
            actionButton.widthAnchor.constraint(equalToConstant: 44),
            actionButton.heightAnchor.constraint(equalToConstant: 44)
        ])
    }
    
    private func setupActions() {
        actionButton.addTarget(self, action: #selector(toggleRegistration), for: .touchUpInside)
        favButton.addTarget(self, action: #selector(toggleFavorite), for: .touchUpInside)
    }
    
    private func updateLabels(with gymClass: GymClass) {
        timeLabel.text = gymClass.time
        durationLabel.text = "\(gymClass.duration)m"
        classLabel.text = gymClass.className.rawValue
    }
    
    private func updateButtons(with gymClass: GymClass) {
        let isRegistered = gymClass.isRegistered
        actionButton.setImage(UIImage(systemName: isRegistered ? "xmark" : "plus"), for: .normal)
        actionButton.tintColor = isRegistered ? .white : .label
        actionButton.backgroundColor = isRegistered ? .systemPink : .clear
        actionButton.layer.borderWidth = isRegistered ? 0 : 1
        actionButton.layer.borderColor = isRegistered ? UIColor.clear.cgColor : UIColor.label.cgColor
        
        favButton.isSelected = gymClass.isFav
    }
    
    // MARK: - Actions
    @objc private func toggleRegistration() {
        guard let gymClass else { return }
        
        gymClass.toggleIsRegister()
        updateButtons(with: gymClass)
        
        let message = gymClass.isRegistered ?
        "You have registered to \(gymClass.className.rawValue), see you there!" :
        "You have just cancelled \(gymClass.className.rawValue) :("
        
        delegateForAlerts?.gymCell(self, title: "Information", message: message)
    }
    
    @objc private func toggleFavorite() {
        guard let gymClass else { return }
        gymClass.toggleIsFav()
        favButton.isSelected = gymClass.isFav
    }
}
