//
//  File.swift
//  
//
//  Created by Jo on 2023/4/6.
//

#if os(macOS)

import Cocoa

private extension AppearanceCallableIdentifier {
    static let textColor = "NSDatePicker.__setTextColor(_:)"
    static let backgroundColor = "NSDatePicker.__setBackgroundColor(_:)"
}

public extension NSDatePicker {
    var app_textColor: NSColor {
        set {
            if __USING_APPEARANCED_SWIZZING__ || newValue.appearanceIdentifier == nil {
                textColor = newValue
            } else {
                cache(
                    valA: newValue,
                    identifier: .textColor,
                    action: __setTextColor(_:)
                )
            }
        }
        get {
            textColor
        }
    }
    
    var app_backgroundColor: NSColor {
        set {
            if __USING_APPEARANCED_SWIZZING__ || newValue.appearanceIdentifier == nil {
                backgroundColor = newValue
            } else {
                cache(
                    valA: backgroundColor,
                    identifier: .backgroundColor,
                    action: __setBackgroundColor(_:)
                )
            }
        }
        get {
            backgroundColor
        }
    }
}

internal extension NSDatePicker {
    static func silenceExchangeScrollViewImplementation() {
        app_swizzing(
            originalSelector: #selector(setter: textColor),
            newSelector: #selector(swizzled_setTextColor(_:))
        )
        
        app_swizzing(
            originalSelector: #selector(setter: backgroundColor),
            newSelector: #selector(swizzled_setBackgroundColor(_:))
        )
    }
}

private extension NSDatePicker {
    func __setTextColor(_ textColor: NSColor) {
        if __USING_APPEARANCED_SWIZZING__ {
            swizzled_setTextColor(textColor)
        } else {
            self.textColor = textColor
        }
    }
    
    func __setBackgroundColor(_ backgroundColor: NSColor) {
        if __USING_APPEARANCED_SWIZZING__ {
            swizzled_setBackgroundColor(backgroundColor)
        } else {
            self.backgroundColor = backgroundColor
        }
    }
    
    @objc func swizzled_setTextColor(_ textColor: NSColor) {
        if textColor.appearanceIdentifier != nil {
            cache(
                valA: textColor,
                identifier: .textColor,
                action: __setTextColor(_:)
            )
        } else {
            swizzled_setTextColor(textColor)
        }
    }
    
    @objc func swizzled_setBackgroundColor(_ backgroundColor: NSColor) {
        if backgroundColor.appearanceIdentifier != nil {
            cache(
                valA: backgroundColor,
                identifier: .backgroundColor,
                action: __setBackgroundColor(_:)
            )
        } else {
            swizzled_setBackgroundColor(backgroundColor)
        }
    }
}

#endif
