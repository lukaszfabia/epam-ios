//
//  FindClubsViewController.swift
//  GymApp
//
//  Created by Lukasz Fabia on 19/06/2025.
//

import UIKit

class FindClubsViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, UISearchBarDelegate {
    
    private let header: UILabel = {
        let label = UILabel()
        return label
    }()
    
    private let table: UITableView = {
        let tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.register(GymTableCell.self, forCellReuseIdentifier: "GymTableCell")
        return tableView
    }()
    
    private let searchBar: UISearchBar = {
        let sb = UISearchBar()
        sb.translatesAutoresizingMaskIntoConstraints = false
        sb.placeholder = "Search for classes or instructors..."
        sb.showsCancelButton = true
        sb.keyboardType = .alphabet
        return sb
    }()
    
    private var gymClasses = GymClasses()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        title = "Wellness classes"
        
        table.delegate = self
        table.dataSource = self
        searchBar.delegate = self
        
        setupUI()
        
   
        gymClasses.groupAndSort(my: GymClass.dummies())
    }
    
    func setupUI() {
        view.addSubview(table)
        view.addSubview(searchBar)
        
        NSLayoutConstraint.activate([
            searchBar.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 8),
            searchBar.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            searchBar.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            
            table.topAnchor.constraint(equalTo: searchBar.bottomAnchor),
            table.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            table.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            table.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])
    }
    
    // MARK: - UITableView DataSource

    func numberOfSections(in tableView: UITableView) -> Int {
        return gymClasses.numberofHeaders()
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let header = gymClasses.header(at: section) else { return 0 }
        return gymClasses.numberfoRows(in: header)
    }

    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        guard let headerData = gymClasses.header(at: section) else { return nil }

        let dayNameLabel = getHeaderLabel(text: headerData.dayname, color: .label, weight: .bold)
        let prettyDateLabel = getHeaderLabel(text: headerData.id, color: .systemIndigo, weight: .light)
        
        let container = UIView()
        container.backgroundColor = .systemBackground

        container.addSubview(dayNameLabel)
        container.addSubview(prettyDateLabel)

        NSLayoutConstraint.activate([
            dayNameLabel.topAnchor.constraint(equalTo: container.topAnchor, constant: 10),
            dayNameLabel.leadingAnchor.constraint(equalTo: container.leadingAnchor, constant: 10),
            dayNameLabel.bottomAnchor.constraint(equalTo: container.bottomAnchor, constant: -10),

            prettyDateLabel.leadingAnchor.constraint(equalTo: dayNameLabel.trailingAnchor, constant: 10),
            prettyDateLabel.centerYAnchor.constraint(equalTo: dayNameLabel.centerYAnchor),
        ])


        return container
    }


    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        guard let cell = tableView.dequeueReusableCell(withIdentifier: "GymTableCell", for: indexPath) as? GymTableCell else {
            return UITableViewCell()
        }

        if let gymClass = gymClasses.gymClass(at: indexPath) {
            cell.use(with: gymClass)
        }
        
        // we re giving responsibility of displaying alerts someone who can do it
        cell.delegateForAlerts = self

        return cell
    }

    // MARK: - UITableView Delegate

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 120
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 50
    }
    
    func tableView(
        _ tableView: UITableView,
        commit editingStyle: UITableViewCell.EditingStyle,
        forRowAt indexPath: IndexPath
    ) {
        guard editingStyle == .delete else { return }

        guard let header = gymClasses.header(at: indexPath.section) else { return }

        gymClasses.removeClass(at: indexPath)

    
        if gymClasses.numberfoRows(in: header) == 0 {
            // delete section when i have no rows
            tableView.performBatchUpdates {
                tableView.deleteSections(IndexSet(integer: indexPath.section), with: .fade)
            }
        } else {
            tableView.performBatchUpdates {
                tableView.deleteRows(at: [indexPath], with: .fade)
            }
        }
    }

    
    private func getHeaderLabel(text: String, color: UIColor, weight: UIFont.Weight) -> UILabel {
        let label = UILabel()
        label.textColor = color
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = text
        label.font = .systemFont(ofSize: 25, weight: weight)
        
        return label
    }
}

extension FindClubsViewController: GymTableCellDelegate {
    func gymTableCell(_ cell: GymTableCell, showAlertWithTitle title: String, message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Ok", style: .default))
        present(alert, animated: true)
    }
}
