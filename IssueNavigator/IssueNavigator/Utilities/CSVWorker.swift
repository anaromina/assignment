//
//  CSVWorker.swift
//  IssueNavigator
//
//  Created by Romina Uncrop on 02/02/2021.
//  Copyright © 2021 TestApp. All rights reserved.
//

import Foundation
import CSV

/// Errors encountered during parsing
enum RecordError: Error {
    case file
    case csv(Error)
}

/// Utility class that reads a CSV file and parses it row by row on a background thread.
class CSVWorker<Record: Decodable> {
    /**
    Goes across the CSV file and tries to decode each row into a `Record`.

    - Parameters:
       - path: The CSV file path
       - completion: The closure called when the parsing is concluded

    - Returns: A `Result` that can be either a success: tuple of an array of `Records`
     and an `Int` for the rows that couldn't be parsed or a failure: `RecordError`
    */
    func getRecords(from path: String, completion: @escaping (_ result: Result<([Record], Int), RecordError>) -> Void) {
        DispatchQueue.global(qos: .background).async {
            do {
                guard let stream = InputStream(fileAtPath: path) else {
                    completion(.failure(.file))
                    return
                }
                
                var records = [Record]()
                
                let csv = try CSVReader(stream: stream, hasHeaderRow: true)
                
                let headerRow = csv.headerRow!
                print("\(headerRow)")
                
                let decoder = CSVRowDecoder()
                var malformedCount = 0
                
                while csv.next() != nil {
                    do {
                        let row = try decoder.decode(Record.self, from: csv)
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
