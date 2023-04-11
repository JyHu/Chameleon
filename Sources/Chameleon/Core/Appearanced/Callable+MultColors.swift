//
//  File.swift
//  
//
//  Created by Jo on 2023/4/10.
//

import Foundation

public extension Callable {
    struct MultColors: AppearancedProtocol {
        public typealias InputType = [NSUIAppearanceColor]

        public let original: [NSUIAppearanceColor]
        public let isAppearanced: Bool
        
        public var correct: [NSUIAppearanceColor] {
            if isAppearanced {
                return appearancedColors.map({ $0.correct })
            }
            
            return original
        }
        
        private var appearancedColors: [Appearanced<NSUIAppearanceColor>] = []
        
        public init(_ original: [NSUIAppearanceColor]) {
            self.original = original
            
            appearancedColors = original.map { Appearanced($0) }
            isAppearanced = appearancedColors.contains { $0.isAppearanced }
        }
    }
}
