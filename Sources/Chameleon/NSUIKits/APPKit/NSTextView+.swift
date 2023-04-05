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
                valA: newValue,
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
                valA: newValue,
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
            if let newValue {
                cache(
                    valA: newValue,
                    identifier: "NSTextView.__setTextColor(_:)",
                    action: __setTextColor(_:)
                )
            } else {
                __setTextColor(nil)
            }
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
    func __setInsertionPointColor(_ insertionPointColor: NSColor) {
        if __USING_SWIZZING__ {
            swizzled_setInsertionPointColor(insertionPointColor)
        } else {
            self.insertionPointColor = insertionPointColor
        }
    }
    
    func __setBackgroundColor(_ backgroundColor: NSColor) {
        if __USING_SWIZZING__ {
            swizzled_setBackgroundColor(backgroundColor)
        } else {
            self.backgroundColor = backgroundColor
        }
    }
    
    func __setTextColor(_ textColor: NSColor?) {
        if __USING_SWIZZING__ {
            swizzled_setTextColor(textColor)
        } else {
            self.textColor = textColor
        }
    }
    
    @objc func swizzled_setInsertionPointColor(_ insertionPointColor: NSColor) {
        cache(
            valA: insertionPointColor,
            identifier: "NSTextView.__setInsertionPointColor(_:)",
            action: __setInsertionPointColor(_:)
        )
    }
    
    @objc func swizzled_setBackgroundColor(_ backgroundColor: NSColor) {
        cache(
            valA: backgroundColor,
            identifier: "NSTextView.__setBackgroundColor(_:)",
            action: __setBackgroundColor(_:)
        )
    }
    
    @objc func swizzled_setTextColor(_ textColor: NSColor?) {
        guard let textColor = textColor else { return }
        cache(
            valA: textColor,
            identifier: "NSTextView.__setTextColor(_:)",
            action: __setTextColor(_:)
        )
    }
}

#endif
