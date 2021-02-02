//
//  CSVWorkerMock.swift
//  IssueNavigatorTests
//
//  Created by Romina Uncrop on 02/02/2021.
//  Copyright © 2021 TestApp. All rights reserved.
//

import Foundation
@testable import IssueNavigator

class CSVWorkerMock: DatasourceWorkerProtocol {
    func updatePath(path: String) {
    }
    
    let count: Int
    let skipped: Int
    let isSuccessful: Bool
    
    init(count: Int = 5, skippedCount: Int = 0, isSuccessful: Bool = true) {
        self.count = count
        self.skipped = skippedCount
        self.isSuccessful = isSuccessful
    }
    
    func getRecords(completion: @escaping GetPersonsCompletion) {
        guard isSuccessful else {
            completion(.failure(.file))
            return
        }
        
        completion(.success((createArray(count: count), skipped)))
    }
    
    private func createArray(count: Int) -> [Person] {
        var records = [Person]()
        for _ in 0..<count {
            records.append(Person(firstName: "John", surname: "Doe", issueCount: 5, birthDate: Date()))
        }
        
        return records
    }
    
    
}
