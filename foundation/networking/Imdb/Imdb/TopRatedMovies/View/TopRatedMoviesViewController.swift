//
//  TopRatedMoviesViewController.swift
//  Imdb
//
//  Created by Lukasz Fabia on 03/07/2025.
//

import UIKit

class TopRatedMoviesViewController: UITableViewController {
    
    private struct Cell {
        static let movie = "TopMovieCell"
    }
    
    private let footerSpinner: UIActivityIndicatorView = {
        let spinner = UIActivityIndicatorView(style: .medium)
        spinner.color = .label
        spinner.frame = CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: 44)
        spinner.hidesWhenStopped = true
        return spinner
    }()

    

    private let viewModel: TopRatedMoviesViewModel

    init(viewModel: TopRatedMoviesViewModel) {
        self.viewModel = viewModel
        super.init(style: .plain)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }


    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        title = "Top Rated Movies"
        
        setupDelegates()
        registerComponents()
        setupBindings()
        
        viewModel.fetchTopMovies()
    }

    private func setupDelegates() {
        tableView.delegate = self
        tableView.dataSource = self
    }

    private func registerComponents() {
        tableView.register(TopMovieCell.self, forCellReuseIdentifier: Cell.movie)
    }


    private func setupErrorMessage() {
        DispatchQueue.main.async {
            let errLabel = UILabel()
            errLabel.text = "Something went wrong!"
            errLabel.font = .boldSystemFont(ofSize: 20)
            errLabel.textAlignment = .center
            errLabel.textColor = .systemRed
            
            self.tableView.tableHeaderView = errLabel
        }
    }


    private func setupBindings() {
        viewModel.onLoading = { [weak self] isLoading in
            DispatchQueue.main.async {
                self?.setTableFooterLoading(isLoading)
            }
        }
        
        viewModel.onLoadingMore = { [weak self] isLoadingMore in
            DispatchQueue.main.async {
                self?.setTableFooterLoading(isLoadingMore)
            }
        }


        viewModel.onError = { [weak self] error in
            if error != nil {
                print("Error: \(error!)")
                self?.setupErrorMessage()
            }
        }

        viewModel.moviesUpdate = { [weak self] in
            DispatchQueue.main.async {
                self?.tableView.reloadData()
            }
        }
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.numberOfRows
    }

    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 240
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard
            let cell = tableView.dequeueReusableCell(withIdentifier: Cell.movie, for: indexPath) as? TopMovieCell,
            let movie = viewModel[indexPath.row]
        else {
            return UITableViewCell()
        }

        cell.use(with: movie, and: viewModel.getGenres(for: movie))
        return cell
    }
    
    override func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let offsetY = scrollView.contentOffset.y
        let contentHeight = scrollView.contentSize.height
        let frameHeight = scrollView.frame.size.height
        
        if offsetY > contentHeight - frameHeight * 1.5 {
            if !viewModel.isLoadingMore {
                viewModel.fetchMore()
            }
        }
    }

    private func setTableFooterLoading(_ loading: Bool) {
        if loading {
            footerSpinner.startAnimating()
            tableView.tableFooterView = footerSpinner
        } else {
            footerSpinner.stopAnimating()
            tableView.tableFooterView = nil
        }
    }

    
}
