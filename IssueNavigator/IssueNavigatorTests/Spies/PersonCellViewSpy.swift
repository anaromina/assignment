//
//  PersonCellViewSpy.swift
//  IssueNavigatorTests
//
//  Created by Romina Uncrop on 02/02/2021.
//  Copyright © 2021 TestApp. All rights reserved.
//

import Foundation
@testable import IssueNavigator

class PersonCellViewSpy: PersonCellView {
    var displayedFirstName = ""
    var displayedSurname = ""
    var displayedIssueCount = ""
    var displayedBirthDate = ""
    
    func display(firstName: String, surname: String, issueCount: String, birthDate: String) {
        displayedFirstName = firstName
        displayedSurname = surname
        displayedIssueCount = issueCount
        displayedBirthDate = birthDate
    }
}
