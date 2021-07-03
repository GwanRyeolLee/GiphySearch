//
//  Utils.swift
//  GiphySearch
//
//  Created by 이관렬 on 2021/07/03.
//

import Foundation

func LOG(_ msg: Any?, file: String = #file, function: String = #function, line: Int = #line) {
    #if DEBUG
    let fileName = file.split(separator: "/").last ?? ""
    let funcName = function.split(separator: "(").first ?? ""
    print("[\(fileName)] \(funcName)(\(line)): \(msg ?? "")")
    #endif
}
