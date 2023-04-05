//
//  File.swift
//  
//
//  Created by Jo on 2023/4/4.
//

import Foundation

public extension Callable {
    /// 对单个换肤参数的更高一层的包装，用于记录当前入参的一些通用属性
    struct Appearanced<T> {
        /// 当前换肤参数的类型
        enum ClsType {
            /// 颜色类型参数
            case color
            /// 图片类型参数
            case image
            /// 其他类型参数
            case other
        }
        
        /// 缓存的原始参数值
        let original: Param<T>
        /// 换肤参数的标识符，用于从换肤资源中找到对应的换肤属性
        let identifier: AppearanceCallableIdentifier?
        /// 参数类型
        let clsType: ClsType
        
        /// 初始化方法
        /// - Parameter original: 原始的参数值
        init(original: Param<T>) {
            /// 获取原始值的换肤标识符和入参类型
            func getIdentifier() -> (AppearanceCallableIdentifier?, ClsType) {
                func idof(obj: Any?) -> (AppearanceCallableIdentifier?, ClsType) {
                    if let color = obj as? NSUIAppearanceColor {
                        return (color.appearanceIdentifier, .color)
                    }
                    
                    if let image = obj as? NSUIAppearanceImage {
                        return (image.appearanceIdentifier, .image)
                    }
                    
                    return ((obj as? AppearancedParamProtocol)?.appearanceIdentifier, .other)
                }
                
                switch original {
                case .required(let val): return idof(obj: val)
                case .optional(let val): return idof(obj: val)
                }
            }
            
            self.original = original
            
            (self.identifier, self.clsType) = getIdentifier()
        }
        
        /// 根据当前参数数据从换肤资源中获取对应有效的换肤数据
        var correct: Param<T> {
            /// 如果不支持换肤，返回原始值
            guard let identifier = identifier else {
                return original
            }
            
            /// 根据入参的类型返回对应的数据类型
            func appearancedValue(with searched: Any?) -> Param<T> {
                guard let searched = searched as? T else { return original }
                
                switch original {
                case .optional(_): return .optional(searched)
                case .required(_): return .required(searched)
                }
            }
            
            /// 返回其他类型的入参数据
            if clsType == .other {
                guard let info = try? Chameleon.shared.appearanceInfo(with: identifier) else {
                    return original
                }
                
                return appearancedValue(with: info)
            }
            
            /// 返回颜色类型的入参数据
            if clsType == .color {
                let appearancedVal = Chameleon.shared.color(with: identifier)
                return appearancedValue(with: appearancedVal)
            }
            
            /// 返回原始值
            return original
        }
        
        static func appearanced(_ original: Callable.Param<T>) -> Appearanced<T> {
            return Appearanced(original: original)
        }
    }
}
