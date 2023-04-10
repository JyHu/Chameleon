//
//  File.swift
//  
//
//  Created by Jo on 2023/4/10.
//

import Foundation

public extension Callable {
    struct Mediator<T>: AppearancedProtocol {
        public typealias InputType = T

        public var original: InputType
        
        public var isAppearanced: Bool { false }
        
        public var correct: InputType { original }
        
        public init(_ original: InputType) {
            self.original = original
        }
    }
}
