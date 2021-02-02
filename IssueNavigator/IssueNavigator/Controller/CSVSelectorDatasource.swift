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
    func navigateToList(with records: [Person], skippedCount: Int)
}

protocol CSVSelectorDatasource {
    func attach(view: CSVSelectorView)
    func didSelectFile(path: String)
    var initialPath: URL? { get }
}

class CSVSelector: CSVSelectorDatasource {
    private var startTime: TimeInterval = 0
    private var endTime: TimeInterval = 0
    private let worker: DatasourceWorkerProtocol
    
    init(worker: DatasourceWorkerProtocol = CSVWorker(path: "")) {
        self.worker = worker
    }
    
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
        worker.updatePath(path: path)
        
        view?.startLoading()
        self.startTime = Date().timeIntervalSince1970
        
        worker.getRecords(completion: { [weak self] (result) in
            guard let self = self else { return }
            
            self.endTime = Date().timeIntervalSince1970
            self.view?.stopLoading()
            
            switch result {
            case let .success((records, skippedCount)):
                print("number of records:\(records.count), number of skipped records:\(skippedCount)")
                print("time:\(self.elapsedTime)")
                self.view?.navigateToList(with: records, skippedCount: skippedCount)
            case .failure(_):
                self.view?.showFileError()
            }
        })
    }
}
