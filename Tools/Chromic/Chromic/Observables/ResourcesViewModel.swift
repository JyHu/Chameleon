//
//  ResourcesViewModel.swift
//  Chromic
//
//  Created by hujinyou on 2025/7/17.
//

import SwiftUI

class ResourcesViewModel: ObservableObject {
    @Published var projectFolder: URL? {
        didSet {
            saveProjectFolderBookmark()
        }
    }
    
    @Published var isProcessing: Bool
    
    @Published var showDetail: Bool = true
    @Published var showFiles: Bool = true
    
    @Published var imageRootName: String = "images"
    @Published var colorRootName: String = "colors"
    
    @Published private(set) var appearanceFiles: [AppearanceFile] = []
    @Published var imageFolders: [URLItem] = []
    
    @Published var rootNode: AppearanceNode?
    
    @Published var imageCodeFile: URLItem?
    @Published var colorCodeFile: URLItem?
    
    @Published var imageCodeModule: String = ""
    @Published var colorCodeModule: String = ""
    
    @Published var imageInfos: [ImageInfoModel] = []
    @Published var imageMap: [String: ImageInfoModel] = [:]
    
    @Published var languages: Set<String> = []
    
    @Published var selectedNodeIDs: Set<String> = []
    @Published var imageToPathesMap: [String: String] = [:]
    
    init(projectFolder: URL? = nil) {
        self.projectFolder = projectFolder
        self.isProcessing = true
        
        self.loadCache()
        
        self.processAllAppearanceInfos()
        
        for imageFolder in imageFolders {
            self.scanImages(in: imageFolder.url)
        }
        
        self.isProcessing = false
    }
    
    func synchronize() {
        self._synchronize()
    }
    
    func reprocessAppearanceFiles() {
        self.isProcessing = true
        
        self.processAllAppearanceInfos()
        
        self.isProcessing = false
    }
}

private extension ResourcesViewModel {
    func loadCache() {
        guard let projectFolder else { return }
        
        let fileURL = projectFolder.appendingPathComponent(".chromic/config.json")
        
        guard let data = try? Data(contentsOf: fileURL) else { return }
        
        guard let json = try? JSONSerialization.jsonObject(with: data, options: []) as? [String: Any] else { return }
        
        self.imageRootName = json["imageRootName"] as? String ?? "images"
        self.colorRootName = json["colorRootName"] as? String ?? "colors"
        
        if let appearanceFiles = json["appearanceFiles"] as? [[String: Any]] {
            self.appearanceFiles = appearanceFiles.compactMap {
                AppearanceFile(pathInfo: $0, projectFolder: projectFolder)
            }
        }
        
        if let imageFolders = json["imageFolders"] as? [String] {
            self.imageFolders = imageFolders.compactMap {
                URLItem(relativePath: $0, projectFolder: projectFolder)
            }
        }
        
        if let imageCodeFile = json["imageCodeFile"] as? String {
            self.imageCodeFile = URLItem(relativePath: imageCodeFile, projectFolder: projectFolder)
        }
        
        if let colorCodeFile = json["colorCodeFile"] as? String {
            self.colorCodeFile = URLItem(relativePath: colorCodeFile, projectFolder: projectFolder)
        }
    }
    
    func _synchronize() {
        guard let projectFolder else { return }

        var json: [String: Any] = [
            "imageRootName": imageRootName,
            "colorRootName": colorRootName
        ]
        
        if appearanceFiles.count > 0 {
            json["appearanceFiles"] = appearanceFiles.map { $0.toKeyValue() }
        }
        
        if imageFolders.count > 0 {
            json["imageFolders"] = imageFolders.map { $0.relativePath }
        }
        
        if let imageCodeFile {
            json["imageCodeFile"] = imageCodeFile.relativePath
        }
        
        if let colorCodeFile {
            json["colorCodeFile"] = colorCodeFile.relativePath
        }
        
        guard let data = try? json.toJsonData(options: .prettyPrinted) else { return }
        
        let folderURL = projectFolder.appendingPathComponent(".chromic")
        
        if !FileManager.default.fileExists(atPath: folderURL.filePath) {
            try? FileManager.default.createDirectory(at: folderURL, withIntermediateDirectories: true)
        }
        
        let fileURL = folderURL.appendingPathComponent("config.json")
        
        try? data.write(to: fileURL)
    }
    
    func saveProjectFolderBookmark() {
        guard let projectFolder else { return }
        
        do {
            guard projectFolder.startAccessingSecurityScopedResource() else {
                return
            }
            
            defer { projectFolder.stopAccessingSecurityScopedResource() }
            
            /// swiftui选择的必须先申请权限，然后才可以生成书签
            let bookmark = try projectFolder.bookmarkBase64EncodedString()
            UserDefaults.standard.set(bookmark, forKey: UserDefaultsKeys.projectFolder)
            UserDefaults.standard.synchronize()
            
            GlobalViewModel.shared.hadOpen = true
        } catch {
            print("Failed to save project folder bookmark: \(error)")
        }
    }
}

extension ResourcesViewModel {
    /// 添加新的文件只会在现有的数据上增加数据，不会产生反向的影响，所以只需要搜索即可
    func append(appearanceFile url: URL) {
        if appearanceFiles.contains(where: { $0.fileURL.url == url }) {
            return
        }
        
        guard let projectFolder else { return }
        
        let fileItem = AppearanceFile(fileURL: url, projectFolder: projectFolder)
        
        appearanceFiles.append(fileItem)
        
        _synchronize()
        
        processAppearanceInfo(at: fileItem.fileURL)
    }
    
    /// 移除数据可能造成数据节点的混乱，所以需要重新搜索所有的数据
    func removeAppearanceFile(with fileID: String?) {
        guard let fileID else { return }
        
        if let index = appearanceFiles.firstIndex(where: { $0.id == fileID }) {
            appearanceFiles.remove(at: index)
            _synchronize()
            reprocessAppearanceFiles()
        }
    }
    
    func append(imageFolder url: URL) {
        if imageFolders.contains(where: { $0.url == url }) {
            return
        }
        
        guard let projectFolder else { return }
        
        imageFolders.append(URLItem(url, projectFolder: projectFolder))
        
        _synchronize()
    }
    
    func update(imageCodeFile url: URL) {
        guard let projectFolder else { return }
        
        imageCodeFile = URLItem(url, projectFolder: projectFolder)
        
        _synchronize()
        
        scanImages(in: url)
    }
    
    func update(colorCodeFile url: URL) {
        guard let projectFolder else { return }
        
        colorCodeFile = URLItem(url, projectFolder: projectFolder)
        
        _synchronize()
    }
}

private extension ResourcesViewModel {
    func processAllAppearanceInfos() {
        self.rootNode = AppearanceNode(name: "root", path: "", isEditble: false)
        
        for appearanceFile in appearanceFiles {
            processAppearanceInfo(at: appearanceFile.fileURL)
        }
    }
    
    func processAppearanceInfo(at urlSource: URLItem) {
        do {
            let data = try Data(contentsOf: urlSource.url)
            
            guard let json = try JSONSerialization.jsonObject(with: data) as? [String: Any] else {
                return
            }
            
            try rootNode?.process(json: json, nodeName: colorRootName, id: urlSource.id, type: .color)
            try rootNode?.process(json: json, nodeName: imageRootName, id: urlSource.id, type: .image)
            
            var map: [String: String] = [:]
            
            func enumerate(node: AppearanceNode, key: String) {
                if let child = node.childMap[key] {
                    
                } else {
                    for (name, child) in node.childMap {
                        
                    }
                }
                
                for (name, child) in node.childMap {
                    if let children = node.children {
                        enumerate(node: child, key: key)
                    } else if let child = child as? ImageSourceNode {
                        map[child.name] = child.path
                    }
                }
            }
            
            enumerate(node: rootNode!, key: imageRootName)
        } catch {
            print("Failed to read appearance info from \(urlSource.url): \(error)")
        }
    }
    
    func scanImages(in folder: URL) {
        guard let files = try? FileManager.default.contentsOfDirectory(atPath: folder.filePath) else {
            return
        }
        
        var langFolderes: [URL] = []
        
        for file in files {
            
            let fileURL = folder.appendingPathComponent(file)
            var isDirectory: ObjCBool = false
            
            guard FileManager.default.fileExists(atPath: fileURL.filePath, isDirectory: &isDirectory) else {
                continue // Skip if the file does not exist
            }
                        
            if file.hasPrefix(".") {
                continue // Skip hidden files
            }
            
            if file.hasSuffix("imageset") {
                if let model = ImageInfoModel(imageAsset: fileURL) {
                    imageInfos.append(model)
                    imageMap[model.name] = model
                    
                    languages.formUnion(model.assetsImages.compactMap { $0.local })
                }
            } else if file.hasSuffix("lproj") {
                langFolderes.append(fileURL)
            } else if file.hasSuffix("png") || file.hasSuffix("jpg") || file.hasSuffix("jpeg") || file.hasSuffix("gif") {
                let model = ImageInfoModel(imageURL: fileURL)
                imageInfos.append(model)
                imageMap[model.name] = model
            } else if isDirectory.boolValue {
                scanImages(in: fileURL)
            }
        }
        
        if !langFolderes.isEmpty {
            let models = ImageInfoModel.searchImages(of: langFolderes, in: folder)
            for (name, model) in models {
                imageInfos.append(model)
                imageMap[name] = model
                
                if let langs = model.localizedInfo?.languages.compactMap({ $0.language }) {
                    languages.formUnion(langs)
                }
            }
        }
    }
}
