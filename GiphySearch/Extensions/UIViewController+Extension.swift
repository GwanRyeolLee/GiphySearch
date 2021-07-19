//
//  UIViewController+Extension.swift
//  GiphySearch
//
//  Created by 이관렬 on 2021/07/01.
//

import UIKit

extension UIViewController {
    /// Xib 로드
    static func loadFromNib() -> Self {
        func instantiateFromNib<T: UIViewController>() -> T {
            return T.init(nibName: String(describing: T.self), bundle: nil)
        }
        
        return instantiateFromNib()
    }
}
