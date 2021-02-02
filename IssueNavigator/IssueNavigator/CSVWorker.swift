//
//  CSVWorker.swift
//  IssueNavigator
//
//  Created by Romina Uncrop on 02/02/2021.
//  Copyright © 2021 TestApp. All rights reserved.
//

import Foundation
import CSV

protocol DatasourceWorkerProtocol {
    typealias GetPersonsResult = Result<([Person], Int), RecordError>
    typealias GetPersonsCompletion = (_ result: GetPersonsResult) -> Void
    func getRecords(completion: @escaping GetPersonsCompletion)
    func updatePath(path: String)
}

enum RecordError: Error {
    case file
    case csv(Error)
}

class CSVWorker: DatasourceWorkerProtocol {
    private var path: String
    
    init(path: String) {
        self.path = path
    }
    
    func updatePath(path: String) {
        self.path = path
    }
    
    func getRecords(completion: @escaping GetPersonsCompletion) {
        DispatchQueue.global(qos: .background).async {
            do {
                guard let stream = InputStream(fileAtPath: self.path) else {
                    completion(.failure(.file))
                    return
                }
                
                var records = [Person]()
                
                let csv = try CSVReader(stream: stream, hasHeaderRow: true)
                
                let headerRow = csv.headerRow!
                print("\(headerRow)")
                
                let decoder = CSVRowDecoder()
                var malformedCount = 0
                
                while csv.next() != nil {
                    do {
                        let row = try decoder.decode(Person.self, from: csv)
                        records.append(row)
                    } catch is DecodingError {
                        malformedCount += 1
                    }
                }
                                
                DispatchQueue.main.async {
                    completion(.success((records, malformedCount)))
                }
            } catch {
                DispatchQueue.main.async {
                    completion(.failure(.csv(error)))
                    print("could not open file")
                }
            }
        }
    }
}
