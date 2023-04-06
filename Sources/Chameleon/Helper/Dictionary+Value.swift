//
//  File.swift
//  
//
//  Created by Jo on 2023/4/2.
//

import Foundation
 
public extension Dictionary where Key == String {
    
    /// 根据给定的属性标识符，获取对应的属性信息
    /// 遍历方式是类似于文件路径，一级一级的查找，如：
    ///     image/background/xxxxxx
    /// 会从当前字典中一层一层的查找
    ///
    /// - Parameter identifier: 属性标识符
    /// - Returns: 换肤资源信息
    func appearanceInfo(with identifier: AppearanceCallableIdentifier) throws -> Any? {
        if !identifier.contains("/") {
            return self[identifier]
        }
        
        let pathComponents = identifier.components(separatedBy: "/")
        return try appearanceInfo(pathComponents: pathComponents, originalIdentifier: identifier)
    }
    
    private func appearanceInfo(at index: Int = 0, pathComponents: [String], originalIdentifier: AppearanceCallableIdentifier) throws -> Any? {
        guard index < pathComponents.count else {
            throw APPError.parseIndexError(originalIdentifier, index)
        }
        
        let key = pathComponents[index]
        
        guard let curObj = self[key] else {
            return nil
        }
        
        if index == pathComponents.count - 1 {
            return curObj
        }
        
        guard let curObj = curObj as? [String: Any] else {
            throw APPError.unknownAppearanceInfo(curObj)
        }
        
        
        return try curObj.appearanceInfo(at: index + 1, pathComponents: pathComponents, originalIdentifier: originalIdentifier)
    }
}
