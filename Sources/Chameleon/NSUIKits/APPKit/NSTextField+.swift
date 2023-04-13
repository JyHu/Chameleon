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
    static let placeholderAttributedString = "NSTextField.__setPlaceholderAttributedString(_:)"
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
    
    var app_placeholderAttributedString: NSAttributedString? {
        get { placeholderAttributedString }
        set {
            if __USING_APPEARANCED_SWIZZING__ {
                placeholderAttributedString = newValue
            } else {
                swizzled_setPlaceholderAttributedString(newValue)
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
        
        app_swizzing(
            originalSelector: #selector(setter: placeholderAttributedString),
            newSelector: #selector(swizzled_setPlaceholderAttributedString(_:))
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
    
    func __setPlaceholderAttributedString(_ placeholderAttributedString: NSAttributedString?) {
        if __USING_APPEARANCED_SWIZZING__ {
            swizzled_setPlaceholderAttributedString(placeholderAttributedString)
        } else {
            self.placeholderAttributedString = placeholderAttributedString
        }
    }
    
    @objc func swizzled_setBackGroundColor(_ backgroundColor: NSColor?) {
        cache(
            firstParam: Callable.Appearanced(backgroundColor),
            identifier: .backgroundColor,
            action: { [weak self] va in self?.__setBackGroundColor(va) }
        )
    }
    
    @objc func swizzled_setTextColor(_ textColor: NSColor?) {
        cache(
            firstParam: Callable.Appearanced(textColor),
            identifier: .textColor,
            action: { [weak self] va in self?.__setTextColor(va) }
        )
    }
    
    @objc func swizzled_setAttributedStringValue(_ attributedStringValue: NSAttributedString) {
        cache(
            firstParam: Callable.Attributed(attributedStringValue),
            identifier: .attributedStringValue,
            action: { [weak self] va in self?.__setAttributedStringValue(va) }
        )
    }
    
    @objc func swizzled_setPlaceholderAttributedString(_ placeholderAttributedString: NSAttributedString?) {
        cache(
            firstParam: Callable.Attributed(placeholderAttributedString),
            identifier: .placeholderAttributedString,
            action: { [weak self] va in self?.__setPlaceholderAttributedString(va) }
        )
    }
}

#endif
