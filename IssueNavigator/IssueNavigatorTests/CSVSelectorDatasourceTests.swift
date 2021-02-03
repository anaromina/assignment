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
    
    func test_didSelectFile_shouldStartLoading() {
        let worker = CSVWorkerMock(count: 10, skippedCount: 0, isSuccessful: true)
        systemUnderTest = CSVSelector(csvWorker: worker)
        let view = CSVSelectorViewSpy()
        systemUnderTest.attach(view: view)
        
        systemUnderTest.didSelectFile(path: "")
        
        XCTAssertTrue(view.didCallStartLoading)
    }
    
    func test_didSelectFile_shouldStopLoading() {
        let worker = CSVWorkerMock(count: 10, skippedCount: 0, isSuccessful: true)
        systemUnderTest = CSVSelector(csvWorker: worker)
        let view = CSVSelectorViewSpy()
        systemUnderTest.attach(view: view)
        
        systemUnderTest.didSelectFile(path: "")
        
        XCTAssertTrue(view.didCallStopLoading)
    }
    
    func test_didSelectFile_shoulShowFileError() {
        let worker = CSVWorkerMock(count: 10, skippedCount: 0, isSuccessful: false)
        systemUnderTest = CSVSelector(csvWorker: worker)
        let view = CSVSelectorViewSpy()
        systemUnderTest.attach(view: view)
        
        systemUnderTest.didSelectFile(path: "")
        
        XCTAssertTrue(view.didCallShowFileError)
    }
    
    func test_didSelectFile_shoulNavigateToList() {
        let worker = CSVWorkerMock(count: 10, skippedCount: 5, isSuccessful: true)
        systemUnderTest = CSVSelector(csvWorker: worker)
        let view = CSVSelectorViewSpy()
        systemUnderTest.attach(view: view)
        
        systemUnderTest.didSelectFile(path: "")
        
        XCTAssertTrue(view.didCallNavigateToList)
        XCTAssertEqual(view.skippedCount, 5)
        XCTAssertEqual(view.records.count, 10)
    }
}
