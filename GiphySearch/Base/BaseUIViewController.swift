//
//  BaseUIViewController.swift
//  GiphySearch
//
//  Created by 이관렬 on 2021/07/01.
//

import UIKit

class BaseUIViewController: UIViewController {
    
    var mNavigationBarIsHidden = false
    
    func setNavigationBar(hidden: Bool = false, title: String? = nil) {
        self.title = title
        mNavigationBarIsHidden = hidden
        
        let leftBarBtnItemView = UIView(frame: CGRect(x: 0, y: 0, width: 30, height: 30))
        let leftBtn = UIButton(type: .custom)
        
        leftBarBtnItemView.addSubview(leftBtn)
        leftBtn.frame = CGRect(x: 0, y: 0, width: 30, height: 30)
        leftBtn.setImage(UIImage(named: "icBack"), for: .normal)
        leftBtn.addTarget(self, action: #selector(onClickNavigationBtnBack), for: .touchUpInside)
        
        let barBtnItem = UIBarButtonItem(customView: leftBarBtnItemView)
        navigationItem.leftBarButtonItems = [barBtnItem]
        
        UINavigationBar.appearance().isTranslucent = false
        UINavigationBar.appearance().titleTextAttributes = [.font : UIFont.systemFont(ofSize: 20, weight: .medium)]
    }
    
    override func viewWillAppear(_ animated: Bool) {
        if mNavigationBarIsHidden {
            navigationController?.setNavigationBarHidden(true, animated: false)
        } else {
            navigationController?.setNavigationBarHidden(false, animated: false)
        }
    }
}

extension BaseUIViewController {
    @objc func onClickNavigationBtnBack() {
        guard let navi = navigationController else {
            return
        }
        
        if navi.isExist(type: SearchViewController.self) || navi.viewControllers.count > 2 {
            navi.popViewController(animated: true)
        } else {
            navi.pushAfterPopViewController(SearchViewController.loadFromNib(), animaed: true)
        }
    }
}
