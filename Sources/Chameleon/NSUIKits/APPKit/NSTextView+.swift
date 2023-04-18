//
//  File.swift
//  
//
//  Created by Jo on 2023/4/4.
//


#if os(macOS)

import Cocoa

private extension AppearanceCallableIdentifier {
    static let insertionPointColor = "NSTextView.__setInsertionPointColor(_:)"
    static let backgroundColor = "NSTextView.__setBackgroundColor(_:)"
    static let textColor = "NSTextView.__setTextColor(_:)"
}

public extension NSTextView {
    var app_insertionPointColor: NSColor {
        get { insertionPointColor }
        set {
            if __USING_APPEARANCED_SWIZZLING__ {
                insertionPointColor = newValue
            } else {
                swizzled_setInsertionPointColor(newValue)
            }
        }
    }
    
    var app_backgroundColor: NSColor {
        get { backgroundColor }
        set {
            if __USING_APPEARANCED_SWIZZLING__ {
                backgroundColor = newValue
            } else {
                swizzled_setBackgroundColor(newValue)
            }
        }
    }
    
    var app_textColor: NSColor? {
        get { textColor }
        set {
            if __USING_APPEARANCED_SWIZZLING__ {
                textColor = newValue
            } else {
                swizzled_setTextColor(newValue)
            }
        }
    }
}

internal extension NSTextView {
    static func silenceExchangeTextViewImplementation() {

        app_swizzling(
            originalSelector: #selector(setter: insertionPointColor),
            newSelector: #selector(swizzled_setInsertionPointColor(_:))
        )
        
        app_swizzling(
            originalSelector: #selector(setter: backgroundColor),
            newSelector: #selector(swizzled_setBackgroundColor(_:))
        )
        
        app_swizzling(
            originalSelector: #selector(setter: textColor),
            newSelector: #selector(swizzled_setTextColor(_:))
        )
        
    }
}

private extension NSTextView {
    func __setInsertionPointColor(_ insertionPointColor: NSColor) {
        if __USING_APPEARANCED_SWIZZLING__ {
            swizzled_setInsertionPointColor(insertionPointColor)
        } else {
            self.insertionPointColor = insertionPointColor
        }
    }
    
    func __setBackgroundColor(_ backgroundColor: NSColor) {
        if __USING_APPEARANCED_SWIZZLING__ {
            swizzled_setBackgroundColor(backgroundColor)
        } else {
            self.backgroundColor = backgroundColor
        }
    }
    
    func __setTextColor(_ textColor: NSColor?) {
        if __USING_APPEARANCED_SWIZZLING__ {
            swizzled_setTextColor(textColor)
        } else {
            self.textColor = textColor
        }
    }
    
    @objc func swizzled_setInsertionPointColor(_ insertionPointColor: NSColor) {
        cache(
            firstParam: Callable.Appearanced(insertionPointColor),
            identifier: .insertionPointColor,
            action: { [weak self] va in self?.__setInsertionPointColor(va) }
        )
    }
    
    @objc func swizzled_setBackgroundColor(_ backgroundColor: NSColor) {
        cache(
            firstParam: Callable.Appearanced(backgroundColor),
            identifier: .backgroundColor,
            action: { [weak self] va in self?.__setBackgroundColor(va) }
        )
    }
    
    @objc func swizzled_setTextColor(_ textColor: NSColor?) {
        cache(
            firstParam: Callable.Appearanced(textColor),
            identifier: .textColor,
            action: { [weak self] va in self?.__setTextColor(va) }
        )
    }
}

#endif
