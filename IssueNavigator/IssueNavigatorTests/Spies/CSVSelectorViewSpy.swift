//
//  CSVSelectorViewSpy.swift
//  IssueNavigatorTests
//
//  Created by Romina Uncrop on 02/02/2021.
//  Copyright © 2021 TestApp. All rights reserved.
//

import Foundation
@testable import IssueNavigator

class CSVSelectorViewSpy: CSVSelectorView {
    var didCallStartLoading = false
    var didCallStopLoading = false
    var didCallShowFileError = false
    var didCallNavigateToList = false
    
    var records = [Person]()
    var skippedCount = 0
    
    func startLoading() {
        didCallStartLoading = true
    }
    
    func stopLoading() {
        didCallStopLoading = true
    }
    
    func showFileError() {
        didCallShowFileError = true
    }
    
    func navigateToList(with records: [Person], skippedCount: Int) {
        didCallNavigateToList = true
        self.records = records
        self.skippedCount = skippedCount
    }
    
    
}
