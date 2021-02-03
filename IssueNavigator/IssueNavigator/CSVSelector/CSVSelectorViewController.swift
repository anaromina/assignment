//
//  CSVSelectorViewController.swift
//  IssueNavigator
//
//  Created by Romina Uncrop on 01/02/2021.
//  Copyright © 2021 TestApp. All rights reserved.
//

import UIKit
import FileBrowser

/// Shows a file browser
class CSVSelectorViewController: UIViewController {
    // MARK: - Private vars
    @IBOutlet private weak var loadButton: UIButton!
    @IBOutlet private weak var activityIndicator: UIActivityIndicatorView!
    
    private let datasource = CSVSelector()
    
    private lazy var fileBrowser: FileBrowser = {
        return FileBrowser(initialPath: datasource.initialPath)
    }()
    
    // MARK: - View lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        configure()
    }
    
    // MARK: - Private methods
    private func configure() {
        datasource.attach(view: self)
        fileBrowser.didSelectFile = { [weak self] (file: FBFile) -> Void in
            self?.datasource.didSelectFile(path: file.filePath.relativePath)
        }
    }
    
    private func presentFileBrowser() {
        present(fileBrowser, animated: true, completion: nil)
    }
    
    @IBAction func didTapSelectButton(_ sender: Any) {
        presentFileBrowser()
    }
}

extension CSVSelectorViewController: CSVSelectorView {
    /**
     Shows a spinning activity indicator.
     */
    func startLoading() {
        loadButton.isHidden = true
        activityIndicator.startAnimating()
    }
    
    /**
     Stops the activity indicator and shows the load button.
     */
    func stopLoading() {
        loadButton.isHidden = false
        activityIndicator.stopAnimating()
    }
    
    /**
    Creates a new view controller and presents it on screen.
     
     - Parameters:
        - records: The array of persons to be displayed
        - skippedCount: The number of CSV rows that failed to be parsed
    */
    func navigateToList(with records: [Person], skippedCount: Int) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        
        guard let listViewController = storyboard.instantiateViewController(withIdentifier: "PersonListIdentifier")
            as? PersonListViewController else {
            fatalError("Could not instantiate a PersonListViewController object!")
        }
        
        let listDatasource = PersonListDatasource(persons: records)
        listViewController.dataSource = listDatasource
        self.show(listViewController, sender: nil)
    }
    
    /**
    Displays an alert to notify the user that the CSV file couldn't be opened.
    */
    func showFileError() {
        let alert = UIAlertController(title: "Error", message: "Could not load CSV", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        self.present(alert, animated: true, completion: {
            self.stopLoading()
        })
    }
}
