//
//  IssueNavigatorUITests.swift
//  IssueNavigatorUITests
//
//  Created by Romina Uncrop on 01/02/2021.
//  Copyright © 2021 TestApp. All rights reserved.
//

import XCTest

class IssueNavigatorUITests: XCTestCase {
     private var app = XCUIApplication()

    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.

        // In UI tests it is usually best to stop immediately when a failure occurs.
        continueAfterFailure = false

        // In UI tests it’s important to set the initial state - such as interface orientation - required for your tests before they run. The setUp method is a good place to do this.
        app = XCUIApplication()
        app.launch()
        app.buttons["Load file"].tap()
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testLoadCSV_shouldDisplayThreeCells() {
        app.tables/*@START_MENU_TOKEN@*/.staticTexts["issues.csv"]/*[[".cells.staticTexts[\"issues.csv\"]",".staticTexts[\"issues.csv\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
        
        let number = app.tables.cells.count
        
        XCTAssertEqual(number, 3)
    }
    
    func testLoadCSV_withEmptyFile_shouldDisplayNoContentMessage() {
        app.tables.staticTexts["empty.csv"].tap()
        
        let number = app.tables.cells.count
        
        XCTAssertEqual(number, 0)
        
        let message = app.tables.staticTexts["No records were found!"]
        
        XCTAssert(message.waitForExistence(timeout: 5))
    }
    
    func testLoadCSV_withCorruptedFile_shouldDisplayAlert() {
        app.tables.staticTexts["bad_format.csv"].tap()
        
        XCTAssert(app.alerts.element.staticTexts["Could not load CSV"].waitForExistence(timeout: 5))
    }
    
    func testLoadCSV_withLargeFile_shouldDisplayInfo() {
        app.tables.staticTexts["huge.csv"].tap()
        
        let activityIndicator = app.activityIndicators.element
        
        XCTAssertEqual(activityIndicator.label, "In progress")
        XCTAssert(app.tables.cells.firstMatch.waitForExistence(timeout: 30))
    }

    func testLaunchPerformance() {
        if #available(macOS 10.15, iOS 13.0, tvOS 13.0, *) {
            // This measures how long it takes to launch your application.
            measure(metrics: [XCTOSSignpostMetric.applicationLaunch]) {
                XCUIApplication().launch()
            }
        }
    }
}
