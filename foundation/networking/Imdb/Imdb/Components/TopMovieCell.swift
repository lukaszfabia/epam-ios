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
        l.font = .boldSystemFont(ofSize: 25)
        l.adjustsFontSizeToFitWidth = true
        l.numberOfLines = 1
        return l
    }()
    
    private let overview: UILabel = {
        let l = UILabel()
        l.textColor = .secondaryLabel
        l.font = .systemFont(ofSize: 14)
        l.numberOfLines = 3
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
        l.textAlignment = .center
        return l
    }()
    
    private let date = Badge(with: .systemGray5)
    private let adult = Badge(with: .systemRed)
    private var badgeStack: UIStackView!
    


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
        

        let infoStack = UIStackView(arrangedSubviews: [title, overview])
        infoStack.axis = .vertical
        infoStack.spacing = 6
        infoStack.translatesAutoresizingMaskIntoConstraints = false
        
        badgeStack = UIStackView(arrangedSubviews: [date, adult])
        badgeStack.axis = .horizontal
        badgeStack.spacing = 8
        badgeStack.distribution = .fill
        badgeStack.alignment = .leading
        
        let ratingStack = UIStackView(arrangedSubviews: [rating, votes])
        
        ratingStack.axis = .vertical
        ratingStack.spacing = 3
        ratingStack.distribution = .fillProportionally
        ratingStack.alignment = .trailing
        ratingStack.isLayoutMarginsRelativeArrangement = true
        ratingStack.layoutMargins = .init(top: 5, left: 5, bottom: 5, right: 5)
        
        let contentStack = UIStackView(arrangedSubviews: [badgeStack, infoStack, ratingStack])
        contentStack.axis = .vertical
        contentStack.spacing = 5
        contentStack.translatesAutoresizingMaskIntoConstraints = false

        contentView.addSubview(contentStack)
        
        NSLayoutConstraint.activate([
            contentStack.leadingAnchor.constraint(equalTo: poster.trailingAnchor, constant: 12),
            contentStack.topAnchor.constraint(equalTo: poster.topAnchor, constant: 10),
            contentStack.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -10),
            contentStack.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -12),
        ])

    }

    func use(with movie: Movie) {
        TMDBApiService.service.loadImage(endpoint: movie.imageURL, imageView: poster)
        
        title.text = movie.title
        overview.text = movie.overview
        rating.text = movie.rating
        votes.text = "\(movie.vote_count) votes"
        
        date.text = movie.year
        adult.text = movie.adult ? "+18" : ""
        adult.isHidden = !movie.adult
    }
}
