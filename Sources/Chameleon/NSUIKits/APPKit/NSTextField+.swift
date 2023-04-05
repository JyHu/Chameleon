//
//  File.swift
//  
//
//  Created by Jo on 2023/4/4.
//


#if os(macOS)

import Cocoa

public extension NSTextField {
    var app_backgroundColor: NSColor? {
        set {
            cache(
                valA: .optional(newValue),
                identifier: "NSTextField.__setBackGroundColor(_:)",
                action: __setBackGroundColor(_:)
            )
        }
        get {
            return backgroundColor
        }
    }
    
    var app_textColor: NSColor? {
        set {
            cache(
                valA: .optional(newValue),
                identifier: "NSTextField.__setTextColor(_:)",
                action: __setTextColor(_:)
            )
        }
        get {
            return textColor
        }
    }
}

internal extension NSTextField {
    static func silenceExchangeTextFieldImplementation() {
        app_swizzing(
            originalSelector: #selector(setter: backgroundColor),
            newSelector: #selector(swizzled_setBackGroundColor(_:))
        )
        
        app_swizzing(
            originalSelector: #selector(setter: textColor),
            newSelector: #selector(swizzled_setTextColor(_:))
        )
    }
}

private extension NSTextField {
    func __setBackGroundColor(_ backgroundColor: Callable.Param<NSColor>) {
        if __USING_SWIZZING__ {
            swizzled_setBackGroundColor(backgroundColor.optionalValue)
        } else {
            self.backgroundColor = backgroundColor.optionalValue
        }
    }
    
    func __setTextColor(_ textColor: Callable.Param<NSColor>) {
        if __USING_SWIZZING__ {
            swizzled_setTextColor(textColor.optionalValue)
        } else {
            self.textColor = textColor.optionalValue
        }
    }
    
    @objc func swizzled_setBackGroundColor(_ backgroundColor: NSColor?) {
        cache(
            valA: .optional(backgroundColor),
            identifier: "NSTextField.__setBackGroundColor(_:)",
            action: __setBackGroundColor(_:)
        )
    }
    
    @objc func swizzled_setTextColor(_ textColor: NSColor?) {
        cache(
            valA: .optional(textColor),
            identifier: "NSTextField.__setTextColor(_:)",
            action: __setTextColor(_:)
        )
    }
}

#endif
