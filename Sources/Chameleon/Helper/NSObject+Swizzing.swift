//
//  File.swift
//  
//
//  Created by Jo on 2023/4/3.
//

import Foundation

public extension NSObject {
    ///
    /// Runtime method swizzling
    ///
    static func app_swizzling(originalSelector: Selector, newSelector: Selector) {
        if let originalMethod = class_getInstanceMethod(self, originalSelector),
           let swizedMethod = class_getInstanceMethod(self, newSelector) {
            method_exchangeImplementations(swizedMethod, originalMethod)
        }
    }
}
