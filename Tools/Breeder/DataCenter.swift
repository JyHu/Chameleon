//
//  DataManager.swift
//  Breeder
//
//  Created by Jo on 2023/4/7.
//

import Foundation
import Combine

class DataCenter {
    static var shared = DataCenter()
    
    @Published var files: [FileInfo] = []
}

class FileInfo {
    let identifier = UUID().uuidString
    var name: String?
    var url: URL?
}
