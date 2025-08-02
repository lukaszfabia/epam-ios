//
//  PostsTableViewController.swift
//  Task9
//
//  Created by Lukasz Fabia on 02/08/2025.
//

import Combine
import UIKit

class PostsTableViewController: UITableViewController {
    
    private let spinner: UIActivityIndicatorView = {
        let indicator = UIActivityIndicatorView(style: .large)
        indicator.translatesAutoresizingMaskIntoConstraints = false
        return indicator
    }()
    
    private struct Cells {
        static let postCell = "PostCell"
    }
    
    private var postsViewModel: PostsViewModel
    
    private var subs = Set<AnyCancellable>()
    
    init(postsViewModel: PostsViewModel = .init()) {
        self.postsViewModel = postsViewModel
        
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupSpinner() {
        view.addSubview(spinner)
        
        NSLayoutConstraint.activate([
            spinner.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            spinner.centerYAnchor.constraint(equalTo: view.centerYAnchor)
        ])
    }
    
    private func updateLoadingSpinner() {
        postsViewModel.$isLoading
            .receive(on: DispatchQueue.main)
            .sink { [weak self] isLoading in
                print("Loading: \(isLoading)")
                if isLoading {
                    self?.tableView.backgroundView = self?.spinner
                    self?.spinner.startAnimating()
                }
                else {
                    self?.spinner.stopAnimating()
                    self?.tableView.backgroundView = nil
                }
            }
            .store(in: &subs)
    }
    
    private func updatePosts() {
        postsViewModel.$posts
            .receive(on: DispatchQueue.main)
            .sink { [weak self] _ in
                self?.tableView.reloadData()
            }
            .store(in: &subs)
    }
    
    private func updateError() {
        postsViewModel.$error
            .receive(on: DispatchQueue.main)
            .sink { [weak self] error in
                if let error {
                    self?.showErrorAlert(title: "Error", message: error)
                }
            }.store(in: &subs)
    }
    
    private func showErrorAlert(title: String, message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default))
        present(alert, animated: true)
    }

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "Posts"
        
        setupSpinner()
        
        updateLoadingSpinner()
        
        updatePosts()
        
        updateError()
        
        postsViewModel.fetchPosts()
        
        self.tableView.register(PostCell.self, forCellReuseIdentifier: Cells.postCell)
    }
    
    // MARK: - Table view data source
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return postsViewModel.posts.count
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: Cells.postCell, for: indexPath) as? PostCell else {return UITableViewCell()}
        
        // Configure the cell...
        cell.use(with: postsViewModel.posts[indexPath.row])
        
        return cell
    }
    
}
