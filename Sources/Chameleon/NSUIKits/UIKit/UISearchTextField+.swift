//
//  File.swift
//  
//
//  Created by Jo on 2023/4/11.
//

#if os(iOS)

import UIKit

private extension AppearanceCallableIdentifier {
    static let tokenBackgroundColor = "UISearchTextField.__setTokenBackgroundColor(_:)"
}

@available(iOS 13.0, *)
public extension UISearchTextField {
    var app_tokenBackgroundColor: UIColor {
        get { tokenBackgroundColor }
        set {
            if __USING_APPEARANCED_SWIZZING__ {
                self.tokenBackgroundColor = newValue
            } else {
                swizzled_setTokenBackgroundColor(newValue)
            }
        }
    }
}

@available(iOS 13.0, *)
internal extension UISearchTextField {
    static func silenceExchangeSearchTextFieldImplementation() {
        app_swizzing(
            originalSelector: #selector(setter: tokenBackgroundColor),
            newSelector: #selector(swizzled_setTokenBackgroundColor(_:))
        )
    }
}

@available(iOS 13.0, *)
private extension UISearchTextField {
    func __setTokenBackgroundColor(_ tokenBackgroundColor: UIColor) {
        if __USING_APPEARANCED_SWIZZING__ {
            swizzled_setTokenBackgroundColor(tokenBackgroundColor)
        } else {
            self.tokenBackgroundColor = tokenBackgroundColor
        }
    }
    
    @objc func swizzled_setTokenBackgroundColor(_ tokenBackgroundColor: UIColor) {
        cache(
            firstParam: Callable.Appearanced(tokenBackgroundColor),
            identifier: .tokenBackgroundColor,
            action: __setTokenBackgroundColor(_:)
        )
    }
}

#endif
