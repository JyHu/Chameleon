//
//  File.swift
//  
//
//  Created by Jo on 2023/4/4.
//


#if os(macOS)

import Cocoa

public extension NSTextView {
    var app_insertionPointColor: NSColor {
        set {
            cache(
                valA: .required(newValue),
                identifier: "NSTextView.__setInsertionPointColor(_:)",
                action: __setInsertionPointColor(_:)
            )
        }
        get {
            return insertionPointColor
        }
    }
    
    var app_backgroundColor: NSColor {
        set {
            cache(
                valA: .required(newValue),
                identifier: "NSTextView.__setBackgroundColor(_:)",
                action: __setBackgroundColor(_:)
            )
        }
        
        get {
            backgroundColor
        }
    }
    
    var app_textColor: NSColor? {
        set {
            cache(
                valA: .optional(newValue),
                identifier: "NSTextView.__setTextColor(_:)",
                action: __setTextColor(_:)
            )
        }
        get {
            textColor
        }
    }
}

internal extension NSTextView {
    static func silenceExchangeTextViewImplementation() {
        app_swizzing(
            originalSelector: #selector(setter: insertionPointColor),
            newSelector: #selector(swizzled_setInsertionPointColor(_:))
        )
        
        app_swizzing(
            originalSelector: #selector(setter: backgroundColor),
            newSelector: #selector(swizzled_setBackgroundColor(_:))
        )
        
        app_swizzing(
            originalSelector: #selector(setter: textColor),
            newSelector: #selector(swizzled_setTextColor(_:))
        )
        
    }
}

private extension NSTextView {
    func __setInsertionPointColor(_ insertionPointColor: Callable.Param<NSColor>) {
        if __USING_SWIZZING__ {
            swizzled_setInsertionPointColor(insertionPointColor.requiredValue)
        } else {
            self.insertionPointColor = insertionPointColor.requiredValue
        }
    }
    
    func __setBackgroundColor(_ backgroundColor: Callable.Param<NSColor>) {
        if __USING_SWIZZING__ {
            swizzled_setBackgroundColor(backgroundColor.requiredValue)
        } else {
            self.backgroundColor = backgroundColor.requiredValue
        }
    }
    
    func __setTextColor(_ textColor: Callable.Param<NSColor>) {
        if __USING_SWIZZING__ {
            swizzled_setTextColor(textColor.optionalValue)
        } else {
            self.textColor = textColor.optionalValue
        }
    }
    
    @objc func swizzled_setInsertionPointColor(_ insertionPointColor: NSColor) {
        cache(
            valA: .required(insertionPointColor),
            identifier: "NSTextView.__setInsertionPointColor(_:)",
            action: __setInsertionPointColor(_:)
        )
    }
    
    @objc func swizzled_setBackgroundColor(_ backgroundColor: NSColor) {
        cache(
            valA: .required(backgroundColor),
            identifier: "NSTextView.__setBackgroundColor(_:)",
            action: __setBackgroundColor(_:)
        )
    }
    
    @objc func swizzled_setTextColor(_ textColor: NSColor?) {
        cache(
            valA: .optional(textColor),
            identifier: "NSTextView.__setTextColor(_:)",
            action: __setTextColor(_:)
        )
    }
}

#endif
