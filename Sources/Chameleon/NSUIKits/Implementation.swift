//
//  File.swift
//  
//
//  Created by Jo on 2023/4/4.
//

#if os(macOS)

import Cocoa

var __USING_SWIZZING__: Bool { Chameleon.shared.usingSwizzing }

public extension Chameleon {
    static func exchangeImplementations() {
        shared.useSwizzing()
        
        NSBox.silenceExchangeBoxImplementation()
        NSText.silenceExchangeTextImplementation()
        NSTextField.silenceExchangeTextFieldImplementation()
        NSTextView.silenceExchangeTextViewImplementation()
    }
}

#endif
