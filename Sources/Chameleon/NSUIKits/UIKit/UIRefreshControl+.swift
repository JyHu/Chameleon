//
//  File.swift
//  
//
//  Created by Jo on 2023/4/11.
//

#if os(iOS)

import UIKit

private extension AppearanceCallableIdentifier {
    static let tintColor = "UIRefreshControl.__setTintColor(_:)"
    static let attributedTitle = "UIRefreshControl.__setAttributedTitle(_:)"
}

public extension UIRefreshControl {
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
    
    var app_attributedTitle: NSAttributedString? {
        get { attributedTitle }
        set {
            if __USING_APPEARANCED_SWIZZING__ {
                self.attributedTitle = newValue
            } else {
                swizzled_setAttributedTitle(newValue)
            }
        }
    }
}

internal extension UIRefreshControl {
    static func silenceExchangeRefreshControlImplementation() {
        app_swizzing(
            originalSelector: #selector(setter: tintColor),
            newSelector: #selector(swizzled_setTintColor(_:))
        )
        
        app_swizzing(
            originalSelector: #selector(setter: attributedTitle),
            newSelector: #selector(swizzled_setAttributedTitle(_:))
        )
    }
}


private extension UIRefreshControl {
    func __setTintColor(_ tintColor: UIColor) {
        if __USING_APPEARANCED_SWIZZING__ {
            swizzled_setTintColor(tintColor)
        } else {
            self.tintColor = tintColor
        }
    }
    
    func __setAttributedTitle(_ attributedTitle: NSAttributedString?) {
        if __USING_APPEARANCED_SWIZZING__ {
            swizzled_setAttributedTitle(attributedTitle)
        } else {
            self.attributedTitle = attributedTitle
        }
    }
    
    @objc func swizzled_setTintColor(_ tintColor: UIColor) {
        cache(
            firstParam: Callable.Appearanced(tintColor),
            identifier: .tintColor,
            action: __setTintColor(_:)
        )
    }
    
    @objc func swizzled_setAttributedTitle(_ attributedTitle: NSAttributedString?) {
        cache(
            firstParam: Callable.Appearanced(attributedTitle),
            identifier: .attributedTitle,
            action: __setAttributedTitle(_:)
        )
    }
}

#endif
