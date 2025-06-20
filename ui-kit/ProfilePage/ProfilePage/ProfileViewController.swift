//
//  ViewController.swift
//  ProfilePage
//
//  Created by Lukasz Fabia on 19/06/2025.
//

import UIKit

/*
 VStack {
    // user info
    HStack {
 }
 
 // stats
 HStack {
 
 }
 
 }
 
 
 */

class ProfileViewController: UIViewController {
    
    private let userImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFit
        imageView.clipsToBounds = true
        return imageView
    }()
    
    private let nameLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .systemFont(ofSize: 20, weight: .bold)
        return label
    }()
    
    private let followButton: UIButton = {
        var config = UIButton.Configuration.filled()
        config.baseBackgroundColor = .systemIndigo
        config.baseForegroundColor = .white
        config.cornerStyle = .capsule
        config.contentInsets = .init(top: 8, leading: 16, bottom: 8, trailing: 16)

        let btn = UIButton(configuration: config)
        btn.translatesAutoresizingMaskIntoConstraints = false
        btn.setTitle("Follow", for: .normal)
        return btn
    }()

    
    private let bioLabel: UILabel = {
        let label = UILabel()
        
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .systemFont(ofSize: 15, weight: .light)
        label.textColor = .secondaryLabel
        label.textAlignment = .left

        return label
    }()
    
    private let toggleTaggedPostsButton: UIButton = {
        var config = UIButton.Configuration.tinted()
        config.title = "Tagged Posts"
        config.baseBackgroundColor = .systemIndigo
        config.baseForegroundColor = .label
        let btn = UIButton(configuration: config)
        
        btn.translatesAutoresizingMaskIntoConstraints = false
        return btn
    }()

    
    
    // MARK: stacks definitions
    
    private let mainVStack: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.backgroundColor = .systemGray6
        stackView.layer.cornerRadius = 12
        stackView.spacing = 20
        
        stackView.isLayoutMarginsRelativeArrangement = true
        stackView.layoutMargins = .init(top: 16, left: 16, bottom: 16, right: 16)
        return stackView
    }()
    
    private let userInfoHStack: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .horizontal
        stackView.alignment = .center
        stackView.distribution = .fill
        stackView.spacing = 4
        return stackView
    }()
    
    private let statsHStack: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .horizontal
        stackView.distribution = .equalSpacing
        stackView.alignment = .leading
        stackView.spacing = 10
        return stackView
    }()
    
    private let userDetailsVStack: UIStackView =  {
       let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.spacing = 4
        stackView.alignment = .leading
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.isLayoutMarginsRelativeArrangement = true
        stackView.layoutMargins = .init(top: 0, left: 10, bottom: 0, right: 0)
        
        return stackView
    }()
    
    private let taggedPostsSection: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.spacing = 8
        stackView.translatesAutoresizingMaskIntoConstraints = false
        
        let titleLabel = UILabel()
        titleLabel.text = "Tagged Posts"
        titleLabel.font = .systemFont(ofSize: 18, weight: .semibold)
        
        let dummyPostLabel = UILabel()
        dummyPostLabel.text = "moje dziabko kupiłx mi Dubai Chocolate😭😭😭"
        dummyPostLabel.font = .systemFont(ofSize: 14)
        dummyPostLabel.textColor = .secondaryLabel
        dummyPostLabel.numberOfLines = .zero
        
        stackView.addArrangedSubview(titleLabel)
        stackView.addArrangedSubview(dummyPostLabel)
        
        return stackView
    }()

    
    let user: User = User.dummy()
    private var isTaggedPostsVisible = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        view.backgroundColor = .systemBackground
        
        setupUI()
        setupHandlers()
        
        setupProfileHeader()
        setupStats()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        userImageView.layoutIfNeeded()
        userImageView.layer.cornerRadius = userImageView.frame.width / 2
    }

    
    private func assignImage() {
        guard let img = UIImage(named: user.avatar) else {return }
        
        userImageView.image = img
        userImageView.layer.borderColor = UIColor.systemIndigo.cgColor
        userImageView.layer.borderWidth = 2
        
        NSLayoutConstraint.activate([
            userImageView.widthAnchor.constraint(equalToConstant: 80),
            userImageView.heightAnchor.constraint(equalTo: userImageView.widthAnchor)
        ])
    }
    
    private func setupUI() {
        view.addSubview(mainVStack)
        
        mainVStack.addArrangedSubview(userInfoHStack)
        
        mainVStack.addArrangedSubview(statsHStack)
        
        mainVStack.addArrangedSubview(toggleTaggedPostsButton)

        
        NSLayoutConstraint.activate([
            mainVStack.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20),
            mainVStack.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 20),
            mainVStack.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -20),
        ])
    }
    

    private func setupProfileHeader() {
        assignImage()
        nameLabel.text = user.name
        bioLabel.text = user.bio
        
        userInfoHStack.addArrangedSubview(userImageView)
        userInfoHStack.addArrangedSubview(userDetailsVStack)
        userDetailsVStack.addArrangedSubview(nameLabel)
        userDetailsVStack.addArrangedSubview(bioLabel)
        
        
        userInfoHStack.addArrangedSubview(followButton)
    }
    
    private func setupStats() {
        let followersLabel = createFollowLabel(text: "Followers: \(user.followersCount)")
        let followingLabel = createFollowLabel(text: "Following: \(user.followingCount)")
        let postsLabel = createFollowLabel(text: "Posts: \(user.posts.count)")
        
        statsHStack.addArrangedSubview(followersLabel)
        statsHStack.addArrangedSubview(followingLabel)
        statsHStack.addArrangedSubview(postsLabel)
    }

    
    private func createFollowLabel(text: String) -> UILabel {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = text
        label.font = .systemFont(ofSize: 14, weight: .semibold)
        
        return label
    }
    
    
    
    // MARK: handlers for buttons
    
    private func setupHandlers() {
        followButton.addTarget(self, action: #selector(handleFollowButtonTap), for: .touchUpInside)
        
        toggleTaggedPostsButton.addTarget(self, action: #selector(toggleTaggedPosts), for: .touchUpInside)

    }
    
    
    @objc private func handleFollowButtonTap() {
        
    }

    @objc private func toggleTaggedPosts() {
        if isTaggedPostsVisible {
            hideTaggedPostsSection()
        } else {
            showTaggedPostsSection()
        }
        isTaggedPostsVisible.toggle()
    }

    private func showTaggedPostsSection() {
        if !mainVStack.arrangedSubviews.contains(taggedPostsSection) {
            mainVStack.addArrangedSubview(taggedPostsSection)
            taggedPostsSection.isHidden = true
        }

        UIView.animate(withDuration: 0.3) {
            self.taggedPostsSection.isHidden = false
            self.mainVStack.layoutIfNeeded()
        }
    }

    private func hideTaggedPostsSection() {
        UIView.animate(withDuration: 0.3) {
            self.taggedPostsSection.isHidden = true
            self.mainVStack.layoutIfNeeded()
        }
    }
}

