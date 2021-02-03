//
//  PersonListViewSpy.swift
//  IssueNavigatorTests
//
//  Created by Romina Uncrop on 02/02/2021.
//  Copyright © 2021 TestApp. All rights reserved.
//

import Foundation
@testable import IssueNavigator

class PersonListViewSpy: PersonListView {
    var displayedTitle = ""
    var noContentMessage = ""
    var didCallShowList = false
    
    func display(title: String) {
        displayedTitle = title
    }
    
    func showList() {
        didCallShowList = true
    }
    
    func showNoContent(with message: String) {
        noContentMessage = message
    }
}
