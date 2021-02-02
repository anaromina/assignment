//
//  PersonListDatasource.swift
//  IssueNavigator
//
//  Created by Romina Uncrop on 02/02/2021.
//  Copyright © 2021 TestApp. All rights reserved.
//

import Foundation

protocol PersonCellView {
    func display(firstName: String, surname: String, issueCount: String, birthDate: String)
}

protocol PersonListView: class {
    func display(title: String)
    func showList()
    func showNoContent(with message: String)
}

protocol PersonDatasource {
    var numberOfPersons: Int { get }
    
    func attach(view: PersonListView)
    func setupView()
    func configureCell(_ cell: PersonCellView, at row: Int)
}

class PersonListDatasource: PersonDatasource {
    private var datasource: [Person]
    
    weak private var view: PersonListView?

    var numberOfPersons: Int { return datasource.count }
    
    init(persons: [Person]) {
        self.datasource = persons
    }
    
    func attach(view: PersonListView) {
        self.view = view
    }
    
    func setupView() {
        view?.display(title: "List")
        if datasource.count == 0 {
            view?.showNoContent(with: "No records were found!")
        } else {
            view?.showList()
        }
    }
    
    func configureCell(_ cell: PersonCellView, at row: Int) {
        let person = datasource[row]
        
        cell.display(firstName: person.firstName, surname: person.surname, issueCount: "\(person.issueCount)", birthDate: "\(person.birthDate)")
    }
}
