//
//  CSVSelectorDatasource.swift
//  IssueNavigator
//
//  Created by Romina Uncrop on 02/02/2021.
//  Copyright © 2021 TestApp. All rights reserved.
//

import Foundation
import CSV

protocol CSVSelectorView: class {
    func startLoading()
    func stopLoading()
    func showFileError()
    func navigateToList(with records: [Person])
}

protocol CSVSelectorDatasource {
    func attach(view: CSVSelectorView)
    func didSelectFile(path: String)
    var initialPath: URL? { get }
}

class CSVSelector: CSVSelectorDatasource {
    private var startTime: TimeInterval = 0
    private var endTime: TimeInterval = 0
    
    weak private var view: CSVSelectorView?
    
    var initialPath: URL? {
        return FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first
    }
    
    private var elapsedTime: TimeInterval {
        return endTime - startTime
    }
    
    func attach(view: CSVSelectorView) {
        self.view = view
    }
    
    func didSelectFile(path: String) {
        view?.startLoading()
        self.startTime = Date().timeIntervalSince1970
        
        parseCSV(path: path)
    }
    
    private func parseCSV(path: String) {
        DispatchQueue.global(qos: .background).async {
            do {
                guard let stream = InputStream(fileAtPath: path) else {
                    self.view?.stopLoading()
                    self.view?.showFileError()
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
                
                self.endTime = Date().timeIntervalSince1970
                
                DispatchQueue.main.async {
                    self.view?.stopLoading()
                    print("number of records:\(records.count), number of skipped records:\(malformedCount)")
                    print("time:\(self.elapsedTime)")
                    self.view?.navigateToList(with: records)
                }
            } catch {
                DispatchQueue.main.async {
                    self.view?.stopLoading()
                    self.view?.showFileError()
                    print("could not open file")
                }
            }
        }
    }
}
