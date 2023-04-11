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
            if __USING_APPEARANCED_SWIZZING__ {
                placeholderAttributedString = newValue
            } else {
                swizzled_setPlaceholderAttributedString(newValue)
            }
        }
    }
    
    var app_backgroundColor: NSColor? {
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

internal extension NSPathControl {
    static func silenceExchangePathControlImplementation() {
        app_swizzing(
            originalSelector: #selector(setter: placeholderAttributedString),
            newSelector: #selector(swizzled_setPlaceholderAttributedString(_:))
        )
        
        app_swizzing(
            originalSelector: #selector(setter: backgroundColor),
            newSelector: #selector(swizzled_setBackgroundColor(_:))
        )
    }
}

private extension NSPathControl {
    func __setBackgroundColor(_ backgroundColor: NSColor?) {
        if __USING_APPEARANCED_SWIZZING__ {
            swizzled_setBackgroundColor(backgroundColor)
        } else {
            self.backgroundColor = backgroundColor
        }
    }
    
    func __setPlaceholderAttributedString(_ placeholderAttributedString: NSAttributedString?) {
        if __USING_APPEARANCED_SWIZZING__ {
            swizzled_setPlaceholderAttributedString(placeholderAttributedString)
        } else {
            self.placeholderAttributedString = placeholderAttributedString
        }
    }
    
    @objc func swizzled_setBackgroundColor(_ backgroundColor: NSColor?) {
        cache(
            firstParam: Callable.Appearanced(backgroundColor),
            identifier: .backgroundColor,
            action: __setBackgroundColor(_:)
        )
    }
    
    @objc func swizzled_setPlaceholderAttributedString(_ placeholderAttributedString: NSAttributedString?) {
        guard let placeholderAttributedString = placeholderAttributedString else { return }
        cache(
            firstParam: Callable.Attributed(placeholderAttributedString),
            identifier: .placeholderAttributedString,
            action: __setPlaceholderAttributedString(_:)
        )
    }
}

#endif
