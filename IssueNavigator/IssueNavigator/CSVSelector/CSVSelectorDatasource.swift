//
//  CSVSelectorDatasource.swift
//  IssueNavigator
//
//  Created by Romina Uncrop on 02/02/2021.
//  Copyright © 2021 TestApp. All rights reserved.
//

import Foundation
import CSV

// MARK: - Protocols

/// Blueprint for a view that draws a CSV selector
protocol CSVSelectorView: class {
    func startLoading()
    func stopLoading()
    func showFileError()
    func navigateToList(with records: [Person], skippedCount: Int)
}

/// Blueprint for CSV selector logic
protocol CSVSelectorDatasource {
    func attach(view: CSVSelectorView)
    func didSelectFile(path: String)
    var initialPath: URL? { get }
}

/// A handler for selecting a CSV file and parsing it into a list of `Person` objects.
///
/// Tells the view it manages to display a loading state while the parsing is in progress and then
/// to transition to a list view.
class CSVSelector: CSVSelectorDatasource {
    /// A value that represents either a success or a failure, including an
    /// error in case the parsing went wrong and a tuple of an array of persons and a number
    /// representing the count of malformed records
    typealias CSVPersonParserResult = Result<([Person], Int), RecordError>

    // MARK: - Private vars
    /// The time when the parsing started
    private var startTime: TimeInterval = 0
    /// The time when the parsing ended
    private var endTime: TimeInterval = 0
    /// Object that does the actual reading and parsing of the CSV
    private var worker: CSVWorker<Person>
    /// The view responsibile with showing the file browser
    weak private var view: CSVSelectorView?
    
    /// Total computing time
    private var elapsedTime: TimeInterval {
        return endTime - startTime
    }
    
    init(csvWorker: CSVWorker<Person> = CSVWorker<Person>()) {
        self.worker = csvWorker
    }
    
    // MARK: - CSVSelectorDatasource
    /// Location of CSV resources
    var initialPath: URL? {
        return FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first
    }
    
    /**
    Binds a view for displaying a file browser.

    - Parameters:
       - view: The view responsibile with showing the file browser
    */
    func attach(view: CSVSelectorView) {
        self.view = view
    }
    
    /**
    Initiates the CSV parsing while updating the view accordingly.

    - Parameters:
       - path: The CSV file's path
    */
    func didSelectFile(path: String) {
        view?.startLoading()
        self.startTime = Date().timeIntervalSince1970
        
        worker.getRecords(from: path, completion: { [weak self] (result: CSVPersonParserResult) in
            guard let self = self else { return }
            
            self.endTime = Date().timeIntervalSince1970
            self.view?.stopLoading()
            
            switch result {
            case let .success((records, skippedCount)):
                print("number of records:\(records.count), number of skipped records:\(skippedCount)")
                print("time:\(self.elapsedTime)")
                self.view?.navigateToList(with: records, skippedCount: skippedCount)
            case .failure:
                self.view?.showFileError()
            }
        })
    }
}
