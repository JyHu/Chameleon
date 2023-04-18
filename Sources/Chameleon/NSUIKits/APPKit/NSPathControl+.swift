//
//  File.swift
//  
//
//  Created by Jo on 2023/4/10.
//


#if os(macOS)

import Cocoa

private extension AppearanceCallableIdentifier {
    static let placeholderAttributedString = "NSPathControl.__setPlaceholderAttributedString(_:)"
    static let backgroundColor = "NSPathControl.__setBackgroundColor(_:)"
}

public extension NSPathControl {
    var app_placeholderAttributedString: NSAttributedString? {
        get { placeholderAttributedString }
        set {
            if __USING_APPEARANCED_SWIZZLING__ {
                placeholderAttributedString = newValue
            } else {
                swizzled_setPlaceholderAttributedString(newValue)
            }
        }
    }
    
    var app_backgroundColor: NSColor? {
        get { backgroundColor }
        set {
            if __USING_APPEARANCED_SWIZZLING__ {
                backgroundColor = newValue
            } else {
                swizzled_setBackgroundColor(newValue)
            }
        }
    }
}

internal extension NSPathControl {
    static func silenceExchangePathControlImplementation() {
        app_swizzling(
            originalSelector: #selector(setter: placeholderAttributedString),
            newSelector: #selector(swizzled_setPlaceholderAttributedString(_:))
        )
        
        app_swizzling(
            originalSelector: #selector(setter: backgroundColor),
            newSelector: #selector(swizzled_setBackgroundColor(_:))
        )
    }
}

private extension NSPathControl {
    func __setBackgroundColor(_ backgroundColor: NSColor?) {
        if __USING_APPEARANCED_SWIZZLING__ {
            swizzled_setBackgroundColor(backgroundColor)
        } else {
            self.backgroundColor = backgroundColor
        }
    }
    
    func __setPlaceholderAttributedString(_ placeholderAttributedString: NSAttributedString?) {
        if __USING_APPEARANCED_SWIZZLING__ {
            swizzled_setPlaceholderAttributedString(placeholderAttributedString)
        } else {
            self.placeholderAttributedString = placeholderAttributedString
        }
    }
    
    @objc func swizzled_setBackgroundColor(_ backgroundColor: NSColor?) {
        cache(
            firstParam: Callable.Appearanced(backgroundColor),
            identifier: .backgroundColor,
            action: { [weak self] va in self?.__setBackgroundColor(va) }
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
