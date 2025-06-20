//
//  CustomTableCell.swift
//  GymApp
//
//  Created by Lukasz Fabia on 19/06/2025.
//

import UIKit

protocol GymTableCellDelegate: AnyObject {
    func gymTableCell(_ cell: GymTableCell, showAlertWithTitle title: String, message: String)
}

class GymTableCell: UITableViewCell {
    
    weak var delegateForAlerts: GymTableCellDelegate?
    
    private let container: UIView =  {
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

        button.backgroundColor = .clear

        return button
    }()

    
    private let classLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .systemFont(ofSize: 25, weight: .light)
        return label
    }()
    
    private let trainerCard: PersonCard = {
        let personCard = PersonCard()
        personCard.translatesAutoresizingMaskIntoConstraints = false
        return personCard
    }()
    
    private let addOrCancelButton: UIButton = {
        let btn = UIButton(type: .system)
        btn.translatesAutoresizingMaskIntoConstraints = false
        btn.layer.borderWidth = 1.0
        btn.clipsToBounds = true
        btn.layer.borderColor = UIColor.label.cgColor
        btn.tintColor = .label
        btn.backgroundColor = .clear
        btn.setImage(UIImage(systemName: "plus"), for: .normal)
        return btn
    }()
    
    private var gymClass: GymClass?
    
    override func layoutSubviews() {
        super.layoutSubviews()
        addOrCancelButton.layer.cornerRadius = addOrCancelButton.bounds.width / 2
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.selectionStyle = .none
        setupUI()
        setupHandlers()
    }
    
    func use(with cls: GymClass) {
        gymClass = cls
        
        trainerCard.use(with: cls.trainer)
        
        initLabelStates(cls)
        initButtonStates(cls)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupHandlers() {
        addOrCancelButton.addTarget(self, action: #selector(toggleAdd), for: .touchUpInside)
        favButton.addTarget(self, action: #selector(toggleFav), for: .touchUpInside)
    }
    
    private func initLabelStates(_ cls: GymClass) {
        timeLabel.text = cls.time
        durationLabel.text = "\(cls.duration)m"
        classLabel.text = cls.className.rawValue
    }
    
    private func initButtonStates(_ cls: GymClass) {
        let plusOrX = cls.isRegistered ? "xmark" : "plus"
        addOrCancelButton.setImage(UIImage(systemName: plusOrX), for: .normal)
        addOrCancelButton.tintColor = cls.isRegistered ? .white : .label
        addOrCancelButton.backgroundColor = cls.isRegistered ? .systemPink : .clear
        addOrCancelButton.layer.borderWidth = cls.isRegistered ? 0 : 1
        addOrCancelButton.layer.borderColor = cls.isRegistered ? UIColor.clear.cgColor : UIColor.label.cgColor
        
        favButton.isSelected = cls.isFav
    }
    
    private func setupUI() {
        contentView.addSubview(container)
        container.addSubview(trainerCard)
        container.addSubview(timeLabel)
        container.addSubview(classLabel)
        container.addSubview(durationLabel)
        container.addSubview(addOrCancelButton)
        container.addSubview(favButton)
        
        NSLayoutConstraint.activate([
            container.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 5),
            container.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 10),
            container.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -10),
            container.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -5),
            
            timeLabel.topAnchor.constraint(equalTo: container.topAnchor, constant: 10),
            timeLabel.leadingAnchor.constraint(equalTo: container.leadingAnchor, constant: 10),
            
            durationLabel.topAnchor.constraint(equalTo: timeLabel.bottomAnchor, constant: 5),
            durationLabel.centerXAnchor.constraint(equalTo: timeLabel.centerXAnchor),
            durationLabel.trailingAnchor.constraint(equalTo: timeLabel.trailingAnchor),
            
            favButton.leadingAnchor.constraint(equalTo: timeLabel.trailingAnchor, constant: 12),
            favButton.topAnchor.constraint(equalTo: container.topAnchor, constant: 10),
            favButton.widthAnchor.constraint(equalToConstant: 30),
            favButton.heightAnchor.constraint(equalToConstant: 30),
            
            classLabel.leadingAnchor.constraint(equalTo: favButton.trailingAnchor, constant: 8),
            classLabel.centerYAnchor.constraint(equalTo: favButton.centerYAnchor),
            classLabel.heightAnchor.constraint(equalTo: favButton.heightAnchor),
            
            trainerCard.topAnchor.constraint(equalTo: favButton.bottomAnchor, constant: 15),
            trainerCard.leadingAnchor.constraint(equalTo: favButton.leadingAnchor, constant: 5),
            trainerCard.trailingAnchor.constraint(equalTo: classLabel.trailingAnchor),

            
            addOrCancelButton.centerYAnchor.constraint(equalTo: container.centerYAnchor),
            addOrCancelButton.trailingAnchor.constraint(equalTo: container.trailingAnchor, constant: -10),
            addOrCancelButton.widthAnchor.constraint(equalToConstant: 50),
            addOrCancelButton.heightAnchor.constraint(equalToConstant: 50),
        ])
    }
    
    // MARK: button handlers
    
    @objc private func toggleAdd() {
        guard let gymClass else { return }

        let message = !gymClass.isRegistered ?
            "You have registered to \(gymClass.className.rawValue), see you there!" :
            "You have just cancelled \(gymClass.className.rawValue) :("

        let title = "Information"

        delegateForAlerts?.gymTableCell(self, showAlertWithTitle: title, message: message)

        gymClass.setIsRegistered()
        let isOn = gymClass.isRegistered
        addOrCancelButton.setImage(UIImage(systemName: isOn ? "xmark" : "plus"), for: .normal)
        addOrCancelButton.tintColor = isOn ? .white : .label
        addOrCancelButton.backgroundColor = isOn ? .systemPink : .clear
        addOrCancelButton.layer.borderWidth = isOn ? .zero : 1
        addOrCancelButton.layer.borderColor = isOn ? UIColor.clear.cgColor : UIColor.label.cgColor
    }

    
    @objc private func toggleFav() {
        guard let gymClass else { return }
        
        gymClass.setIsFav()
        favButton.isSelected = gymClass.isFav
    }
}
