//
//  PersonListDatasourceTests.swift
//  IssueNavigatorTests
//
//  Created by Romina Uncrop on 02/02/2021.
//  Copyright © 2021 TestApp. All rights reserved.
//

import XCTest
@testable import IssueNavigator

class PersonListDatasourceTests: XCTestCase {
    
    private var systemUnderTest: PersonListDatasource!
    private let date = Date.init(timeIntervalSince1970: 38473482)
    
    private func createPersonsArray(count: Int) -> [Person] {
        var records = [Person]()
        for _ in 0..<count {
            records.append(Person(firstName: "John", surname: "Doe", issueCount: 5, birthDate: date))
        }
        
        return records
    }

    func test_numberOfPersons_returnsPersonsCount() {
        systemUnderTest = PersonListDatasource(persons: createPersonsArray(count: 5))
        systemUnderTest.attach(view: PersonListViewSpy())
        systemUnderTest.setupView()
        
        XCTAssertEqual(systemUnderTest.numberOfPersons, 5)
    }
    
    func test_numberOfPersons_returns0_whenEmpty() {
        systemUnderTest = PersonListDatasource(persons: createPersonsArray(count: 0))
        systemUnderTest.attach(view: PersonListViewSpy())
        systemUnderTest.setupView()
        
        XCTAssertEqual(systemUnderTest.numberOfPersons, 0)
    }
    
    func test_viewDidLoad_displaysTitle() {
        systemUnderTest = PersonListDatasource(persons: createPersonsArray(count: 5))
        let view = PersonListViewSpy()
        systemUnderTest.attach(view: view)
        systemUnderTest.setupView()
        
        XCTAssertEqual(view.displayedTitle, "List")
    }
    
    func test_viewDidLoad_displaysPersons() {
        systemUnderTest = PersonListDatasource(persons: createPersonsArray(count: 5))
        let view = PersonListViewSpy()
        systemUnderTest.attach(view: view)
        systemUnderTest.setupView()
        
        XCTAssertTrue(view.didCallShowList)
    }
    
    func test_viewDidLoad_displaysEmptyMessage() {
        systemUnderTest = PersonListDatasource(persons: createPersonsArray(count: 0))
        let view = PersonListViewSpy()
        systemUnderTest.attach(view: view)
        systemUnderTest.setupView()
        
        XCTAssertEqual(view.noContentMessage, "No records were found!")
    }
    
    func test_configureCell_displayedName() {
        systemUnderTest = PersonListDatasource(persons: createPersonsArray(count: 1))
        let view = PersonListViewSpy()
        systemUnderTest.attach(view: view)
        systemUnderTest.setupView()
        
        let cell = PersonCellViewSpy()
        systemUnderTest.configureCell(cell, at: 0)
        
        XCTAssertEqual(cell.displayedFirstName, "John")
    }
    
    func test_configureCell_displayedSurname() {
        systemUnderTest = PersonListDatasource(persons: createPersonsArray(count: 1))
        let view = PersonListViewSpy()
        systemUnderTest.attach(view: view)
        systemUnderTest.setupView()
        
        let cell = PersonCellViewSpy()
        systemUnderTest.configureCell(cell, at: 0)
        
        XCTAssertEqual(cell.displayedSurname, "Doe")
    }
    
    func test_configureCell_displayedCount() {
        systemUnderTest = PersonListDatasource(persons: createPersonsArray(count: 1))
        let view = PersonListViewSpy()
        systemUnderTest.attach(view: view)
        systemUnderTest.setupView()
        
        let cell = PersonCellViewSpy()
        systemUnderTest.configureCell(cell, at: 0)
        
        XCTAssertEqual(cell.displayedIssueCount, "5")
    }
    
    func test_configureCell_displayedDate() {
        systemUnderTest = PersonListDatasource(persons: createPersonsArray(count: 1))
        let view = PersonListViewSpy()
        systemUnderTest.attach(view: view)
        systemUnderTest.setupView()
        
        let cell = PersonCellViewSpy()
        systemUnderTest.configureCell(cell, at: 0)
        
        XCTAssertEqual(cell.displayedBirthDate, "March 22, 1971")
    }

}
