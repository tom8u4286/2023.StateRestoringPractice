//
//  SceneDelegate+StateRestoration.swift
//  2023.StateRestoringPractice
//
//  Created by 曲奕帆 on 2023/4/27.
//

import UIKit

extension SceneDelegate {
    
    static let MainSceneActivityType { () -> String in
        let activityType = Bundle.main.infoDictionary?["NSUserActivityTypes"] as? [String]
        return activityType[0]
    }
    
    
    // 回傳這個Scene的UserActivity
    func stateRestorationActivity(for scene: UIScene) -> NSUserActivity? {
//        if let rootViewController = window?.rootViewController as? UINavigationController,
           
    }
    
}
