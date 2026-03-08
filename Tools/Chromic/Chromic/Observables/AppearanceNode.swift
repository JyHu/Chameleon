//
//  AppearanceNode.swift
//  Chromic
//
//  Created by hujinyou on 2025/7/19.
//

import SwiftUI

class AppearanceNode: ObservableObject, Identifiable, CustomStringConvertible {
    /// 节点名称
    @Published var name: String
    /// 用于展示的节点名称，主要显示在 color、image 常量代码页面的 MARK 
    @Published var comment: String = ""
    
    /// 节点路径，从root节点到当前节点的路径
    @Published var path: String
    
    /// 子节点列表
    @Published var children: [AppearanceNode]?
    
    /// 子节点映射，方便通过名称快速查找子节点
    @Published var childMap: [String: AppearanceNode] = [:]
    
    let isEditble: Bool
    
    var id: String { path }
    
    init(name: String, path: String, isEditble: Bool = true, children: [AppearanceNode]? = nil) {
        self.name = name
        self.path = path
        self.isEditble = isEditble
        self.children = children
    }
    
    fileprivate func generateDescription(indent level: Int) -> String {
        if let children {
            return String(repeating: "    ", count: level) + name + "\n" +
            children.map { $0.generateDescription(indent: level + 1) }.joined(separator: "\n")
        } else {
            return String(repeating: "    ", count: level) + name
        }
    }
    
    var description: String {
        return generateDescription(indent: 0)
    }
    
    func add(child: AppearanceNode) {
        if children == nil {
            children = []
        }
        
        children?.append(child)
        childMap[child.name] = child
    }
    
    private func nodeOf(pathParts: [String], index: Int) -> AppearanceNode? {
        if index >= pathParts.count {
            return self
        }
        
        if let nextNode = childMap[pathParts[index]] {
            return nextNode.nodeOf(pathParts: pathParts, index: index + 1)
        }
        
        return nil
    }
    
    /// 后续可以把 ID 改为path，比如 a/b/c/d，可以直接目标节点
    func getNodeWithID(_ id: String) -> AppearanceNode? {
        let parts = id.split(separator: "/").map { String($0) }
        
        if parts.isEmpty {
            return self
        }
        
        return nodeOf(pathParts: parts, index: 0)
    }
    
    func getNodesWithIDs(_ ids: Set<String>) -> [AppearanceNode] {
        return ids.sorted(by: { $0 < $1 }).compactMap { getNodeWithID($0) }
    }
}

class ImageSourceNode: AppearanceNode {
    @Published private(set) var imageMap: [AppearanceFile.ID: String] = [:]
    
    init(name: String, imageName: String, parentPath: String, id: AppearanceFile.ID) {
        super.init(name: name, path: parentPath + "/" + name)
        self.imageMap = [id: imageName]
    }
    
    func cache(_ imageName: String, id: AppearanceFile.ID) {
        imageMap[id] = imageName
    }
    
    override func generateDescription(indent level: Int) -> String {
        return String(repeating: "    ", count: level) + name + "\n" +
        imageMap.map {  String(repeating: "    ", count: level + 1) + "\($0.key): \($0.value)" }.joined(separator: "\n")
    }
}

class ColorSourceNode: AppearanceNode {
    class ColorModel {
        var hexString: String
        var color: Color
        
        init(hexString: String) {
            self.hexString = hexString
            self.color = Color(hexString: hexString) ?? Color.white
        }
    }
    
    @Published var colorMap: [AppearanceFile.ID: ColorModel] = [:]
    
    init(name: String, colorValue: String, parentPath: String, id: AppearanceFile.ID) {
        super.init(name: name, path: parentPath + "/" + name)
        self.colorMap = [id: ColorModel(hexString: colorValue)]
    }
    
    func cache(_ colorValue: String, id: AppearanceFile.ID) {
        colorMap[id] = ColorModel(hexString: colorValue)
    }
    
    override func generateDescription(indent level: Int) -> String {
        return String(repeating: "    ", count: level) + name + "\n" +
        colorMap.map {  String(repeating: "    ", count: level + 1) + "\($0.key): \($0.value)" }.joined(separator: "\n")
    }
}

extension AppearanceNode {
    func process(json: [String: Any], nodeName: String, id: AppearanceFile.ID, type: AppearanceType) throws {
        guard let keyValues = json[nodeName] as? [String: Any] else {
            throw AppearanceError.emptyResource(nodeName)
        }
        
        if let rootNode = childMap[nodeName] {
            rootNode.process(keyValues, id: id, type: type)
        } else {
            let rootNode = AppearanceNode(name: nodeName, path: nodeName, isEditble: false)
            rootNode.process(keyValues, id: id, type: type)
            appendNode(rootNode)
            childMap[nodeName] = rootNode
        }
    }
}

private extension AppearanceNode {
    func appendNode(_ node: AppearanceNode) {
        if children == nil {
            children = []
        }
        
        children?.append(node)
        childMap[node.name] = node
    }
    
    func process(_ dict: [String: Any], id: AppearanceFile.ID, type: AppearanceType) {
        for (key, value) in dict {
            if let cachedNode = childMap[key] {
                if let value = value as? [String: Any] {
                    cachedNode.process(value, id: id, type: type)
                } else if let value = value as? String {
                    switch type {
                    case .image:
                        (cachedNode as? ImageSourceNode)?.cache(value, id: id)
                    case .color:
                        (cachedNode as? ColorSourceNode)?.cache(value, id: id)
                    }
                }
            } else {
                if let value = value as? [String: Any] {
                    let node = AppearanceNode(name: key, path: path + "/" + key)
                    node.process(value, id: id, type: type)
                    appendNode(node)
                } else if let value = value as? String {
                    switch type {
                    case .image:
                        appendNode(ImageSourceNode(name: key, imageName: value, parentPath: path, id: id))
                    case .color:
                        appendNode(ColorSourceNode(name: key, colorValue: value, parentPath: path, id: id))
                    }
                }
            }
        }
        
        children?.sort(by: { $0.name < $1.name })
    }
}
