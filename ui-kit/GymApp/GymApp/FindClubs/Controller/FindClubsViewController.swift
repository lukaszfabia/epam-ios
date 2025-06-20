//
//  FindClubsViewController.swift
//  GymApp
//
//  Created by Lukasz Fabia on 19/06/2025.
//

import UIKit

final class FindClubsViewController: UIViewController {
    
    private enum TableProps {
        static let cellReuseIdentifier = "GymTableCell"
        static let rowHeight: CGFloat = 120
        static let headerHeight: CGFloat = 5
    }
    
    private var searchBar: UISearchBar = {
        let searchBar = UISearchBar()
        searchBar.translatesAutoresizingMaskIntoConstraints = false
        searchBar.placeholder = "Search for classes or instructors..."
        searchBar.showsCancelButton = true
        searchBar.isEnabled = false
        searchBar.keyboardType = .alphabet
        return searchBar
    }()
    
    private var tableView: UITableView = {
        let tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.register(GymTableCell.self, forCellReuseIdentifier: TableProps.cellReuseIdentifier)
        tableView.rowHeight = TableProps.rowHeight
        tableView.sectionHeaderHeight = TableProps.headerHeight
        return tableView
    }()
    
    private var viewModel: FindClubViewModel
    
    init(viewModel: FindClubViewModel = FindClubViewModel()) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        setupConstraints()
        setupDelegates()
        
        viewModel.fillData(with: GymClass.dummies())
    }
    
    private func setupUI() {
        title = "Wellness classes"
        view.backgroundColor = .systemBackground
        view.addSubview(searchBar)
        view.addSubview(tableView)
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            searchBar.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor,
                                           constant: 8),
            searchBar.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            searchBar.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            
            tableView.topAnchor.constraint(equalTo: searchBar.bottomAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])
    }
    
    private func setupDelegates() {
        tableView.delegate = self
        tableView.dataSource = self
        searchBar.delegate = self
    }
    
    private func createHeaderLabel(text: String, color: UIColor, weight: UIFont.Weight) -> UILabel {
        let label = UILabel()
        label.textColor = color
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = text
        label.font = .systemFont(ofSize: 25, weight: weight)
        return label
    }
}


// MARK: UITableViewDataSource
extension FindClubsViewController: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        viewModel.numberOfSections
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        viewModel.numberOfRows(in: section)
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(
            withIdentifier: TableProps.cellReuseIdentifier,
            for: indexPath
        ) as? GymTableCell else {
            return UITableViewCell()
        }
        
        if let gymClass = viewModel.gymClass(at: indexPath) {
            cell.use(with: gymClass)
            cell.delegateForAlerts = self
        }
        
        return cell
    }
}

// MARK: UITableViewDelegate
extension FindClubsViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        guard let headerData = viewModel.section(at: section) else { return nil }
        
        let container = UIView()
        container.backgroundColor = .systemBackground
        
        let dayNameLabel = createHeaderLabel(
            text: headerData.dayName,
            color: .label,
            weight: .bold
        )
        
        let dateLabel = createHeaderLabel(
            text: headerData.id,
            color: .systemIndigo,
            weight: .light
        )
        
        container.addSubview(dayNameLabel)
        container.addSubview(dateLabel)
        
        NSLayoutConstraint.activate([
            dayNameLabel.topAnchor.constraint(equalTo: container.topAnchor, constant: 10),
            dayNameLabel.leadingAnchor.constraint(equalTo: container.leadingAnchor, constant: 10),
            dayNameLabel.bottomAnchor.constraint(equalTo: container.bottomAnchor, constant: -10),
            
            dateLabel.leadingAnchor.constraint(equalTo: dayNameLabel.trailingAnchor, constant: 10),
            dateLabel.centerYAnchor.constraint(equalTo: dayNameLabel.centerYAnchor),
        ])
        
        return container
    }
    
    func tableView(_ tableView: UITableView,
                   commit editingStyle: UITableViewCell.EditingStyle,
                   forRowAt indexPath: IndexPath) {
        guard editingStyle == .delete else { return }
        
        let (_, hasDeletedSection) = viewModel.removeClass(at: indexPath)
        
        tableView.performBatchUpdates {
            if hasDeletedSection {
                tableView.deleteSections(IndexSet(integer: indexPath.section), with: .fade)
            } else {
                tableView.deleteRows(at: [indexPath], with: .fade)
            }
        }
    }
}

// MARK: GymCellAlertDelegate
extension FindClubsViewController: GymCellAlertDisplaying {
    func gymCell(_ cell: GymTableCell, title: String, message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default))
        present(alert, animated: true)
    }
}

// MARK: UISearchBarDelegate
extension FindClubsViewController: UISearchBarDelegate {}
