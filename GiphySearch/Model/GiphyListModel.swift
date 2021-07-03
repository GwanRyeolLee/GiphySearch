//
//  GiphyListModel.swift
//  GiphySearch
//
//  Created by 이관렬 on 2021/07/03.
//

import Foundation

struct GiphyListModel: Decodable {
    var pagination: Pagenation?
    var data: [GiphyDataList]?
}

struct Pagenation: Decodable {
    var total_count: Int?
    var count: Int?
    var offset: Int?
}

struct GiphyDataList: Decodable {
    var id: String?
    var username: String?
    var images: Images?
}

struct Images: Decodable {
    var original_still: original_still?
    
    struct original_still: Decodable {
        var height: String?
        var width: String?
        var size: String?
        var url: String?
    }
}
