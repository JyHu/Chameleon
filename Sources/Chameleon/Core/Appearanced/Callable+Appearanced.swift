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
        
        init(obj: Any) {
            if obj is NSUIAppearanceColor { self = .color }
            else if obj is NSUIAppearanceImage { self = .image }
            else if obj is Int { self = .numeric(.int) }
            else if obj is Int8 { self = .numeric(.int8) }
            else if obj is Int16 { self = .numeric(.int16) }
            else if obj is Int32 { self = .numeric(.int32) }
            else if obj is Int64 { self = .numeric(.int64) }
            else if obj is UInt { self = .numeric(.uint) }
            else if obj is UInt8 { self = .numeric(.uint8) }
            else if obj is UInt16 { self = .numeric(.uint16) }
            else if obj is UInt32 { self = .numeric(.uint32) }
            else if obj is UInt64 { self = .numeric(.uing64) }
            else if obj is Double { self = .numeric(.double) }
            else if obj is CGFloat { self = .numeric(.cgfloat) }
            else if obj is NSNumber { self = .numeric(.number) }
            else { self = .other }
        }
    }
    
    /// 对单个换肤参数的更高一层的包装，用于记录当前入参的一些通用属性
    ///
    ///
    /// 该类支持Color、Image、常用数值类型的换肤属性支持
    ///
    ///
    struct Appearanced<T>: AppearancedProtocol {
        public typealias InputType = T
        
        /// 缓存的原始参数值
        public let original: T
        /// 换肤参数的标识符，用于从换肤资源中找到对应的换肤属性
        public let identifier: AppearanceCallableIdentifier?
        /// 参数类型
        public let clsType: ClsType
        /// 是否是支持换肤的属性
        public var isAppearanced: Bool {
            identifier != nil
        }
        
        /// 初始化方法
        /// - Parameter original: 原始的参数值
        public init(_ original: T) {
            self.original = original
            self.identifier = (original as? AppearancedParamProtocol)?.appearanceIdentifier
            self.clsType = ClsType(obj: original)
        }
        
        public init(_ original: T, identifier: AppearanceCallableIdentifier?, clsType: ClsType? = nil) {
            self.original = original
            self.identifier = identifier
            if let clsType = clsType {
                self.clsType = clsType
            } else {
                self.clsType = ClsType(obj: original)
            }
        }
        
        /// 根据当前参数数据从换肤资源中获取对应有效的换肤数据
        public var correct: T {
            /// 如果不支持换肤，返回原始值
            guard let identifier = identifier else { return original }
            
            func pickup(_ object: Any?) -> T {
                guard let object = object else { return original }
                return (object as? T) ?? original
            }
            
            switch clsType {
            case .color: return pickup(AppearanceManager.shared.color(with: identifier))
            case .image: return pickup(AppearanceManager.shared.image(with: identifier))
            case .numeric(let numType):
                let numVal = (try? AppearanceManager.shared.appearanceInfo(with: identifier))
                let matchedRes: T? = matchedAppearancedNumValue(from: numVal, of: numType)
                return matchedRes ?? original
            case .other: return pickup(try? AppearanceManager.shared.appearanceInfo(with: identifier))
            }
        }
    }
}
