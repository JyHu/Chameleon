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
        set {
            if __USING_APPEARANCED_SWIZZING__ || newValue?.appearanceIdentifier == nil {
                backgroundColor = newValue
            } else {
                if let newValue {
                    cache(
                        valA: newValue,
                        identifier: .backgroundColor,
                        action: __setBackgroundColor(_:)
                    )
                } else {
                    __setBackgroundColor(nil)
                }
            }
        }
        get {
            backgroundColor
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
        if let backgroundColor, backgroundColor.appearanceIdentifier != nil {
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
