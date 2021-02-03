//
//  PersonViewCell.swift
//  IssueNavigator
//
//  Created by Romina Uncrop on 02/02/2021.
//  Copyright © 2021 TestApp. All rights reserved.
//

import UIKit

/// A table view cell that displays the details of a Person
class PersonViewCell: UITableViewCell {

    // MARK: - IBOutlets
    @IBOutlet private weak var firstNameLabel: UILabel!
    @IBOutlet private weak var surnameLabel: UILabel!
    @IBOutlet private weak var dateOfBirthLabel: UILabel!
    @IBOutlet private weak var issueCountLabel: UILabel!
    
    // MARK: - Constants
    static let cellIdentifier = "personCellIdentifier"
}

// MARK: - PersonCellView protocol implementation
extension PersonViewCell: PersonCellView {
    /**
    Designs a table view cell with the provided information regarding a person.

    - Parameters:
       - firstName: The first name of the person
       - surname: The last name of the person
       - issueCount: The number of issues assigned to the person
       - birthDate: The birth date of the person
    */
    func display(firstName: String, surname: String, issueCount: String, birthDate: String) {
        firstNameLabel.text = firstName
        surnameLabel.text = surname
        dateOfBirthLabel.text = birthDate
        issueCountLabel.text = issueCount
    }
}
