//
//  URLItem.swift
//  Chromic
//
//  Created by hujinyou on 2025/7/19.
//

import SwiftUI

struct URLItem: Identifiable {
    let id: String
    let url: URL
    let relativePath: String
    
    init(_ url: URL, projectFolder: URL) {
        let relativePath = url.relativePath(to: projectFolder)
        self.url = url
        self.id = relativePath
        self.relativePath = relativePath
    }
    
    init?(relativePath: String, projectFolder: URL) {
        let url = projectFolder.auu_appending(pathComponent: relativePath)
        
        guard FileManager.default.fileExists(atPath: url.filePath) else {
            return nil
        }
        
        self.url = url
        self.relativePath = relativePath
        self.id = relativePath
    }
}
