//
//  File.swift
//  
//
//  Created by Jo on 2023/4/2.
//

#if os(macOS)
import Cocoa
#else
import UIKit
#endif

public extension Callable {
    /// 对原始的入参数据做下包装，用于记录数据类型是可选值还是非可选值
    enum Param<T> {
        /// 必选值
        case `required`(T)
        /// 可选值
        case `optional`(T?)
        
        /// 必选值包含的数据
        var requiredValue: T {
            switch self {
            case .required(let val): return val
            default: fatalError()
            }
        }
        
        /// 可选值包含的数据
        var optionalValue: T? {
            switch self {
            case .optional(let val): return val
            default: fatalError()
            }
        }
        
        var appearanced: Bool {
            switch self {
            case .required(let val): return (val as? AppearancedParamProtocol)?.appearanceIdentifier != nil
            case .optional(let val): return (val as? AppearancedParamProtocol)?.appearanceIdentifier != nil
            }
        }
    }
}
