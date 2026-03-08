//
//  File.swift
//  
//
//  Created by Jo on 2023/4/3.
//

#if os(macOS)
import Cocoa
#else
import UIKit
#endif

/// 换肤资源附加标识符的协议，用于唯一的标识这个属性，并用于从换肤资源中找到对应的源数据
public protocol AppearancedParamProtocol: NSObjectProtocol {
    var appearanceIdentifier: AppearanceCallableIdentifier? { get }
    func cleared() -> Self
}

private struct __AssociationKey {
    static var appearanceIdentifierKey: Int = 0
}

public extension AppearancedParamProtocol {
    /// 当前对象的唯一标识符，用于在主题文件中找到对应的唯一属性值
    private(set) var appearanceIdentifier: AppearanceCallableIdentifier? {
        set {
            objc_setAssociatedObject(self, &__AssociationKey.appearanceIdentifierKey, newValue, .OBJC_ASSOCIATION_COPY_NONATOMIC)
        }
        get {
            return objc_getAssociatedObject(self, &__AssociationKey.appearanceIdentifierKey) as? AppearanceCallableIdentifier
        }
    }

    /// 一个中转方法，用于给一个对象添加一个标识符
    /// - Parameter identifier: 换肤的标识符
    /// - Returns: 原对象
    func withAppearanceIdentifier(_ identifier: AppearanceCallableIdentifier) -> Self {
        self.appearanceIdentifier = identifier
        return self
    }
    
    func cleared() -> Self {
        appearanceIdentifier = nil
        return self
    }
}

extension NSUIAppearanceColor: AppearancedParamProtocol { }

extension NSUIAppearanceImage: AppearancedParamProtocol { }
