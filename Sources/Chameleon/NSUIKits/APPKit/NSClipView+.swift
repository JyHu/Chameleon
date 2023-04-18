//
//  File.swift
//  
//
//  Created by Jo on 2023/4/10.
//

#if os(macOS)

import Cocoa

private extension AppearanceCallableIdentifier {
    static let backgroundColor = "NSClipView.__setBackgroundColor(_:)"
}

public extension NSClipView {
    var app_backgroundColor: NSColor {
        get { backgroundColor }
        set {
            if __USING_APPEARANCED_SWIZZLING__ {
                self.backgroundColor = backgroundColor
            } else {
                swizzled_setBackgroundColor(newValue)
            }
        }
    }
}

internal extension NSClipView {
    static func silenceExchangeClipViewImplementation() {
        app_swizzling(
            originalSelector: #selector(setter: backgroundColor),
            newSelector: #selector(swizzled_setBackgroundColor(_:))
        )
    }
}

private extension NSClipView {
    func __setBackgroundColor(_ backgroundColor: NSColor) {
        if __USING_APPEARANCED_SWIZZLING__ {
            swizzled_setBackgroundColor(backgroundColor)
        } else {
            self.backgroundColor = backgroundColor
        }
    }
    
    @objc func swizzled_setBackgroundColor(_ backgroundColor: NSColor) {
        cache(
            firstParam: Callable.Appearanced(backgroundColor),
            identifier: .backgroundColor,
            action: { [weak self] va in self?.__setBackgroundColor(va) }
        )
    }
}

#endif
