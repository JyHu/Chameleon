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
    static let shadowColor = "UILabel.__setShadowColor(_:)"
    static let attributedText = "UILabel.__setAttributedText(_:)"
    static let highlightedTextColor = "UILabel.__setHighlightedTextColor(_:)"
}

public extension UILabel {
    var app_textColor: UIColor {
        get { textColor }
        set {
            if __USING_APPEARANCED_SWIZZING__ {
                self.textColor = newValue
            } else {
                swizzled_setTextColor(newValue)
            }
        }
    }
    
    var app_shadowColor: UIColor? {
        get { shadowColor }
        set {
            if __USING_APPEARANCED_SWIZZING__ {
                self.shadowColor = newValue
            } else {
                swizzled_setShadowColor(newValue)
            }
        }
    }
    
    var app_attributedText: NSAttributedString? {
        get { attributedText }
        set {
            if __USING_APPEARANCED_SWIZZING__ {
                self.attributedText = newValue
            } else {
                swizzled_setAttributedTitle(newValue)
            }
        }
    }
    
    var app_highlightedTextColor: UIColor? {
        get { highlightedTextColor }
        set {
            if __USING_APPEARANCED_SWIZZING__ {
                self.highlightedTextColor = newValue
            } else {
                swizzled_setHighlightedTextColor(newValue)
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
        
        app_swizzing(
            originalSelector: #selector(setter: shadowColor),
            newSelector: #selector(swizzled_setShadowColor(_:))
        )
        
        app_swizzing(
            originalSelector: #selector(setter: attributedText),
            newSelector: #selector(swizzled_setAttributedTitle(_:))
        )
        
        app_swizzing(
            originalSelector: #selector(setter: highlightedTextColor),
            newSelector: #selector(swizzled_setHighlightedTextColor(_:))
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
    
    func __setShadowColor(_ shadowColor: UIColor?) {
        if __USING_APPEARANCED_SWIZZING__ {
            swizzled_setShadowColor(shadowColor)
        } else {
            self.shadowColor = shadowColor
        }
    }
    
    func __setAttributedText(_ attributedText: NSAttributedString?) {
        if __USING_APPEARANCED_SWIZZING__ {
            swizzled_setAttributedTitle(attributedText)
        } else {
            self.attributedText = attributedText
        }
    }
    
    func __setHighlightedTextColor(_ highlightedTextColor: UIColor?) {
        if __USING_APPEARANCED_SWIZZING__ {
            swizzled_setHighlightedTextColor(highlightedTextColor)
        } else {
            self.highlightedTextColor = highlightedTextColor
        }
    }
    
    @objc func swizzled_setTextColor(_ textColor: UIColor) {
        cache(
            firstParam: Callable.Appearanced(textColor),
            identifier: .textColor,
            action: __setTextColor(_:)
        )
    }
    
    @objc func swizzled_setShadowColor(_ shadowColor: UIColor?) {
        cache(
            firstParam: Callable.Appearanced(shadowColor),
            identifier: .shadowColor,
            action: __setShadowColor(_:)
        )
    }
    
    @objc func swizzled_setAttributedTitle(_ attributedText: NSAttributedString?) {
        cache(
            firstParam: Callable.Appearanced(attributedText),
            identifier: .attributedText,
            action: __setAttributedText(_:)
        )
    }
    
    @objc func swizzled_setHighlightedTextColor(_ highlightedTextColor: UIColor?) {
        cache(
            firstParam: Callable.Appearanced(highlightedTextColor),
            identifier: .highlightedTextColor,
            action: __setHighlightedTextColor(_:)
        )
    }
}

#endif
