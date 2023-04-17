//
//  File.swift
//  
//
//  Created by Jo on 2023/4/10.
//

import Foundation

public extension Callable {
    ///
    ///
    ///
    ///
    /// 用于处理自定义的数据类型
    ///
    ///
    ///
    /// 
    struct Customized<T>: AppearancedProtocol {
        
        public typealias InputType = T

        public let original: T
        public let identifier: AppearanceCallableIdentifier?
        public let isAppearanced: Bool = true
        
        public var correct: T {
            guard let identifier = identifier else { return original }
            return converter(try? AppearanceManager.shared.appearanceInfo(with: identifier)) ?? original
        }
        
        private var converter: (Any?) -> T?
        
        /// 初始化方法
        /// - Parameters:
        ///   - original: 原始值
        ///   - identifier: 当前自定义富文本的换肤资源ID
        ///   - converter: 转换方法，将主题资源中的数据转换为对应的有效皮肤信息
        public init(_ original: T, identifier: AppearanceCallableIdentifier?, converter: @escaping (Any?) -> T?) {
            self.original = original
            self.identifier = identifier
            self.converter = converter
        }
    }
}
