//
//  MainTabsController.swift
//  2023.StateRestoringPractice
//
//  Created by 曲奕帆 on 2023/5/1.
//

import UIKit

class MainTabsController: UITabBarController, UITabBarControllerDelegate {
    
    /// 被選擇到的頁面。
    /// 此變數將會在App開啟時，
    ///
    /// -Authors: Tomtom Chu
    /// -Date: 2023.5.1
    var restoredSelectedTab: Int = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // 有tabbar事件時，通知給self
        delegate = self
        
        // 設定頁面畫面
        setupView()
    }
    
    /// 設定頁面。將有三個分頁：Tab1淺藍、Tab2淺紅、Tab3淺黃頁面。
    ///
    /// -Authors: Tomtom Chu
    /// -Date: 2023.5.1
    func setupView(){
        // 淺藍色頁面
        let tab1 = UIViewController()
        tab1.view.backgroundColor = UIColor(red: 157/255, green: 210/255, blue: 248/255, alpha: 1.00)
        // 淺紅色頁面
        let tab2 = UIViewController()
        tab2.view.backgroundColor = UIColor(red: 244/255, green: 175/255, blue: 180/255, alpha: 1.00)
        // 淺黃色頁面
        let tab3 = UIViewController()
        tab3.view.backgroundColor = UIColor(red: 254/255, green: 251/255, blue: 155/255, alpha: 1.00)
        
        // 將個頁面設定至Tab頁面中
        self.setViewControllers([tab1, tab2, tab3], animated: true)
        
        // 設定Tabbar Icon
        let itemNames = ["1.circle","2.circle","3.circle"]
        // 項目名稱
        let itemsTitle = [ "Page1", "Page2", "Page3"]
        // 設定Tab Icon
        guard let items = self.tabBar.items else { return }
        for (index, item) in items.enumerated(){
            item.tag = index
            item.image = UIImage(systemName: itemNames[index])
            item.title = itemsTitle[index]
        }
        
        tabBar.tintColor = .systemBlue
        tabBar.backgroundColor = .white
        tabBar.unselectedItemTintColor = .lightGray
    }
    
    /// 由於在SceneDelegate中，
    /// 當View出現時，將頁面跳轉至restoredSelectedTab頁。
    /// SceneDelegate在取得userActivity時，上次儲存在userActivity的分頁將會Assign給restoredSelectedTab。
    ///
    /// -Authors: Tomtom Chu
    /// -Date: 2023.5.1
    override func viewDidAppear(_ animated: Bool) {
        selectedIndex = restoredSelectedTab
    }
    
    /// 當Tab被User點選時，將選擇的分頁儲存進userActivity中。
    ///
    /// -Authors: Tomtom Chu
    /// -Date: 2023.5.1
    func tabBarController(_ tabBarController: UITabBarController, didSelect viewController: UIViewController) {
        restoredSelectedTab = tabBarController.selectedIndex
        if #available(iOS 13.0, *) {
            updateUserActivity()
        }
    }
    
    /// 更新userActivity中儲存的資料內容。如：所選擇的分頁(selectedTab)。
    ///
    /// -Authors: Tomtom Chu
    /// -Date: 2023.5.1
    func updateUserActivity() {
        var currentUserActivity = view.window?.windowScene?.userActivity
        
        // 如果當前的Scene沒有userActivity的物件，以Bundle中(Info.plist)中所設定的UserActivity Type創建一個。
        if currentUserActivity == nil {
            /** Note: You must include the activityType string below in your Info.plist file under the `NSUserActivityTypes` array.
                More info: https://developer.apple.com/documentation/foundation/nsuseractivity
            */
            currentUserActivity = NSUserActivity(activityType: SceneDelegate.MainSceneActivityType())
        }

        /// ⭐️ 重要：
        /// 要使用addUserInfoEntries(from:)來儲存資料到userActivity。
        ///
        /// -Authors: Tomtom Chu
        /// -Date: 2023.5.1
        currentUserActivity?.addUserInfoEntries(from: [SceneDelegate.selectedTabKey: restoredSelectedTab])
        
        view.window?.windowScene?.userActivity = currentUserActivity
        
    }
    

}
