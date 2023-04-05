//
//  File.swift
//  
//
//  Created by Jo on 2023/4/3.
//

#if os(macOS)

import Cocoa

public extension NSBox {
    var app_fillColor: NSColor {
        set {
            cache(
                valA: .required(newValue),
                identifier: "NSBox.__setFillColor(_:)",
                action: __setFillColor(_:)
            )
        }
        
        get {
            return fillColor
        }
    }
    
    var app_borderColor: NSColor {
        set {
            cache(
                valA: .required(newValue),
                identifier: "NSBox.__setBorderColor(_:)",
                action: __setBorderColor(_:)
            )
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
    func __setFillColor(_ fillColor: Callable.Param<NSColor>) {
        if __USING_SWIZZING__ {
            swizzled_setFillColor(fillColor.requiredValue)
        } else {
            self.fillColor = fillColor.requiredValue
        }
    }
    
    func __setBorderColor(_ borderColor: Callable.Param<NSColor>) {
        if __USING_SWIZZING__ {
            swizzled_setBorderColor(borderColor.requiredValue)
        } else {
            self.borderColor = borderColor.requiredValue
        }
    }
    
    @objc func swizzled_setFillColor(_ fillColor: NSColor) {
        if fillColor.appearanceIdentifier != nil {
            cache(
                valA: .required(fillColor),
                identifier: "NSBox.__setFillColor(_:)",
                action: __setFillColor(_:)
            )
        } else {
            swizzled_setFillColor(fillColor)
        }
    }
    
    @objc func swizzled_setBorderColor(_ borderColor: NSColor) {
        if borderColor.appearanceIdentifier != nil {
            cache(
                valA: .required(borderColor),
                identifier: "NSBox.__setBorderColor(_:)",
                action: __setBorderColor(_:)
            )
        } else {
            swizzled_setBorderColor(borderColor)
        }
    }
}

#endif