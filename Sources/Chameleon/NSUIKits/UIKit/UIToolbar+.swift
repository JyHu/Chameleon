//
//  File.swift
//  
//
//  Created by Jo on 2023/4/11.
//

#if os(iOS)

import UIKit

private extension AppearanceCallableIdentifier {
    static let tintColor = "__setTintColor(_:)"
    static let barTintColor = "__setBarTintColor(_:)"
    static let setBackgroundImageForPositionMetrics = "__setBackgroundImage(_:forToolbarPosition:barMetrics:)"
    static let setShadowImageFor = "__setShadowImage(_:forToolbarPosition:)"
}

public extension UIToolbar {
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
    
    var app_barTintColor: UIColor? {
        get { barTintColor }
        set {
            if __USING_APPEARANCED_SWIZZING__ {
                self.barTintColor = newValue
            } else {
                swizzled_setBarTintColor(newValue)
            }
        }
    }
    
    func app_setBackgroundImage(_ backgroundImage: UIImage?, forToolbarPosition position: UIBarPosition, barMetrics: UIBarMetrics) {
        if __USING_APPEARANCED_SWIZZING__ {
            setBackgroundImage(backgroundImage, forToolbarPosition: position, barMetrics: barMetrics)
        } else {
            swizzled_setBackgroundImage(backgroundImage, forToolbarPosition: position, barMetrics: barMetrics)
        }
    }
    
    func app_setShadowImage(_ shadowImage: UIImage?, forToolbarPosition position: UIBarPosition) {
        if __USING_APPEARANCED_SWIZZING__ {
            setShadowImage(shadowImage, forToolbarPosition: position)
        } else {
            swizzled_setShadowImage(shadowImage, forToolbarPosition: position)
        }
    }
}

internal extension UIToolbar {
    static func silenceExchangeToolbarImplementation() {
        app_swizzing(
            originalSelector: #selector(setter: tintColor),
            newSelector: #selector(swizzled_setTintColor(_:))
        )
        
        app_swizzing(
            originalSelector: #selector(setter: barTintColor),
            newSelector: #selector(swizzled_setBarTintColor(_:))
        )
        
        app_swizzing(
            originalSelector: #selector(setBackgroundImage(_:forToolbarPosition:barMetrics:)),
            newSelector: #selector(swizzled_setBackgroundImage(_:forToolbarPosition:barMetrics:))
        )
        
        app_swizzing(
            originalSelector: #selector(setShadowImage(_:forToolbarPosition:)),
            newSelector: #selector(swizzled_setShadowImage(_:forToolbarPosition:))
        )
    }
}

private extension UIToolbar {
    func __setTintColor(_ tintColor: UIColor) {
        if __USING_APPEARANCED_SWIZZING__ {
            swizzled_setTintColor(tintColor)
        } else {
            self.tintColor = tintColor
        }
    }
    
    func __setBarTintColor(_ barTintColor: UIColor?) {
        if __USING_APPEARANCED_SWIZZING__ {
            swizzled_setBarTintColor(barTintColor)
        } else {
            self.barTintColor = barTintColor
        }
    }
    
    func __setBackgroundImage(_ backgroundImage: UIImage?, forToolbarPosition position: UIBarPosition, barMetrics: UIBarMetrics) {
        if __USING_APPEARANCED_SWIZZING__ {
            swizzled_setBackgroundImage(backgroundImage, forToolbarPosition: position, barMetrics: barMetrics)
        } else {
            setBackgroundImage(backgroundImage, forToolbarPosition: position, barMetrics: barMetrics)
        }
    }
    
    func __setShadowImage(_ shadowImage: UIImage?, forToolbarPosition position: UIBarPosition) {
        if __USING_APPEARANCED_SWIZZING__ {
            swizzled_setShadowImage(shadowImage, forToolbarPosition: position)
        } else {
            setShadowImage(shadowImage, forToolbarPosition: position)
        }
    }
    
    
    @objc func swizzled_setTintColor(_ tintColor: UIColor) {
        cache(
            firstParam: Callable.Appearanced(tintColor),
            identifier: .tintColor,
            action: __setTintColor(_:)
        )
    }
    
    @objc func swizzled_setBarTintColor(_ barTintColor: UIColor?) {
        cache(
            firstParam: Callable.Appearanced(barTintColor),
            identifier: .barTintColor,
            action: __setBarTintColor(_:)
        )
    }
    
    @objc func swizzled_setBackgroundImage(_ backgroundImage: UIImage?, forToolbarPosition position: UIBarPosition, barMetrics: UIBarMetrics) {
        cache(
            firstParam: Callable.Appearanced(backgroundImage),
            secondParam: Callable.Mediator(position),
            thirdParam: Callable.Mediator(barMetrics),
            identifier: .setBackgroundImageForPositionMetrics,
            action: __setBackgroundImage(_:forToolbarPosition:barMetrics:),
            category: "UIToolBar.position:\(position.rawValue).metrics:\(barMetrics.rawValue)"
        )
    }
    
    @objc func swizzled_setShadowImage(_ shadowImage: UIImage?, forToolbarPosition position: UIBarPosition) {
        cache(
            firstParam: Callable.Appearanced(shadowImage),
            secondParam: Callable.Mediator(position),
            identifier: .setShadowImageFor,
            action: __setShadowImage(_:forToolbarPosition:),
            category: "UIToolBar.position:\(position.rawValue)"
        )
    }
}

#endif
