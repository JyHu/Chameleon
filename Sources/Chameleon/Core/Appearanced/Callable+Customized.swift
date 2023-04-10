//
//  File.swift
//  
//
//  Created by Jo on 2023/4/10.
//

import Foundation

public extension Callable {
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
        
        public init(_ original: T, identifier: AppearanceCallableIdentifier?, converter: @escaping (Any?) -> T?) {
            self.original = original
            self.identifier = identifier
            self.converter = converter
        }
    }
}
