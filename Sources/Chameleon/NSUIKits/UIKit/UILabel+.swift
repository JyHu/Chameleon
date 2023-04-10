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
    static let attributedText = "UILabel.__setAttributedText(_:)"
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
    
    var app_attributedText: NSAttributedString? {
        get { attributedText }
        set {
            if __USING_APPEARANCED_SWIZZING__ {
                attributedText = newValue
            } else {
                swizzled_setAttributedTitle(newValue)
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
    
    func __setAttributedText(_ attributedText: NSAttributedString?) {
        if __USING_APPEARANCED_SWIZZING__ {
            swizzled_setAttributedTitle(attributedText)
        } else {
            self.attributedText = attributedText
        }
    }
    
    @objc func swizzled_setTextColor(_ textColor: UIColor) {
        cache(
            firstParam: Callable.Appearanced(textColor),
            identifier: .textColor,
            action: __setTextColor(_:)
        )
    }
    
    @objc func swizzled_setAttributedTitle(_ attributedText: NSAttributedString?) {
        cache(
            firstParam: Callable.Appearanced(attributedText),
            identifier: .attributedText,
            action: __setAttributedText(_:)
        )
    }
}

#endif
