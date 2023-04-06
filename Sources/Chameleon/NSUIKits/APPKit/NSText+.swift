//
//  File.swift
//  
//
//  Created by Jo on 2023/4/2.
//

#if os(macOS)
import Cocoa

private extension AppearanceCallableIdentifier {
    static let textColor = "NSText.__text_setTextColor(_:)"
    static let backgroundColor = "NSText.__text_setBackgroundColor(_:)"
    static let textColorRange = "NSText.__setTextColor(_:range:)"
}

public extension NSText {
    var app_text_textColor: NSColor? {
        set {
            if __USING_SWIZZING__ || newValue?.appearanceIdentifier == nil {
                textColor = newValue
            } else {
                if let newValue = newValue {
                    cache(
                        valA: newValue,
                        identifier: .textColor,
                        action: __text_setTextColor(_:)
                    )
                } else {
                    __text_setTextColor(nil)
                }
            }
        }
        get { textColor }
    }
    
    var app_text_backgroundColor: NSColor? {
        set {
            if __USING_SWIZZING__ || newValue?.appearanceIdentifier == nil {
                backgroundColor = newValue
            } else {
                if let newValue = newValue {
                    cache(
                        valA: newValue,
                        identifier: .backgroundColor,
                        action: __text_setBackgroundColor(_:)
                    )
                } else {
                    __text_setBackgroundColor(nil)
                }
            }
        }
        get { backgroundColor }
    }
    
    func app_setTextColor(_ color: NSColor?, range: NSRange) {
        if __USING_SWIZZING__ || color?.appearanceIdentifier == nil {
            setTextColor(color, range: range)
        } else {
            if let color = color {
                cache(
                    valA: color,
                    valB: range,
                    identifier: .textColorRange,
                    action: __setTextColor(_:range:)
                )
            } else {
                __setTextColor(nil, range: range)
            }
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
        if let textColor = textColor {
            cache(
                valA: textColor,
                identifier: .textColor,
                action: __text_setTextColor(_:)
            )
        } else {
            swizzled_text_setTextColor(textColor)
        }
    }
    
    @objc func swizzled_text_setBackgroundColor(_ backgroundColor: NSColor?) {
        if let backgroundColor = backgroundColor {
            cache(
                valA: backgroundColor,
                identifier: .backgroundColor,
                action: __text_setBackgroundColor(_:)
            )
        } else {
            swizzled_text_setBackgroundColor(backgroundColor)
        }
    }
    
    @objc func swizzled_setTextColor(_ color: NSColor?, range: NSRange) {
        if let color = color {
            cache(
                valA: color,
                valB: range,
                identifier: .textColorRange,
                action: __setTextColor(_:range:)
            )
        } else {
            swizzled_setTextColor(color, range: range)
        }
    }
}

#endif
