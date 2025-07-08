//
//  TopMovieTableViewCell.swift
//  Imdb
//
//  Created by Lukasz Fabia on 04/07/2025.
//

import UIKit

class TopMovieCell: UITableViewCell {
    
    private let poster: UIImageView = {
        let iv = UIImageView()
        iv.contentMode = .scaleAspectFit
        iv.clipsToBounds = true
        iv.translatesAutoresizingMaskIntoConstraints = false
        iv.tintColor = .systemGray
        iv.image = UIImage(systemName: "questionmark")
        iv.layer.cornerRadius = 12
        return iv
    }()
    
    private let title: UILabel = {
        let l = UILabel()
        l.textColor = .label
        l.font = .boldSystemFont(ofSize: 17)
        l.adjustsFontSizeToFitWidth = true
        l.numberOfLines = 1
        return l
    }()
    
    private let overview: UILabel = {
        let l = UILabel()
        l.textColor = .secondaryLabel
        l.font = .systemFont(ofSize: 15, weight: .light)
        l.numberOfLines = 2
        return l
    }()
    
    private let rating: UILabel = {
        let l = UILabel()
        l.textColor = .systemYellow
        l.font = .boldSystemFont(ofSize: 22)
        l.textAlignment = .center
        return l
    }()
    
    private let votes: UILabel = {
        let l = UILabel()
        l.textColor = .secondaryLabel
        l.font = .systemFont(ofSize: 12)
        return l
    }()
    
    private let date: UILabel  = {
        let l = UILabel()
        l.textColor = .secondaryLabel
        l.font = .systemFont(ofSize: 13, weight: .light)
        return l
    }()
    
    private let contentStack: UIStackView = {
       let stack = UIStackView()
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.axis = .vertical
        stack.spacing = 5
        
        return stack
    }()
    
    private let ratingStack: UIStackView = {
        let stack = UIStackView()
        stack.axis = .vertical
        stack.spacing = 3
        stack.alignment = .trailing
        stack.isLayoutMarginsRelativeArrangement = true
        stack.layoutMargins = .init(top: 5, left: 5, bottom: 5, right: 5)
        return stack
    }()

    
    private var badgeCollection = BadgeCollection()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupUI() {
        selectionStyle = .none
        
        contentView.addSubview(poster)
        NSLayoutConstraint.activate([
            poster.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 12),
            poster.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 12),
            poster.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -12),
            poster.widthAnchor.constraint(equalToConstant: 100),
        ])
        

        
        ratingStack.addArrangedSubview(rating)
        ratingStack.addArrangedSubview(votes)

        contentStack.addArrangedSubview(date)
        contentStack.addArrangedSubview(title)
        contentStack.addArrangedSubview(badgeCollection)
        contentStack.addArrangedSubview(overview)
        contentStack.addArrangedSubview(ratingStack)
        
        contentView.addSubview(contentStack)
        
        NSLayoutConstraint.activate([
            contentStack.leadingAnchor.constraint(equalTo: poster.trailingAnchor, constant: 12),
            contentStack.topAnchor.constraint(equalTo: poster.topAnchor, constant: 0),
            contentStack.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -10),
            contentStack.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -12),
        ])
    }
    
    func use(with movie: Movie, and genres: [String]) {
        TMDBApiService.service.loadImage(endpoint: movie.imageURL, imageView: poster)
        
        title.text = movie.title
        overview.text = movie.overview
        rating.text = movie.rating
        votes.text = "\(movie.vote_count) votes"
        date.text = movie.year
        
        var items = genres
        if movie.adult {
            items.append("+18")
        }
    
        badgeCollection.items = items
    
        badgeCollection.reloadData()
    }
}
