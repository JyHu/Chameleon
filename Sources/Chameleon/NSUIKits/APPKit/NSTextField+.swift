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
            if let newValue {
                cache(
                    valA: newValue,
                    identifier: "NSTextField.__setBackGroundColor(_:)",
                    action: __setBackGroundColor(_:)
                )
            } else {
                __setBackGroundColor(nil)
            }
        }
        get {
            return backgroundColor
        }
    }
    
    var app_textColor: NSColor? {
        set {
            if let newValue {
                cache(
                    valA: newValue,
                    identifier: "NSTextField.__setTextColor(_:)",
                    action: __setTextColor(_:)
                )
            } else {
                __setTextColor(nil)
            }
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
    func __setBackGroundColor(_ backgroundColor: NSColor?) {
        if __USING_SWIZZING__ {
            swizzled_setBackGroundColor(backgroundColor)
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
    
    @objc func swizzled_setBackGroundColor(_ backgroundColor: NSColor?) {
        guard let backgroundColor = backgroundColor else { return }
        cache(
            valA: backgroundColor,
            identifier: "NSTextField.__setBackGroundColor(_:)",
            action: __setBackGroundColor(_:)
        )
    }
    
    @objc func swizzled_setTextColor(_ textColor: NSColor?) {
        guard let textColor = textColor else { return }
        cache(
            valA: textColor,
            identifier: "NSTextField.__setTextColor(_:)",
            action: __setTextColor(_:)
        )
    }
}

#endif
