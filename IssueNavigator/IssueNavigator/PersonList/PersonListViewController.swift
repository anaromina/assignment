//
//  PersonListViewController.swift
//  IssueNavigator
//
//  Created by Romina Uncrop on 02/02/2021.
//  Copyright © 2021 TestApp. All rights reserved.
//

import UIKit

/// Draws a list of persons
class PersonListViewController: UITableViewController {
    var dataSource: PersonListDatasource = PersonListDatasource(persons: [])
    
    override func viewDidLoad() {
        super.viewDidLoad()
        dataSource.attach(view: self)
        dataSource.setupView()
    }
    
    /// Background view for table when there are no rows to display
    private lazy var noContentLabel: UILabel = {
        let label = UILabel()
        label.textColor = .lightGray
        label.textAlignment = .center
        return label
    }()

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataSource.numberOfPersons
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: PersonViewCell.cellIdentifier, for: indexPath) as? PersonViewCell else {
            fatalError("Could not dequeue a PersonViewCell!")
        }
        
        dataSource.configureCell(cell, at: indexPath.row)

        return cell
    }
}

// MARK: - PersonListView conformance
extension PersonListViewController: PersonListView {
    /**
    Updates the title of the view controller

    - Parameters:
       - title: New title for the view controller
    */
    func display(title: String) {
        self.title = title
    }
    
    /**
    Draws a list of persons.
    */
    func showList() {
        tableView.backgroundView = nil
        tableView.reloadData()
    }
    
    /**
    Displays a message when the provided list of persons is empty.

    - Parameters:
       - message: The text displayed
    */
    func showNoContent(with message: String) {
        noContentLabel.text = message
        tableView.backgroundView = noContentLabel
        tableView.tableFooterView = UIView()
        tableView.reloadData()
    }
}
