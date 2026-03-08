//
//  URL+.swift
//  Chromic
//
//  Created by hujinyou on 2025/7/19.
//

import Foundation

extension URL {
    func auu_appending(pathComponent path: String) -> URL {
        if path.hasPrefix("/") {
            return appendingPathComponent(String(path.dropFirst()))
        } else {
            return appendingPathComponent(path)
        }
    }
    
    var filePath: String {
        return path(percentEncoded: false)
    }
}
