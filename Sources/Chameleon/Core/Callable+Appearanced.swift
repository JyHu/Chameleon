//
//  File.swift
//  
//
//  Created by Jo on 2023/4/4.
//

import Foundation

public extension Callable {
    /// 数值类型
    enum NumType {
        case int
        case int8
        case int16
        case int32
        case int64
        
        case uint
        case uint8
        case uint16
        case uint32
        case uing64
        
        case double
        case cgfloat
        
        case number
    }
    
    /// 当前换肤参数的类型
    enum ClsType {
        /// 颜色类型参数
        case color
        /// 图片类型参数
        case image
        /// 数值类型
        case numeric(NumType)
        /// 其他类型参数
        case other
    }
    
    /// 判断给定数据的类型
    private static func clsTypeOf(obj: Any) -> ClsType {
        if obj is NSUIAppearanceColor { return .color }
        if obj is NSUIAppearanceImage { return .image }
        
        if obj is Int { return .numeric(.int) }
        if obj is Int8 { return .numeric(.int8)}
        if obj is Int16 { return .numeric(.int16)}
        if obj is Int32 { return .numeric(.int32)}
        if obj is Int64 { return .numeric(.int64)}
        if obj is UInt { return .numeric(.uint)}
        if obj is UInt8 { return .numeric(.uint8)}
        if obj is UInt16 { return .numeric(.uint16)}
        if obj is UInt32 { return .numeric(.uint32)}
        if obj is UInt64 { return .numeric(.uing64)}
        if obj is Double { return .numeric(.double)}
        if obj is CGFloat { return .numeric(.cgfloat)}
        if obj is NSNumber { return .numeric(.number)}
        
        return .other
    }
    
    /// 对单个换肤参数的更高一层的包装，用于记录当前入参的一些通用属性
    struct Appearanced<T> {
        /// 缓存的原始参数值
        public let original: T
        /// 换肤参数的标识符，用于从换肤资源中找到对应的换肤属性
        public let identifier: AppearanceCallableIdentifier?
        /// 参数类型
        public let clsType: ClsType
        
        /// 初始化方法
        /// - Parameter original: 原始的参数值
        public init(original: T) {
            self.original = original
            self.identifier = (original as? AppearancedParamProtocol)?.appearanceIdentifier
            self.clsType = Callable.clsTypeOf(obj: original)
        }
        
        public init(original: T, identifier: AppearanceCallableIdentifier?, clsType: ClsType? = nil) {
            self.original = original
            self.identifier = identifier
            self.clsType = clsType ?? Callable.clsTypeOf(obj: original)
        }
        
        /// 根据当前参数数据从换肤资源中获取对应有效的换肤数据
        public var correct: T {
            /// 如果不支持换肤，返回原始值
            guard let identifier = identifier else { return original }
            
            switch clsType {
            case .color: return Chameleon.shared.color(with: identifier) as? T ?? original
            case .image: return Chameleon.shared.image(with: identifier) as? T ?? original
            case .numeric(let numType):
                let numVal = (try? Chameleon.shared.appearanceInfo(with: identifier))
                return matchedAppearancedNumValue(from: numVal, of: numType) ?? original
            case .other: return (try? Chameleon.shared.appearanceInfo(with: identifier)) as? T ?? original
            }
        }
        
        public static func appearanced(_ original: T) -> Appearanced<T> {
            return Appearanced(original: original)
        }
        
        public static func appearanced(_ original: T, identifier: AppearanceCallableIdentifier?, clsType: ClsType? = nil) -> Appearanced<T> {
            return Appearanced(original: original, identifier: identifier, clsType: clsType)
        }
    }
}
