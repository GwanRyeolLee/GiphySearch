//
//  BaseUIViewController.swift
//  GiphySearch
//
//  Created by 이관렬 on 2021/07/01.
//

import UIKit

class BaseUIViewController: UIViewController {
    
    func setNavigationBar(hidden: Bool = false, title: String? = nil) {
        if hidden {
            navigationController?.setNavigationBarHidden(true, animated: false)
            navigationController?.title = title
        }
    }
}
