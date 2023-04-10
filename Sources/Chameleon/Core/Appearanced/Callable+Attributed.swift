//
//  File.swift
//  
//
//  Created by Jo on 2023/4/10.
//

import Foundation

public extension Callable {
    struct Attributed: AppearancedProtocol {
        
        public let original: NSAttributedString
        
        private let elements: [NSAttributedString.ColorElement]
        
        public var isAppearanced: Bool { elements.count > 0 }
        
        public var correct: NSAttributedString {
            original.updateAppearancedValues(elements)
        }
        
        public init(_ original: NSAttributedString) {
            self.original = original
            self.elements = original.colorAppearancedElements()
        }
    }
}
