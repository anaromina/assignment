//
//  PersonListViewController.swift
//  IssueNavigator
//
//  Created by Romina Uncrop on 02/02/2021.
//  Copyright © 2021 TestApp. All rights reserved.
//

import UIKit

class PersonListViewController: UITableViewController {
    var dataSource: PersonListDatasource = PersonListDatasource(persons: [])
    
    override func viewDidLoad() {
        super.viewDidLoad()
        dataSource.attach(view: self)
        dataSource.setupView()
    }
    
    private lazy var messageLabel: UILabel = {
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
        let cell = tableView.dequeueReusableCell(withIdentifier: PersonViewCell.cellIdentifier, for: indexPath) as! PersonViewCell
        
        dataSource.configureCell(cell, at: indexPath.row)

        return cell
    }
}

extension PersonListViewController: PersonListView {
    func display(title: String) {
        self.title = title
    }
    
    func showList() {
        tableView.backgroundView = nil
        tableView.reloadData()
    }
    
    func showNoContent(with message: String) {
        messageLabel.text = message
        tableView.backgroundView = messageLabel
        tableView.tableFooterView = UIView()
        tableView.reloadData()
    }
    
    
}
