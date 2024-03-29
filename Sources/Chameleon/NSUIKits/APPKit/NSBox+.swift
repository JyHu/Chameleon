//
//  File.swift
//  
//
//  Created by Jo on 2023/4/3.
//

#if os(macOS)

import Cocoa

private extension AppearanceCallableIdentifier {
    static let fillColor = "NSBox.__setFillColor(_:)"
    static let borderColor = "NSBox.__setBorderColor(_:)"
}

public extension NSBox {
    var app_fillColor: NSColor {
        get { fillColor }
        set {
            if __USING_APPEARANCED_SWIZZLING__ {
                fillColor = newValue
            } else {
                swizzled_setFillColor(newValue)
            }
        }
    }
    
    var app_borderColor: NSColor {
        get { borderColor }
        set {
            if __USING_APPEARANCED_SWIZZLING__ {
                borderColor = newValue
            } else {
                swizzled_setBorderColor(newValue)
            }
        }
    }
}

internal extension NSBox {
    static func silenceExchangeBoxImplementation() {
        app_swizzling(
            originalSelector: #selector(setter: fillColor),
            newSelector: #selector(swizzled_setFillColor(_:))
        )
        
        app_swizzling(
            originalSelector: #selector(setter: borderColor),
            newSelector: #selector(swizzled_setBorderColor(_:))
        )
    }
}

private extension NSBox {
    func __setFillColor(_ fillColor: NSColor) {
        if __USING_APPEARANCED_SWIZZLING__ {
            swizzled_setFillColor(fillColor)
        } else {
            self.fillColor = fillColor
        }
    }
    
    func __setBorderColor(_ borderColor: NSColor) {
        if __USING_APPEARANCED_SWIZZLING__ {
            swizzled_setBorderColor(borderColor)
        } else {
            self.borderColor = borderColor
        }
    }
    
    @objc func swizzled_setFillColor(_ fillColor: NSColor) {
        cache(
            firstParam: Callable.Appearanced(fillColor),
            identifier: .fillColor,
            action: { [weak self] va in self?.__setFillColor(va) }
        )
    }
    
    @objc func swizzled_setBorderColor(_ borderColor: NSColor) {
        cache(
            firstParam: Callable.Appearanced(borderColor),
            identifier: .borderColor,
            action: { [weak self] va in self?.__setBorderColor(va) }
        )
    }
}

#endif
