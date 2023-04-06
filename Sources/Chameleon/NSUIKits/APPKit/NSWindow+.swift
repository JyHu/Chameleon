//
//  File.swift
//  
//
//  Created by Jo on 2023/4/6.
//

#if os(macOS)

import Cocoa

private extension AppearanceCallableIdentifier {
    static let backgroundColor = "NSWindow.__setBackgroundColor(_:)"
}

public extension NSWindow {
    var app_backgroundColor: NSColor {
        set {
            if __USING_APPEARANCED_SWIZZING__ || newValue.appearanceIdentifier == nil {
                backgroundColor = newValue
            } else {
                cache(
                    valA: newValue,
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

internal extension NSWindow {
    static func silenceExchangeWindowImplementation() {
        app_swizzing(
            originalSelector: #selector(setter: backgroundColor),
            newSelector: #selector(swizzled_setBackgroundColor(_:))
        )
    }
}

private extension NSWindow {
    func __setBackgroundColor(_ backgroundColor: NSColor) {
        if __USING_APPEARANCED_SWIZZING__ {
            swizzled_setBackgroundColor(backgroundColor)
        } else {
            self.backgroundColor = backgroundColor
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
