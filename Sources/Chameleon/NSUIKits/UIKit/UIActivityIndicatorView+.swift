//
//  File.swift
//  
//
//  Created by Jo on 2023/4/10.
//

#if os(iOS)

import UIKit

private extension AppearanceCallableIdentifier {
    static let color = "UIActivityIndicatorView.__setColor(_:)"
}

public extension UIActivityIndicatorView {
    var app_color: UIColor {
        get { color }
        set {
            if __USING_APPEARANCED_SWIZZLING__ {
                color = newValue
            } else {
                swizzled_setColor(newValue)
            }
        }
    }
}

internal extension UIActivityIndicatorView {
    static func silenceExchangeActivityIndicatorViewImplementation() {
        app_swizzling(
            originalSelector: #selector(setter: color),
            newSelector: #selector(swizzled_setColor(_:))
        )
    }
}

private extension UIActivityIndicatorView {
    func __setColor(_ color: UIColor) {
        if __USING_APPEARANCED_SWIZZLING__ {
            swizzled_setColor(color)
        } else {
            self.color = color
        }
    }
    
    @objc func swizzled_setColor(_ color: UIColor) {
        cache(
            firstParam: Callable.Appearanced(color),
            identifier: .color,
            action: { [weak self] va in self?.__setColor(va) }
        )
    }
}

#endif
