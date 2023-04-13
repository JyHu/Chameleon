//
//  File.swift
//  
//
//  Created by Jo on 2023/4/6.
//

#if canImport(UIKit)

import UIKit

private extension AppearanceCallableIdentifier {
    static let tintColor = "UIButton.__setTintColor(_:)"
    static let setTitleColorForState = "UIButton.__setTitleColor(_:for:)"
    static let setImageForState = "UIButton.__setImage(_:for:)"
    static let setBackgroundImageForState = "UIButton.__setBackgroundImage(_:for:)"
    static let setAttributedTitleForState = "UIButton.__setAttributedTitle(_:for:)"
}

public extension UIButton {
    var app_tintColor: UIColor {
        get { tintColor }
        set {
            if __USING_APPEARANCED_SWIZZING__ {
                self.tintColor = newValue
            } else {
                swizzled_setTintColor(newValue)
            }
        }
    }
    
    func app_setTitleColor(_ titleColor: UIColor?, for state: State) {
        if __USING_APPEARANCED_SWIZZING__ {
            setTitleColor(titleColor, for: state)
        } else {
            swizzled_setTitleColor(titleColor, for: state)
        }
    }
    
    func app_setImage(_ image: UIImage?, for state: State) {
        if __USING_APPEARANCED_SWIZZING__ {
            setImage(image, for: state)
        } else {
            swizzled_setImage(image, for: state)
        }
    }
    
    func app_setBackgroundImage(_ backgroundImage: UIImage?, for state: State) {
        if __USING_APPEARANCED_SWIZZING__ {
            setBackgroundImage(backgroundImage, for: state)
        }
    }
    
    func app_setAttributedTitle(_ attributedTitle: NSAttributedString?, for state: State) {
        if __USING_APPEARANCED_SWIZZING__ {
            setAttributedTitle(attributedTitle, for: state)
        } else {
            swizzled_setAttributedTitle(attributedTitle, for: state)
        }
    }
}

internal extension UIButton {
    static func silenceExchangeButtonImplementation() {
        app_swizzing(
            originalSelector: #selector(setter: tintColor),
            newSelector: #selector(swizzled_setTintColor(_:))
        )
        
        app_swizzing(
            originalSelector: #selector(setTitleColor(_:for:)),
            newSelector: #selector(swizzled_setTitleColor(_:for:))
        )
        
        app_swizzing(
            originalSelector: #selector(setImage(_:for:)),
            newSelector: #selector(swizzled_setImage(_:for:))
        )
        
        app_swizzing(
            originalSelector: #selector(setBackgroundImage(_:for:)),
            newSelector: #selector(swizzled_setBackgroundImage(_:for:))
        )
        
        app_swizzing(
            originalSelector: #selector(setAttributedTitle(_:for:)),
            newSelector: #selector(swizzled_setAttributedTitle(_:for:))
        )
    }
}

private extension UIButton {
    func __setTintColor(_ tintColor: UIColor) {
        if __USING_APPEARANCED_SWIZZING__ {
            swizzled_setTintColor(tintColor)
        } else {
            self.tintColor = tintColor
        }
    }
    
    func __setTitleColor(_ titleColor: UIColor?, for state: State) {
        if __USING_APPEARANCED_SWIZZING__ {
            swizzled_setTitleColor(titleColor, for: state)
        } else {
            setTitleColor(titleColor, for: state)
        }
    }
    
    func __setImage(_ image: UIImage?, for state: State) {
        if __USING_APPEARANCED_SWIZZING__ {
            swizzled_setImage(image, for: state)
        } else {
            setImage(image, for: state)
        }
    }
    
    func __setBackgroundImage(_ backgroundImage: UIImage?, for state: State) {
        if __USING_APPEARANCED_SWIZZING__ {
            swizzled_setBackgroundImage(backgroundImage, for: state)
        } else {
            setBackgroundImage(backgroundImage, for: state)
        }
    }
    
    func __setAttributedTitle(_ attributedTitle: NSAttributedString?, for state: State) {
        if __USING_APPEARANCED_SWIZZING__ {
            swizzled_setAttributedTitle(attributedTitle, for: state)
        } else {
            setAttributedTitle(attributedTitle, for: state)
        }
    }
    
    @objc func swizzled_setTintColor(_ tintColor: UIColor) {
        cache(
            firstParam: Callable.Appearanced(tintColor),
            identifier: .tintColor,
            action: __setTintColor(_:)
        )
    }
    
    @objc func swizzled_setTitleColor(_ titleColor: UIColor?, for state: State) {
        cache(
            firstParam: Callable.Appearanced(titleColor),
            secondParam: Callable.Original(state),
            identifier: .setTitleColorForState,
            action: __setTitleColor(_:for:),
            category: "UIButton.state:\(state.rawValue)"
        )
    }
    
    @objc func swizzled_setImage(_ image: UIImage?, for state: State) {
        cache(
            firstParam: Callable.Appearanced(image),
            secondParam: Callable.Original(state),
            identifier: .setImageForState,
            action: __setImage(_:for:),
            category: "UIButton.state:\(state.rawValue)"
        )
    }
    
    @objc func swizzled_setBackgroundImage(_ backgroundImage: UIImage?, for state: State) {
        cache(
            firstParam: Callable.Appearanced(backgroundImage),
            secondParam: Callable.Original(state),
            identifier: .setBackgroundImageForState,
            action: __setBackgroundImage(_:for:),
            category: "UIButton.state:\(state.rawValue)"
        )
    }
    
    @objc func swizzled_setAttributedTitle(_ attributedTitle: NSAttributedString?, for state: State) {
        cache(
            firstParam: Callable.Attributed(attributedTitle),
            secondParam: Callable.Original(state),
            identifier: .setAttributedTitleForState,
            action: __setAttributedTitle(_:for:),
            category: "UIButton.state:\(state.rawValue)"
        )
    }
}

#endif
