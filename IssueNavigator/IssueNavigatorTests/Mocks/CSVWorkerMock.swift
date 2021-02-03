//
//  CSVWorkerMock.swift
//  IssueNavigatorTests
//
//  Created by Romina Uncrop on 02/02/2021.
//  Copyright © 2021 TestApp. All rights reserved.
//

import Foundation
@testable import IssueNavigator

class CSVWorkerMock: CSVWorker<Person> {
    typealias CSVPersonParserResult = Result<([Person], Int), RecordError>
    typealias GetPersonsCompletion = (CSVPersonParserResult) -> Void
    
    let count: Int
    let skipped: Int
    let isSuccessful: Bool
    
    init(count: Int = 5, skippedCount: Int = 0, isSuccessful: Bool = true) {
        self.count = count
        self.skipped = skippedCount
        self.isSuccessful = isSuccessful
    }
    
    override func getRecords(from path: String, completion: @escaping (Result<([Person], Int), RecordError>) -> Void) {
        guard isSuccessful else {
            completion(.failure(.file))
            return
        }
        
        let array = createArray(count: count)
        completion(.success((array, skipped)))
    }
    
    private func createArray(count: Int) -> [Person] {
        var records = [Person]()
        for _ in 0..<count {
            records.append(Person(firstName: "John", surname: "Doe", issueCount: 5, birthDate: Date()))
        }
        
        return records
    }
}
