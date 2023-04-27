//
//  UIView+.swift
//  2023.StateRestoringPractice
//
//  Created by 曲奕帆(Tomtom) on 2023/4/27.
//

import UIKit

extension UIView {
    
    /// 顯示UIView的邊框。
    ///
    /// 開發期間可以使用此func顯示UIView的邊框。
    ///
    /// -Authors: Tomtom Chu
    /// -Date: 2023.3.19
    func showBorder(width: CGFloat = 1, color: UIColor = UIColor.red){
        self.layer.borderWidth = width
        self.layer.borderColor = color.cgColor
    }
    
    
}
