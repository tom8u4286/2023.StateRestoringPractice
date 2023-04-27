//
//  SceneDelegate+StateRestoration.swift
//  2023.StateRestoringPractice
//
//  Created by 曲奕帆 on 2023/4/27.
//

import UIKit

@available(iOS 13.0, *)
extension SceneDelegate {
    
//    static let MainSceneActivityType { () -> String in
//        let activityType = Bundle.main.infoDictionary?["NSUserActivityTypes"] as? [String]
//        return activityType![0]
//    }
    
    // Activity type for restoring this scene (loaded from the plist).
    static let MainSceneActivityType = { () -> String in
        // Load the activity type from the Info.plist.
        let activityTypes = Bundle.main.infoDictionary?["NSUserActivityTypes"] as? [String]
        return activityTypes![0]
    }
    
    
    // 回傳這個Scene的UserActivity
//    func stateRestorationActivity(for scene: UIScene) -> NSUserActivity? {
//        if let rootViewController = window?.rootViewController as? UINavigationController,
           
//    }
    
}
