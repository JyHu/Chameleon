//
//  File.swift
//  
//
//  Created by Jo on 2023/4/11.
//

#if os(iOS)

import UIKit

private extension AppearanceCallableIdentifier {
    static let textColor = "UITextView.__setTextColor(:)"
    static let attributedText = "UITextView.__setAttributedText(:)"
    static let typingAttributes = "UITextView.__setTypingAttributes(:)"
    static let linkTextAttributes = "UITextView.__setLinkTextAttributes(:)"
}

public extension UITextView {
    var app_textColor: UIColor? {
        get { textColor }
        set {
            if __USING_APPEARANCED_SWIZZING__ {
                self.textColor = newValue
            } else {
                swizzled_setTextColor(newValue)
            }
        }
    }
    
    var app_attributedText: NSAttributedString {
        get { attributedText }
        set {
            if __USING_APPEARANCED_SWIZZING__ {
                self.attributedText = newValue
            } else {
                swizzled_setAttributedText(newValue)
            }
        }
    }
    
    var app_typingAttributes: [NSAttributedString.Key: Any] {
        get { typingAttributes }
        set {
            if __USING_APPEARANCED_SWIZZING__ {
                self.typingAttributes = newValue
            } else {
                swizzled_setTypingAttributes(newValue)
            }
        }
    }
    
    var app_linkTextAttributes: [NSAttributedString.Key: Any] {
        get { linkTextAttributes }
        set {
            if __USING_APPEARANCED_SWIZZING__ {
                self.linkTextAttributes = newValue
            } else {
                swizzled_setLinkTextAttributes(newValue)
            }
        }
    }
}

internal extension UITextView {
    static func silenceExchangeTextViewImplementation() {
        app_swizzing(
            originalSelector: #selector(setter: textColor),
            newSelector: #selector(swizzled_setTextColor(_:))
        )
        
        app_swizzing(
            originalSelector: #selector(setter: attributedText),
            newSelector: #selector(swizzled_setAttributedText(_:))
        )
        
        app_swizzing(
            originalSelector: #selector(setter: typingAttributes),
            newSelector: #selector(swizzled_setTypingAttributes(_:))
        )
        
        app_swizzing(
            originalSelector: #selector(setter: linkTextAttributes),
            newSelector: #selector(swizzled_setLinkTextAttributes(_:))
        )
    }
}

private extension UITextView {
    func __setTextColor(_ textColor: UIColor?) {
        if __USING_APPEARANCED_SWIZZING__ {
            swizzled_setTextColor(textColor)
        } else {
            self.textColor = textColor
        }
    }
    
    func __setAttributedText(_ attributedText: NSAttributedString) {
        if __USING_APPEARANCED_SWIZZING__ {
            swizzled_setAttributedText(attributedText)
        } else {
            self.attributedText = attributedText
        }
    }
    
    func __setTypingAttributes(_ typingAttributes: [NSAttributedString.Key: Any]) {
        if __USING_APPEARANCED_SWIZZING__ {
            swizzled_setTypingAttributes(typingAttributes)
        } else {
            self.typingAttributes = typingAttributes
        }
    }
    
    func __setLinkTextAttributes(_ linkTextAttributes: [NSAttributedString.Key: Any]) {
        if __USING_APPEARANCED_SWIZZING__ {
            swizzled_setLinkTextAttributes(linkTextAttributes)
        } else {
            self.linkTextAttributes = linkTextAttributes
        }
    }
    
    
    @objc func swizzled_setTextColor(_ textColor: UIColor?) {
        cache(
            firstParam: Callable.Appearanced(textColor),
            identifier: .textColor,
            action: { [weak self] va in self?.__setTextColor(va) }
        )
    }
    
    @objc func swizzled_setAttributedText(_ attributedText: NSAttributedString) {
        cache(
            firstParam: Callable.Attributed(attributedText),
            identifier: .attributedText,
            action: { [weak self] va in self?.__setAttributedText(va) }
        )
    }
    
    @objc func swizzled_setTypingAttributes(_ typingAttributes: [NSAttributedString.Key: Any]) {
        cache(
            firstParam: Callable.Collection(typingAttributes),
            identifier: .typingAttributes,
            action: { [weak self] va in self?.__setTypingAttributes(va) }
        )
    }
    
    @objc func swizzled_setLinkTextAttributes(_ linkTextAttributes: [NSAttributedString.Key: Any]) {
        cache(
            firstParam: Callable.Collection(linkTextAttributes),
            identifier: .linkTextAttributes,
            action: { [weak self] va in self?.__setLinkTextAttributes(va) }
        )
    }
}

#endif
