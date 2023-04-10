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
        get { textColor }
        set {
            if __USING_APPEARANCED_SWIZZING__ {
                textColor = newValue
            } else {
                swizzled_text_setTextColor(newValue)
            }
        }
    }
    
    var app_text_backgroundColor: NSColor? {
        get { backgroundColor }
        set {
            if __USING_APPEARANCED_SWIZZING__ {
                backgroundColor = newValue
            } else {
                swizzled_text_setBackgroundColor(newValue)
            }
        }
    }
    
    func app_setTextColor(_ color: NSColor?, range: NSRange) {
        if __USING_APPEARANCED_SWIZZING__ {
            setTextColor(color, range: range)
        } else {
            swizzled_setTextColor(color, range: range)
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
        if __USING_APPEARANCED_SWIZZING__ {
            swizzled_text_setTextColor(textColor)
        } else {
            self.textColor = textColor
        }
    }
    
    func __text_setBackgroundColor(_ backgroundColor: NSColor?) {
        if __USING_APPEARANCED_SWIZZING__ {
            swizzled_text_setBackgroundColor(backgroundColor)
        } else {
            self.backgroundColor = backgroundColor
        }
    }
    
    func __setTextColor(_ color: NSColor?, range: NSRange) {
        if __USING_APPEARANCED_SWIZZING__ {
            swizzled_setTextColor(color, range: range)
        } else {
            setTextColor(color, range: range)
        }
    }
    
    
    @objc func swizzled_text_setTextColor(_ textColor: NSColor?) {
        cache(
            firstParam: Callable.Appearanced(textColor),
            identifier: .textColor,
            action: __text_setTextColor(_:)
        )
    }
    
    @objc func swizzled_text_setBackgroundColor(_ backgroundColor: NSColor?) {
        cache(
            firstParam: Callable.Appearanced(backgroundColor),
            identifier: .backgroundColor,
            action: __text_setBackgroundColor(_:)
        )
    }
    
    @objc func swizzled_setTextColor(_ color: NSColor?, range: NSRange) {
        cache(
            firstParam: Callable.Appearanced(color),
            secondParam: Callable.Mediator(range),
            identifier: .textColorRange,
            action: __setTextColor(_:range:)
        )
    }
}

#endif
