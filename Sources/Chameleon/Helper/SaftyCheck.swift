//
//  File.swift
//
//
//  Created by Jo on 2024/1/25.
//

import Foundation

/// 用于比较的资源信息结构体
public struct CheckableAppearanceInfo {
    /// 资源的标识符，用于在检查出错时确定是哪个文件
    public let identifier: String
    
    /// 需要比较的资源内容
    public let appearanceInfos: [String: Any]
    
    /// 初始化方法，用于创建一个资源比较的对象
    public init(identifier: String, appearanceInfos: [String : Any]) {
        self.identifier = identifier
        self.appearanceInfos = appearanceInfos
    }
    
    /// 从文件URL初始化，读取文件内容并转换为字典
    /// - Parameters:
    ///   - identifier: 资源的标识符
    ///   - fileURL: 文件URL
    public init(identifier: String, fileURL: URL) {
        self.identifier = identifier
        
        // 检查文件是否存在
        guard FileManager.default.fileExists(atPath: fileURL.path) else {
            self.appearanceInfos = [:]
            return
        }
        
        // 读取文件数据并尝试解析为字典
        guard let data = try? Data(contentsOf: fileURL),
              let json = try? JSONSerialization.jsonObject(with: data) as? [String: Any] else {
                  self.appearanceInfos = [:]
                  return
              }
        
        self.appearanceInfos = json
    }
}

/// 表示可能的比较错误的枚举
public enum CheckedAppearanceError: Error, CustomStringConvertible {
    /// 传入的资源为空
    case emptyFile(_ identifier: String)
    
    /// 缺少对应路径下的键
    case missingKey(_ identifier: String, _ path: String)
    
    /// 资源类型不匹配
    case notMatched(_ path: String)
    
    /// 描述输出内容
    public var description: String {
        switch self {
        case .emptyFile(let identifier):
            return "Empty file of \(identifier)"
        case .missingKey(let identifier, let path):
            return "Missing key of \(identifier) at \(path)"
        case .notMatched(let path):
            return "Appearance info not matched at \(path)"
        }
    }
}

/// 对外暴露的比较函数，接受一个资源信息数组，返回比较结果的错误数组
/// - Parameter infos: 资源信息数组
/// - Returns: 比较结果的错误数组
public func checkAppearanceInfos(_ infos: [CheckableAppearanceInfo]) -> [CheckedAppearanceError] {
    // 至少需要两个资源进行比较
    guard infos.count > 1 else { return [] }
    
    for info in infos {
        // 检查每个资源是否为空文件
        if info.appearanceInfos.isEmpty {
            return [.emptyFile(info.identifier)]
        }
    }
    
    // 调用辅助函数进行比较
    return _checkAppearanceInfos(infos, path: "")
}

/// 辅助函数，用于递归比较资源信息
/// - Parameters:
///   - infos: 资源信息数组
///   - path: 当前比较的路径
/// - Returns: 比较结果的错误数组
private func _checkAppearanceInfos(_ infos: [CheckableAppearanceInfo], path: String) -> [CheckedAppearanceError] {
    // 初始化所有键的集合
    var allKeys: Set<String> = Set(infos[0].appearanceInfos.keys)
    var errors: [CheckedAppearanceError] = []

    // 计算所有资源的键的并集
    for checkedInfo in infos[1...] {
        allKeys.formUnion(checkedInfo.appearanceInfos.keys)
    }
    
    // 逐个比较键
    for key in allKeys {
        let curPath = path.isEmpty ? key : (path + "/" + key)
        var isValue: Bool = false
        var containsError: Bool = false
        var nextLevleInfos: [CheckableAppearanceInfo] = []
        
        // 遍历每个资源
        for (index, checkedInfo) in infos.enumerated() {
            // 检查键是否存在
            guard let checkedValue = checkedInfo.appearanceInfos[key] else {
                containsError = true
                errors.append(.missingKey(checkedInfo.identifier, curPath))
                continue
            }
            
            // 如果已经包含错误，跳过后续逻辑，这样的做法只会记录检查键值存在的问题，而不会再匹配数据的一致性
            guard !containsError else { continue }
            
            // 根据值的类型进行不同处理
            if let checkedChildren = checkedValue as? [String: Any] {
                nextLevleInfos.append(CheckableAppearanceInfo(identifier: checkedInfo.identifier, appearanceInfos: checkedChildren))
                
                // 判断是否是第一个资源
                if index == 0 {
                    isValue = false
                } else if isValue {
                    containsError = true
                    errors.append(.notMatched(curPath))
                }
            } else {
                // 判断是否是第一个资源
                if index == 0 {
                    isValue = true
                } else if !isValue {
                    containsError = true
                    errors.append(.notMatched(curPath))
                }
            }
        }
        
        // 如果没有包含错误且不是值类型，递归调用进行下一层比较
        if !containsError && !isValue {
            errors.append(contentsOf: _checkAppearanceInfos(nextLevleInfos, path: curPath))
        }
    }
    
    return errors
}
