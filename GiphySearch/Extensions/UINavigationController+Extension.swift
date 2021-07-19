//
//  UINavigationController+Extension.swift
//  GiphySearch
//
//  Created by greencar on 2021/07/19.
//

import UIKit

extension UINavigationController {
    
    func isExist<T>(type: T.Type) -> Bool {
        let resultViewControllers = viewControllers.compactMap { $0 as? T }
        return !resultViewControllers.isEmpty
    }
    
    func pushAfterPopViewController(_ viewController: UIViewController, animaed: Bool) {
        var resultViewControllers = viewControllers
        resultViewControllers.removeLast()
        resultViewControllers.append(viewController)
        setViewControllers(resultViewControllers, animated: animaed)
    }
}
