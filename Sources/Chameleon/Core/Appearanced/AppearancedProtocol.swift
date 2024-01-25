//
//  File.swift
//  
//
//  Created by Jo on 2023/4/10.
//

import Foundation

///
/// 每一个换肤属性持有者都必须要遵守的协议
///
public protocol AppearancedProtocol {
    
    /// 缓存当前入参的数据类型
    associatedtype InputType
    
    /// 缓存的原始参数值
    var original: InputType { get }
    
    /// 是否是支持换肤的属性
    var isAppearanced: Bool { get }
    
    /// 根据当前参数数据从换肤资源中获取对应有效的换肤数据
    var correct: InputType { get }
}
