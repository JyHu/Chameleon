//
//  File.swift
//  
//
//  Created by Jo on 2023/4/11.
//

import Foundation

public extension Callable {
    struct MultImages: AppearancedProtocol {
        public typealias InputType = [NSUIAppearanceImage]
        
        public var original: [NSUIAppearanceImage]
        public let isAppearanced: Bool
        
        public var correct: [NSUIAppearanceImage] {
            if isAppearanced {
                return appearancedImages.map { $0.correct }
            }
            
            return original
        }
        
        private var appearancedImages: [Appearanced<NSUIAppearanceImage>] = []
        
        public init(original: [NSUIAppearanceImage]) {
            self.original = original
            
            appearancedImages = original.map { Appearanced($0) }
            isAppearanced = appearancedImages.contains { $0.isAppearanced }
        }
    }
}
