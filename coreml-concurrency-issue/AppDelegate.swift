//
//  AppDelegate.swift
//  coreml-concurrency-issue
//
//  Created by Roi Mulia on 24/11/2022.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {



    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
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


@_transparent @discardableResult public func measure(label: String? = nil, tests: Int = 1, printResults output: Bool = true, setup: @escaping () -> Void = { return }, _ block: @escaping () -> Void) -> Double {
    
    guard tests > 0 else { fatalError("Number of tests must be greater than 0") }
    
    var avgExecutionTime : CFAbsoluteTime = 0
    for _ in 1...tests {
        setup()
        let start = CFAbsoluteTimeGetCurrent()
        block()
        let end = CFAbsoluteTimeGetCurrent()
        avgExecutionTime += end - start
    }
    
    avgExecutionTime /= CFAbsoluteTime(tests)
    
    if output {
        let avgTimeStr = "\(avgExecutionTime)".replacingOccurrences(of: "e|E", with: " × 10^", options: .regularExpression, range: nil)
        
        if let label = label {
            print(label, "▿")
            print("\tExecution time: \(avgTimeStr)s")
            print("\tNumber of tests: \(tests)\n")
        } else {
            print("Execution time: \(avgTimeStr)s")
            print("Number of tests: \(tests)\n")
        }
    }
    
    return avgExecutionTime
}
