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
            if let newValue = newValue {
                cache(
                    valA: newValue,
                    identifier: "NSText.__text_setTextColor(_:)",
                    action: __text_setTextColor(_:)
                )
            } else {
                __text_setTextColor(nil)
            }
        }
        get { textColor }
    }
    
    var app_text_backgroundColor: NSColor? {
        set {
            if let newValue = newValue {
                cache(
                    valA: newValue,
                    identifier: "NSText.__text_setBackgroundColor(_:)",
                    action: __text_setBackgroundColor(_:)
                )
            } else {
                __text_setBackgroundColor(nil)
            }
        }
        get { backgroundColor }
    }
    
    func app_setTextColor(_ color: NSColor?, range: NSRange) {
        if let color = color {
            cache(
                valA: color,
                valB: range,
                identifier: "NSText.__setTextColor(_:range:)",
                action: __setTextColor(_:range:)
            )
        } else {
            __setTextColor(nil, range: range)
        }
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
    
    func __text_setTextColor(_ textColor: NSColor?) {
        if __USING_SWIZZING__ {
            swizzled_text_setTextColor(textColor)
        } else {
            self.textColor = textColor
        }
    }
    
    func __text_setBackgroundColor(_ backgroundColor: NSColor?) {
        if __USING_SWIZZING__ {
            swizzled_text_setBackgroundColor(backgroundColor)
        } else {
            self.backgroundColor = backgroundColor
        }
    }
    
    func __setTextColor(_ color: NSColor?, range: NSRange) {
        if __USING_SWIZZING__ {
            swizzled_setTextColor(color, range: range)
        } else {
            setTextColor(color, range: range)
        }
    }
    
    
    @objc func swizzled_text_setTextColor(_ textColor: NSColor?) {
        guard let textColor = textColor else { return }
        cache(
            valA: textColor,
            identifier: "NSText.__text_setTextColor(_:)",
            action: __text_setTextColor(_:)
        )
    }
    
    @objc func swizzled_text_setBackgroundColor(_ backgroundColor: NSColor?) {
        guard let backgroundColor = backgroundColor else { return }
        cache(
            valA: backgroundColor,
            identifier: "NSText.__text_setBackgroundColor(_:)",
            action: __text_setBackgroundColor(_:)
        )
    }
    
    @objc func swizzled_setTextColor(_ color: NSColor?, range: NSRange) {
        guard let color = color else { return }
        cache(
            valA: color,
            valB: range,
            identifier: "NSText.__setTextColor(_:range:)",
            action: __setTextColor(_:range:)
        )
    }
}

#endif
