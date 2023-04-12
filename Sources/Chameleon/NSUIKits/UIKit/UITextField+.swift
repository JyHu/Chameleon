//
//  File.swift
//  
//
//  Created by Jo on 2023/4/11.
//

#if os(iOS)

import UIKit

private extension AppearanceCallableIdentifier {
    static let attributedText = "UITextField.__setAttributedText(_:)"
    static let textColor = "UITextField.__setTextColor(_:)"
    static let defaultTextAttributes = "UITextField.__setDefaultTextAttributes(_:)"
    static let attributedPlaceholder = "UITextField.__setAttributedPlaceholder(_:)"
    static let background = "UITextField.__setBackground(_:)"
    static let disabledBackground = "UITextField.__setDisabledBackground(_:)"
    static let typingAttributes = "UITextField.__setTypingAttributes(_:)"
}

public extension UITextField {
    var app_attributedText: NSAttributedString? {
        get { attributedText }
        set {
            if __USING_APPEARANCED_SWIZZING__ {
                self.attributedText = newValue
            } else {
                swizzled_setAttributedText(newValue)
            }
        }
    }
    
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
    
    var app_defaultTextAttributes: [NSAttributedString.Key: Any] {
        get { defaultTextAttributes }
        set {
            if __USING_APPEARANCED_SWIZZING__ {
                self.defaultTextAttributes = newValue
            } else {
                swizzled_setDefaultTextAttributes(newValue)
            }
        }
    }
    
    var app_attributedPlaceholder: NSAttributedString? {
        get { attributedPlaceholder }
        set {
            if __USING_APPEARANCED_SWIZZING__ {
                self.attributedPlaceholder = newValue
            } else {
                swizzled_setAttributedPlaceholder(newValue)
            }
        }
    }
    
    var app_background: UIImage? {
        get { background }
        set {
            if __USING_APPEARANCED_SWIZZING__ {
                self.background = newValue
            } else {
                swizzled_setBackground(newValue)
            }
        }
    }
    
    var app_disabledBackground: UIImage? {
        get { disabledBackground }
        set {
            if __USING_APPEARANCED_SWIZZING__ {
                self.disabledBackground = newValue
            } else {
                swizzled_setDisabledBackground(newValue)
            }
        }
    }
    
    var app_typingAttributes: [NSAttributedString.Key: Any]? {
        get { typingAttributes }
        set {
            if __USING_APPEARANCED_SWIZZING__ {
                self.typingAttributes = newValue
            } else {
                swizzled_setTypingAttributes(newValue)
            }
        }
    }
}

internal extension UITextField {
    static func silenceExchangeTextFieldImplementation() {
        app_swizzing(
            originalSelector: #selector(setter: attributedText),
            newSelector: #selector(swizzled_setAttributedText(_:))
        )
        
        app_swizzing(
            originalSelector: #selector(setter: textColor),
            newSelector: #selector(swizzled_setTextColor(_:))
        )
        
        app_swizzing(
            originalSelector: #selector(setter: defaultTextAttributes),
            newSelector: #selector(swizzled_setDefaultTextAttributes(_:))
        )
        
        app_swizzing(
            originalSelector: #selector(setter: attributedPlaceholder),
            newSelector: #selector(swizzled_setAttributedPlaceholder(_:))
        )
        
        app_swizzing(
            originalSelector: #selector(setter: background),
            newSelector: #selector(swizzled_setBackground(_:))
        )
        
        app_swizzing(
            originalSelector: #selector(setter: disabledBackground),
            newSelector: #selector(swizzled_setDisabledBackground(_:))
        )
        
        app_swizzing(
            originalSelector: #selector(setter: typingAttributes),
            newSelector: #selector(swizzled_setTypingAttributes(_:))
        )
        
    }
}

private extension UITextField {
    func __setAttributedText(_ attributedText: NSAttributedString?) {
        if __USING_APPEARANCED_SWIZZING__ {
            swizzled_setAttributedText(attributedText)
        } else {
            self.attributedText = attributedText
        }
    }
    
    func __setTextColor(_ textColor: UIColor?) {
        if __USING_APPEARANCED_SWIZZING__ {
            swizzled_setTextColor(textColor)
        } else {
            self.textColor = textColor
        }
    }
    
    func __setDefaultTextAttributes(_ defaultTextAttributes: [NSAttributedString.Key: Any]) {
        if __USING_APPEARANCED_SWIZZING__ {
            swizzled_setDefaultTextAttributes(defaultTextAttributes)
        } else {
            self.defaultTextAttributes = defaultTextAttributes
        }
    }
    
    func __setAttributedPlaceholder(_ attributedPlaceholder: NSAttributedString?) {
        if __USING_APPEARANCED_SWIZZING__ {
            swizzled_setAttributedPlaceholder(attributedPlaceholder)
        } else {
            self.attributedPlaceholder = attributedPlaceholder
        }
    }
    
    func __setBackground(_ background: UIImage?) {
        if __USING_APPEARANCED_SWIZZING__ {
            swizzled_setBackground(background)
        } else {
            self.background = background
        }
    }
    
    func __setDisabledBackground(_ disabledBackground: UIImage?) {
        if __USING_APPEARANCED_SWIZZING__ {
            swizzled_setDisabledBackground(disabledBackground)
        } else {
            self.disabledBackground = disabledBackground
        }
    }
    
    func __setTypingAttributes(_ typingAttributes: [NSAttributedString.Key: Any]?) {
        if __USING_APPEARANCED_SWIZZING__ {
            swizzled_setTypingAttributes(typingAttributes)
        } else {
            self.typingAttributes = typingAttributes
        }
    }
    
    
    
    @objc func swizzled_setAttributedText(_ attributedText: NSAttributedString?) {
        cache(
            firstParam: Callable.Attributed(attributedText),
            identifier: .attributedText,
            action: __setAttributedText(_:)
        )
    }
    
    @objc func swizzled_setTextColor(_ textColor: UIColor?) {
        cache(
            firstParam: Callable.Appearanced(textColor),
            identifier: .textColor,
            action: __setTextColor(_:)
        )
    }
    
    @objc func swizzled_setDefaultTextAttributes(_ defaultTextAttributes: [NSAttributedString.Key: Any]) {
        cache(
            firstParam: Callable.Collection(defaultTextAttributes),
            identifier: .defaultTextAttributes,
            action: __setDefaultTextAttributes(_:)
        )
    }
    
    @objc func swizzled_setAttributedPlaceholder(_ attributedPlaceholder: NSAttributedString?) {
        cache(
            firstParam: Callable.Attributed(attributedPlaceholder),
            identifier: .attributedPlaceholder,
            action: __setAttributedPlaceholder(_:)
        )
    }
    
    @objc func swizzled_setBackground(_ background: UIImage?) {
        cache(
            firstParam: Callable.Appearanced(background),
            identifier: .background,
            action: __setBackground(_:)
        )
    }
    
    @objc func swizzled_setDisabledBackground(_ disabledBackground: UIImage?) {
        cache(
            firstParam: Callable.Appearanced(disabledBackground),
            identifier: .disabledBackground,
            action: __setDisabledBackground(_:)
        )
    }
    
    @objc func swizzled_setTypingAttributes(_ typingAttributes: [NSAttributedString.Key: Any]?) {
        cache(
            firstParam: Callable.Collection(typingAttributes),
            identifier: .typingAttributes,
            action: __setTypingAttributes(_:)
        )
    }
}

#endif
