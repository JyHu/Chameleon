//
//  File.swift
//  
//
//  Created by Jo on 2023/4/3.
//

import Foundation

/// 换肤资源附加标识符的协议，用于唯一的标识这个属性，并用于从换肤资源中找到对应的源数据
public protocol AppearancedParamProtocol {
    var appearanceIdentifier: AppearanceCallableIdentifier? { get }
}

extension NSObject: AppearancedParamProtocol {
    
    private struct AssociationKey {
        static var appearanceIdentifierKey = "com.auu.chameleon.association.appearanceIdentifier"
    }
    
    /// 当前对象的唯一标识符，用于在主题文件中找到对应的唯一属性值
    public private(set) var appearanceIdentifier: AppearanceCallableIdentifier? {
        set {
            objc_setAssociatedObject(self, &AssociationKey.appearanceIdentifierKey, newValue, .OBJC_ASSOCIATION_COPY_NONATOMIC)
        }
        get {
            return objc_getAssociatedObject(self, &AssociationKey.appearanceIdentifierKey) as? AppearanceCallableIdentifier
        }
    }
    
    /// 一个中转方法，用于给一个对象添加一个标识符
    /// - Parameter identifier: 换肤的标识符
    /// - Returns: 原对象
    public func withAppearanceIdentifier(_ identifier: AppearanceCallableIdentifier) -> Self {
        appearanceIdentifier = identifier
        return self
    }
}
