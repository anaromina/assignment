//
//  PersonListDatasource.swift
//  IssueNavigator
//
//  Created by Romina Uncrop on 02/02/2021.
//  Copyright © 2021 TestApp. All rights reserved.
//

import Foundation

// MARK: - Protocols

/// Contract for a view that displays a Person's details
protocol PersonCellView {
    func display(firstName: String, surname: String, issueCount: String, birthDate: String)
}

/// Contract for a view that displays a list of Person objects
protocol PersonListView: class {
    func display(title: String)
    func showList()
    func showNoContent(with message: String)
}

/// Contract that keeps the bussiness logic for displaying a list of Person objects
protocol PersonDatasource {
    var numberOfPersons: Int { get }
    
    func attach(view: PersonListView)
    func setupView()
    func configureCell(_ cell: PersonCellView, at row: Int)
}

// MARK: - PersonListDatasource

/// Bussiness logic container for configuring `PersonListView` and  `PersonCellView`
class PersonListDatasource: PersonDatasource {
    /// The list of persons to be displayed
    /// MUST be injected before presenting this controller
    private var datasource: [Person]
    
    /// The view that displays a list of persons
    weak private var view: PersonListView?

    /// The number of persons to be displayed
    var numberOfPersons: Int { return datasource.count }
    
    /**
    Initializes a new datasource with the provided list of persons.

    - Parameters:
       - persons: The list of persons to be displayed

    - Returns: A datasource with the provided specifications
    */
    init(persons: [Person]) {
        self.datasource = persons
    }
    
    /**
    Binds a view for displaying a list

    - Parameters:
       - view: The view responsibile with showing the list
    */
    func attach(view: PersonListView) {
        self.view = view
    }
    
    /**
    Configures a view to display either a list of persons or a message when there no items in the list
    */
    func setupView() {
        view?.display(title: "List")
        if datasource.isEmpty {
            view?.showNoContent(with: "No records were found!")
        } else {
            view?.showList()
        }
    }
    
    /**
    Configures a row from the list
     
     - Parameters:
        - cell: The view specialized on displaying a person
        - row: The person's order number in the list
    */
    func configureCell(_ cell: PersonCellView, at row: Int) {
        let person = datasource[row]
        
        cell.display(firstName: person.firstName, surname: person.surname, issueCount: "\(person.issueCount)", birthDate: "\(person.birthDate)")
    }
}
