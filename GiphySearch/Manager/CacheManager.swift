//
//  CacheManager.swift
//  GiphySearch
//
//  Created by greencar on 2021/07/12.
//

import UIKit

class CacheManager {
    
    static let shared = NSCache<NSString, UIImage>()
    
    private init() {}
}
