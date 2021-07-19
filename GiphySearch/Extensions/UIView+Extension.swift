//
//  UIView+Extension.swift
//  GiphySearch
//
//  Created by 이관렬 on 2021/07/01.
//

import UIKit

extension UIView {
    /// Xib 로드
    static func loadFromNib() -> Self {
        let bundle = Bundle(for: self)
        let nib = bundle.loadNibNamed("\(self)", owner: self, options: nil)
        
        return nib!.first as! Self
    }
    
    @IBInspectable var cornerRadius: CGFloat {
        get {
            return layer.cornerRadius
        }
        set {
            layer.cornerRadius = newValue
            layer.masksToBounds = newValue > 0
        }
    }
}
