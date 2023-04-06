//
//  File.swift
//  
//
//  Created by Jo on 2023/4/4.
//

#if os(macOS)
import Cocoa
#elseif canImport(UIKit)
import UIKit
#endif

var __USING_APPEARANCED_SWIZZING__: Bool { AppearanceManager.shared.usingSwizzing }

public extension AppearanceManager {
    static func exchangeImplementations() {
        shared.useSwizzing()
        
        #if os(macOS)
        NSBox.silenceExchangeBoxImplementation()
        NSText.silenceExchangeTextImplementation()
        NSTextField.silenceExchangeTextFieldImplementation()
        NSTextView.silenceExchangeTextViewImplementation()
        #elseif canImport(UIKit)
        
        #endif
    }
}
