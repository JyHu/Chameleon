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
        get { textColor }
        set {
            if __USING_APPEARANCED_SWIZZING__ {
                textColor = newValue
            } else {
                swizzled_setTextColor(newValue)
            }
        }
    }
    
    var app_backgroundColor: NSColor {
        get { backgroundColor }
        set {
            if __USING_APPEARANCED_SWIZZING__ {
                backgroundColor = newValue
            } else {
                swizzled_setBackgroundColor(newValue)
            }
        }
    }
}

internal extension NSDatePicker {
    static func silenceExchangeDatePickerViewImplementation() {
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
        cache(
            firstParam: Callable.Appearanced(textColor),
            identifier: .textColor,
            action: __setTextColor(_:)
        )
    }
    
    @objc func swizzled_setBackgroundColor(_ backgroundColor: NSColor) {
        cache(
            firstParam: Callable.Appearanced(backgroundColor),
            identifier: .backgroundColor,
            action: __setBackgroundColor(_:)
        )
    }
}

#endif
