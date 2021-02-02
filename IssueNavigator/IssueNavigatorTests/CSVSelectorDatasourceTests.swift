//
//  CSVSelectorDatasourceTests.swift
//  IssueNavigatorTests
//
//  Created by Romina Uncrop on 02/02/2021.
//  Copyright © 2021 TestApp. All rights reserved.
//

import XCTest
@testable import IssueNavigator

class CSVSelectorDatasourceTests: XCTestCase {
    
    private var systemUnderTest: CSVSelectorDatasource!
    
    func test_didSelectFile() {
        let worker = CSVWorkerMock(count: 10, skippedCount: 0, isSuccessful: true)
        systemUnderTest = CSVSelector(worker: worker)
        let view = CSVSelectorViewSpy()
        systemUnderTest.attach(view: view)
        
        systemUnderTest.didSelectFile(path: "")
        
        XCTAssertTrue(view.didCallStartLoading)
    }
}
