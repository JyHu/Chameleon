//
//  AppearanceFile.swift
//  Chromic
//
//  Created by hujinyou on 2025/7/18.
//

import SwiftUI

class AppearanceFile: ObservableObject, Identifiable {
    let fileURL: URLItem
    @Published var name: String
    
    var id: String { fileURL.id }
    
    init(fileURL: URL, projectFolder: URL) {
        self.fileURL = URLItem(fileURL, projectFolder: projectFolder)
        self.name = fileURL.deletingPathExtension().lastPathComponent
    }
    
    init?(pathInfo: [String: Any], projectFolder: URL) {
        if let filePath = pathInfo["filePath"] as? String,
            let fileURL = URLItem(relativePath: filePath, projectFolder: projectFolder) {
            
            self.fileURL = fileURL
            self.name = pathInfo["name"] as? String ?? fileURL.url.deletingPathExtension().lastPathComponent
        } else {
            return nil
        }
    }
    
    func toKeyValue() -> [String: Any] {
        return [
            "filePath": fileURL.relativePath,
            "name": name
        ]
    }
}
