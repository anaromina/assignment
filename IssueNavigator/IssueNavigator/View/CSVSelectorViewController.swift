//
//  CSVSelectorViewController.swift
//  IssueNavigator
//
//  Created by Romina Uncrop on 01/02/2021.
//  Copyright © 2021 TestApp. All rights reserved.
//


import UIKit
import FileBrowser

class CSVSelectorViewController: UIViewController {
    @IBOutlet weak var loadButton: UIButton!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    private let datasource = CSVSelector()
    
    private lazy var fileBrowser: FileBrowser = {
        return FileBrowser(initialPath: datasource.initialPath)
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configure()
    }
    
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
    func startLoading() {
        loadButton.isHidden = true
        activityIndicator.startAnimating()
    }
    
    func stopLoading() {
        loadButton.isHidden = false
        activityIndicator.stopAnimating()
    }
    
    func navigateToList(with records: [Person], skippedCount: Int) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let listViewController = storyboard.instantiateViewController(withIdentifier: "PersonListIdentifier") as! PersonListViewController
        let listDatasource = PersonListDatasource(persons: records)
        listViewController.dataSource = listDatasource
        self.show(listViewController, sender: nil)
    }
    
    func showFileError() {
        let alert = UIAlertController(title: "Error", message: "Could not load CSV", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        self.present(alert, animated: true, completion: {
            self.stopLoading()
        })
    }
}
