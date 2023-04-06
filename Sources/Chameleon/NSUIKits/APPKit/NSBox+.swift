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
        set {
            if __USING_APPEARANCED_SWIZZING__ || newValue.appearanceIdentifier == nil {
                fillColor = newValue
            } else {
                cache(
                    valA: newValue,
                    identifier: .fillColor,
                    action: __setFillColor(_:)
                )
            }
        }
        
        get {
            return fillColor
        }
    }
    
    var app_borderColor: NSColor {
        set {
            if __USING_APPEARANCED_SWIZZING__ || newValue.appearanceIdentifier == nil {
                borderColor = newValue
            } else {
                cache(
                    valA: newValue,
                    identifier: .borderColor,
                    action: __setBorderColor(_:)
                )
            }
        }
        get {
            return borderColor
        }
    }
}

internal extension NSBox {
    static func silenceExchangeBoxImplementation() {
        app_swizzing(
            originalSelector: #selector(setter: fillColor),
            newSelector: #selector(swizzled_setFillColor(_:))
        )
        
        app_swizzing(
            originalSelector: #selector(setter: borderColor),
            newSelector: #selector(swizzled_setBorderColor(_:))
        )
    }
}

private extension NSBox {
    func __setFillColor(_ fillColor: NSColor) {
        if __USING_APPEARANCED_SWIZZING__ {
            swizzled_setFillColor(fillColor)
        } else {
            self.fillColor = fillColor
        }
    }
    
    func __setBorderColor(_ borderColor: NSColor) {
        if __USING_APPEARANCED_SWIZZING__ {
            swizzled_setBorderColor(borderColor)
        } else {
            self.borderColor = borderColor
        }
    }
    
    @objc func swizzled_setFillColor(_ fillColor: NSColor) {
        if fillColor.appearanceIdentifier != nil {
            cache(
                valA: fillColor,
                identifier: .fillColor,
                action: __setFillColor(_:)
            )
        } else {
            swizzled_setFillColor(fillColor)
        }
    }
    
    @objc func swizzled_setBorderColor(_ borderColor: NSColor) {
        if borderColor.appearanceIdentifier != nil {
            cache(
                valA: borderColor,
                identifier: .borderColor,
                action: __setBorderColor(_:)
            )
        } else {
            swizzled_setBorderColor(borderColor)
        }
    }
}

#endif
