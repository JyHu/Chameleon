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
    /// 过渡的中间类，不需要执行换肤操作的
    ///
    ///
    ///
    struct Original<T>: AppearancedProtocol {
        public typealias InputType = T

        public var original: InputType
        
        public var isAppearanced: Bool { false }
        
        public var correct: InputType { original }
        
        public init(_ original: InputType) {
            self.original = original
        }
    }
}
