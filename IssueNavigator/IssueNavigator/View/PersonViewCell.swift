//
//  PersonViewCell.swift
//  IssueNavigator
//
//  Created by Romina Uncrop on 02/02/2021.
//  Copyright © 2021 TestApp. All rights reserved.
//

import UIKit

class PersonViewCell: UITableViewCell {

    @IBOutlet weak var firstNameLabel: UILabel!
    @IBOutlet weak var surnameLabel: UILabel!
    @IBOutlet weak var dateOfBirthLabel: UILabel!
    @IBOutlet weak var issueCountLabel: UILabel!
    
    static let cellIdentifier = "personCellIdentifier"
}

extension PersonViewCell: PersonCellView {
    func display(firstName: String, surname: String, issueCount: String, birthDate: String) {
        firstNameLabel.text = firstName
        surnameLabel.text = surname
        dateOfBirthLabel.text = birthDate
        issueCountLabel.text = issueCount
    }
    
    
}
