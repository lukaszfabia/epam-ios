//
//  SearchPeopleViewController.swift
//  StorageExample
//
//  Created by Lukasz Fabia on 16/07/2025.
//

import UIKit

class SearchPeopleViewController: UITableViewController {
    
    private let searchPeopleViewModel: SearchPeopleViewModel
    
    
    private let searchController: UISearchController = {
        let searchController = UISearchController(searchResultsController: nil)
        searchController.searchBar.placeholder = "Search people"
        searchController.searchBar.searchTextField.backgroundColor = .systemBackground
        return searchController
    }()
    
    init(searchPeopleViewModel: SearchPeopleViewModel) {
        self.searchPeopleViewModel = searchPeopleViewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        
        navigationItem.searchController = searchController
        navigationItem.hidesSearchBarWhenScrolling = true
        
        searchController.searchBar.delegate = self
        searchController.delegate = self
        
        tableView.register(PeopleCell.self, forCellReuseIdentifier: "Cell")
        
        tableView.reloadData()
        
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // when my searchbar is triggered
        return searchController.isActive ? searchPeopleViewModel.phrases.count : 0
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as? PeopleCell else {return UITableViewCell()}
        
        cell.use(with: searchPeopleViewModel[indexPath.row])
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        guard editingStyle == .delete, indexPath.row < searchPeopleViewModel.phrases.count else {return}
        
        tableView.performBatchUpdates {
            searchPeopleViewModel.removeSearchedPhrase(at: indexPath)
            
            tableView.deleteRows(at: [indexPath], with: .fade)
        }
        
    }
}

extension SearchPeopleViewController: UISearchBarDelegate {
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        searchBar.text = ""
        searchBar.resignFirstResponder()
//        searchPeopleViewModel.searchQuery = ""
        tableView.reloadData()
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchBar.resignFirstResponder()
        if let text = searchBar.text?.trimmingCharacters(in: .whitespacesAndNewlines), !text.isEmpty {
            searchPeopleViewModel.saveRecentSearchedPhrase(text)
            tableView.reloadData()
            searchBar.text = ""
        }
    }
}

extension SearchPeopleViewController: UISearchControllerDelegate {
    func didPresentSearchController(_ searchController: UISearchController) {
        tableView.reloadData()
    }
    
    func didDismissSearchController(_ searchController: UISearchController) {
        tableView.reloadData()
    }
}


class PeopleCell: UITableViewCell {
    
    private let label: UILabel = {
        let l = UILabel()
        
        l.font = .systemFont(ofSize: 17, weight: .medium)
        l.textColor = .label
        l.numberOfLines = 1
        
        l.translatesAutoresizingMaskIntoConstraints = false
        
        return l
    }()
    
    private let icon: UIImageView = {
        let img = UIImage(systemName: "clock")?.withRenderingMode(.alwaysTemplate)
        
        let iv = UIImageView(image: img)
        
        iv.tintColor = .label
        iv.contentMode = .scaleAspectFit
        iv.translatesAutoresizingMaskIntoConstraints = false
        
        return iv
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    func use(with query: String) {
        label.text = query
    }
    
    private func setupUI() {
        contentView.addSubview(label)
        contentView.addSubview(icon)
        
        NSLayoutConstraint.activate([
            label.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            label.leadingAnchor.constraint(equalTo: contentView.safeAreaLayoutGuide.leadingAnchor, constant: 20),
            
            icon.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            icon.trailingAnchor.constraint(equalTo: contentView.safeAreaLayoutGuide.trailingAnchor, constant: -20),
            icon.widthAnchor.constraint(equalToConstant: 20),
            icon.heightAnchor.constraint(equalToConstant: 20),
        ])
    }
}
