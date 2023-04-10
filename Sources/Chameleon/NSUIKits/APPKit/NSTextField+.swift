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
    static let attributedStringValue = "NSTextField.__setAttributedStringValue(_:)"
}

public extension NSTextField {
    var app_backgroundColor: NSColor? {
        get { backgroundColor }
        set {
            if __USING_APPEARANCED_SWIZZING__ {
                backgroundColor = newValue
            } else {
                swizzled_setBackGroundColor(newValue)
            }
        }
    }
    
    var app_textColor: NSColor? {
        get { textColor }
        set {
            if __USING_APPEARANCED_SWIZZING__ {
                textColor = newValue
            } else {
                swizzled_setTextColor(newValue)
            }
        }
    }
    
    var app_attributedStringValue: NSAttributedString {
        get { attributedStringValue }
        set {
            if __USING_APPEARANCED_SWIZZING__ {
                attributedStringValue = newValue
            } else {
                swizzled_setAttributedStringValue(newValue)
            }
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
        
        app_swizzing(
            originalSelector: #selector(setter: attributedStringValue),
            newSelector: #selector(swizzled_setAttributedStringValue(_:))
        )
    }
}

private extension NSTextField {
    func __setBackGroundColor(_ backgroundColor: NSColor?) {
        if __USING_APPEARANCED_SWIZZING__ {
            swizzled_setBackGroundColor(backgroundColor)
        } else {
            self.backgroundColor = backgroundColor
        }
    }
    
    func __setTextColor(_ textColor: NSColor?) {
        if __USING_APPEARANCED_SWIZZING__ {
            swizzled_setTextColor(textColor)
        } else {
            self.textColor = textColor
        }
    }
    
    func __setAttributedStringValue(_ attributedStringValue: NSAttributedString) {
        if __USING_APPEARANCED_SWIZZING__ {
            swizzled_setAttributedStringValue(attributedStringValue)
        } else {
            self.attributedStringValue = attributedStringValue
        }
    }
    
    @objc func swizzled_setBackGroundColor(_ backgroundColor: NSColor?) {
        cache(
            firstParam: Callable.Appearanced(backgroundColor),
            identifier: .backgroundColor,
            action: __setBackGroundColor(_:)
        )
    }
    
    @objc func swizzled_setTextColor(_ textColor: NSColor?) {
        cache(
            firstParam: Callable.Appearanced(textColor),
            identifier: .textColor,
            action: __setTextColor(_:)
        )
    }
    
    @objc func swizzled_setAttributedStringValue(_ attributedStringValue: NSAttributedString) {
        cache(
            firstParam: Callable.Attributed(attributedStringValue),
            identifier: .attributedStringValue,
            action: __setAttributedStringValue(_:)
        )
    }
}

#endif
