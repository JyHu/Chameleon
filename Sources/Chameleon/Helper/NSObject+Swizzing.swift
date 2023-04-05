//
//  File.swift
//  
//
//  Created by Jo on 2023/4/3.
//

import Foundation

public extension NSObject {
    static func app_swizzing(originalSelector: Selector, newSelector: Selector) {
        if let originalMethod = class_getInstanceMethod(self, originalSelector),
           let swizedMethod = class_getInstanceMethod(self, newSelector) {
            method_exchangeImplementations(swizedMethod, originalMethod)
        }
    }
}