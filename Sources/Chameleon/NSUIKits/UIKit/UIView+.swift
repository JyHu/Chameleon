//
//  File.swift
//  
//
//  Created by Jo on 2023/4/6.
//

#if canImport(UIKit)

import UIKit

private extension AppearanceCallableIdentifier {
    static let backgroundColor = "UIView.__setBackgroundColor(_:)"
}

public extension UIView {
    var app_backgroundColor: UIColor? {
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

internal extension UIView {
    static func silenceExchangeViewImplementation() {
        app_swizzing(
            originalSelector: #selector(setter: backgroundColor),
            newSelector: #selector(swizzled_setBackgroundColor(_:))
        )
    }
}

private extension UIView {
    func __setBackgroundColor(_ backgroundColor: UIColor?) {
        if __USING_APPEARANCED_SWIZZING__ {
            swizzled_setBackgroundColor(backgroundColor)
        } else {
            self.backgroundColor = backgroundColor
        }
    }
    
    @objc func swizzled_setBackgroundColor(_ backgroundColor: UIColor?) {
        cache(
            valA: backgroundColor,
            identifier: .backgroundColor,
            action: __setBackgroundColor(_:)
        )
    }
}

#endif
