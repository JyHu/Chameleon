//
//  File.swift
//  
//
//  Created by Jo on 2023/4/6.
//

#if canImport(UIKit)

import UIKit

private extension AppearanceCallableIdentifier {
    static let textColor = "UILabel.__setTextColor(_:)"
}

public extension UILabel {
    var app_textColor: UIColor {
        get { textColor }
        set {
            if __USING_APPEARANCED_SWIZZING__ {
                textColor = newValue
            } else {
                swizzled_setTextColor(newValue)
            }
        }
    }
}

internal extension UILabel {
    static func silenceExchangeLabelImplementation() {
        app_swizzing(
            originalSelector: #selector(setter: textColor),
            newSelector: #selector(swizzled_setTextColor(_:))
        )
    }
}

private extension UILabel {
    func __setTextColor(_ textColor: UIColor) {
        if __USING_APPEARANCED_SWIZZING__ {
            swizzled_setTextColor(textColor)
        } else {
            self.textColor = textColor
        }
    }
    
    @objc func swizzled_setTextColor(_ textColor: UIColor) {
        if textColor.appearanceIdentifier != nil {
            cache(
                valA: textColor,
                identifier: .textColor,
                action: __setTextColor(_:)
            )
        } else {
            __setTextColor(textColor)
        }
    }
}

#endif
