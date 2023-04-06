//
//  File.swift
//  
//
//  Created by Jo on 2023/4/4.
//


#if os(macOS)

import Cocoa

private extension AppearanceCallableIdentifier {
    static let backgroundColor = "NSTextField.__setBackGroundColor(_:)"
    static let textColor = "NSTextField.__setTextColor(_:)"
}

public extension NSTextField {
    var app_backgroundColor: NSColor? {
        set {
            if __USING_SWIZZING__ || newValue?.appearanceIdentifier == nil {
                backgroundColor = newValue
            } else {
                if let newValue {
                    cache(
                        valA: newValue,
                        identifier: .backgroundColor,
                        action: __setBackGroundColor(_:)
                    )
                } else {
                    __setBackGroundColor(nil)
                }
            }
        }
        get {
            return backgroundColor
        }
    }
    
    var app_textColor: NSColor? {
        set {
            if __USING_SWIZZING__ || newValue?.appearanceIdentifier == nil {
                textColor = newValue
            } else {
                if let newValue {
                    cache(
                        valA: newValue,
                        identifier: .textColor,
                        action: __setTextColor(_:)
                    )
                } else {
                    __setTextColor(nil)
                }
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
        if let backgroundColor {
            cache(
                valA: backgroundColor,
                identifier: .backgroundColor,
                action: __setBackGroundColor(_:)
            )
        } else {
            swizzled_setBackGroundColor(backgroundColor)
        }
    }
    
    @objc func swizzled_setTextColor(_ textColor: NSColor?) {
        if let textColor {
            cache(
                valA: textColor,
                identifier: .textColor,
                action: __setTextColor(_:)
            )
        } else {
            swizzled_setTextColor(textColor)
        }
    }
}

#endif
