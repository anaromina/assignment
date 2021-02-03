//
//  AppDelegate.swift
//  IssueNavigator
//
//  Created by Romina Uncrop on 01/02/2021.
//  Copyright © 2021 TestApp. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    /**
    Add CSV resources to device.

    Calling this method copies  the `.csv` files from the App Bundle into the Documents folder.
    */
    private func copyCSVs() {
        guard let resourcePath = Bundle.main.resourcePath else { return }
        do {
            let resources = try FileManager.default.contentsOfDirectory(atPath: resourcePath)
            let documentsURL = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first
            let filteredFiles = resources.filter { $0.contains(".csv")}
            for fileName in filteredFiles {
                if let documentsURL = documentsURL {
                    let sourceURL = Bundle.main.bundleURL.appendingPathComponent(fileName)
                    let destURL = documentsURL.appendingPathComponent(fileName)
                    do {
                        try FileManager.default.copyItem(at: sourceURL, to: destURL)
                    } catch { }
                }
            }
        } catch { }
    }

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        copyCSVs()

        return true
    }

    // MARK: UISceneSession Lifecycle

    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        // Called when a new scene session is being created.
        // Use this method to select a configuration to create the new scene with.
        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }

    func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {
        // Called when the user discards a scene session.
        // If any sessions were discarded while the application was not running, this will be called shortly after application:didFinishLaunchingWithOptions.
        // Use this method to release any resources that were specific to the discarded scenes, as they will not return.
    }

}
