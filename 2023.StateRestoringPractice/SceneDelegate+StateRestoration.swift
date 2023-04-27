//
//  SceneDelegate+StateRestoration.swift
//  2023.StateRestoringPractice
//
//  Created by 曲奕帆 on 2023/4/27.
//

import UIKit

@available(iOS 13.0, *)
extension SceneDelegate {
    
    /// 狀態回復的Key值。
    ///
    /// 我們將會用這些key，將App的狀態儲存在UserActivity的userInfo中。
    ///
    /// -Authors: Tomtom Chu
    /// -Date: 2023.4.25
    static let productKey = "product" // The product identifier.
    
    /** Data key for storing the session's userInfo.
        The system marks this session's userInfo with the current product's identifier so you can use it later
        to update this scene if it’s in the background.
    */
    static let productIdentifierKey = "productIdentifier"
    
    // Activity type for restoring this scene (loaded from the plist).
    // 回傳這個Scene的UserActivity
    static let MainSceneActivityType = { () -> String in
        // Load the activity type from the Info.plist.
        let activityTypes = Bundle.main.infoDictionary?["NSUserActivityTypes"] as? [String]
        return activityTypes![0]
    }
    
    
    /// 從activity的userInfo中，取出上次離開App時，當下的頁面的Product。
    ///
    /// class  function說明：
    /// 用class 宣告的 function，只會在class可以呼叫，instance不會有。
    ///
    /// -Authors: Tomtom Chu
    /// -Date: 2023.4.26
    class func product(for activity: NSUserActivity) -> Product? {
         var product: Product!
         if let userInfo = activity.userInfo {
             // Decode the user activity product identifier from the userInfo.
             if let productIdentifier = userInfo[SceneDelegate.productKey] as? String {
                 
                 /// 以productIdentifier，從DataModel中取得Product實體。
                 ///
                 /// -Authors: Tomtom Chu
                 /// -Date: 2023.4.26
//                 product = DataModelManager.sharedInstance.product(fromIdentifier: productIdentifier)
             }
         }
         return product
    }

    
}
