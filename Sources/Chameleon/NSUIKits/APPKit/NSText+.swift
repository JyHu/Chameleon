//
//  File.swift
//  
//
//  Created by Jo on 2023/4/2.
//

#if os(macOS)
import Cocoa

public extension NSText {
    var app_text_textColor: NSColor? {
        set {
            cache(
                valA: .optional(newValue),
                identifier: "NSText.__text_setTextColor(_:)",
                action: __text_setTextColor(_:)
            )
        }
        get { textColor }
    }
    
    var app_text_backgroundColor: NSColor? {
        set {
            cache(
                valA: .optional(newValue),
                identifier: "NSText.__text_setBackgroundColor(_:)",
                action: __text_setBackgroundColor(_:)
            )
        }
        get { backgroundColor }
    }
    
    func app_setTextColor(_ color: NSColor?, range: NSRange) {
        cache(
            valA: .optional(color),
            valB: .required(range),
            identifier: "NSText.__setTextColor(_:range:)",
            action: __setTextColor(_:range:)
        )
    }
    
}

internal extension NSText {
    static func silenceExchangeTextImplementation() {
        app_swizzing(
            originalSelector: #selector(setter: textColor),
            newSelector: #selector(swizzled_text_setTextColor(_:))
        )
        
        app_swizzing(
            originalSelector: #selector(setter: backgroundColor),
            newSelector: #selector(swizzled_text_setBackgroundColor(_:))
        )
        
        app_swizzing(
            originalSelector: #selector(setTextColor(_:range:)),
            newSelector: #selector(swizzled_setTextColor(_:range:))
        )
    }
}

private extension NSText {
    
    func __text_setTextColor(_ textColor: Callable.Param<NSColor>) {
        if __USING_SWIZZING__ {
            swizzled_text_setTextColor(textColor.optionalValue)
        } else {
            self.textColor = textColor.optionalValue
        }
    }
    
    func __text_setBackgroundColor(_ backgroundColor: Callable.Param<NSColor>) {
        if __USING_SWIZZING__ {
            swizzled_text_setBackgroundColor(backgroundColor.optionalValue)
        } else {
            self.backgroundColor = backgroundColor.optionalValue
        }
    }
    
    func __setTextColor(_ color: Callable.Param<NSColor>, range: Callable.Param<NSRange>) {
        if __USING_SWIZZING__ {
            swizzled_setTextColor(color.optionalValue, range: range.requiredValue)
        } else {
            setTextColor(color.optionalValue, range: range.requiredValue)
        }
    }
    
    
    
    @objc func swizzled_text_setTextColor(_ textColor: NSColor?) {
        cache(
            valA: .optional(textColor),
            identifier: "NSText.__text_setTextColor(_:)",
            action: __text_setTextColor(_:)
        )
    }
    
    @objc func swizzled_text_setBackgroundColor(_ backgroundColor: NSColor?) {
        cache(
            valA: .optional(backgroundColor),
            identifier: "NSText.__text_setBackgroundColor(_:)",
            action: __text_setBackgroundColor(_:)
        )
    }
    
    @objc func swizzled_setTextColor(_ color: NSColor?, range: NSRange) {
        cache(
            valA: .optional(color),
            valB: .required(range),
            identifier: "NSText.__setTextColor(_:range:)",
            action: __setTextColor(_:range:)
        )
    }
}

#endif
