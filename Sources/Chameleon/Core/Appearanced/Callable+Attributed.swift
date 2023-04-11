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
    /// 该类支持富文本换肤属性的换肤支持
    ///
    ///
    struct Attributed<T>: AppearancedProtocol {
        public typealias InputType = T
        
        public let original: T
        
        private let elements: [NSAttributedString.ColorElement]
        
        public var isAppearanced: Bool { elements.count > 0 }
        
        public var correct: T {
            ((original as? NSAttributedString)?.updateAppearancedValues(elements) as? T) ?? original
        }
    }
}

public extension Callable.Attributed where T == NSAttributedString {
    init(_ original: T) {
        self.original = original
        self.elements = original.colorAppearancedElements()
    }
}

public extension Callable.Attributed where T == NSAttributedString? {
    init(_ original: T) {
        self.original = original
        self.elements = original?.colorAppearancedElements() ?? []
    }
}
