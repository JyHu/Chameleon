//
//  File.swift
//  
//
//  Created by Jo on 2023/4/11.
//

#if os(iOS)

import UIKit

private extension AppearanceCallableIdentifier {
    static let barTintColor = "__setBarTintColor(_:)"
    static let setBackgroundImageForPositionMetrics = "__setBackgroundImage(_:forToolbarPosition:barMetrics:)"
    static let setShadowImageFor = "__setShadowImage(_:forToolbarPosition:)"
}

public extension UIToolbar {
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
    
    @objc func swizzled_setBarTintColor(_ barTintColor: UIColor?) {
        cache(
            firstParam: Callable.Appearanced(barTintColor),
            identifier: .barTintColor,
            action: { [weak self] va in self?.__setBarTintColor(va) }
        )
    }
    
    @objc func swizzled_setBackgroundImage(_ backgroundImage: UIImage?, forToolbarPosition position: UIBarPosition, barMetrics: UIBarMetrics) {
        cache(
            firstParam: Callable.Appearanced(backgroundImage),
            secondParam: Callable.Original(position),
            thirdParam: Callable.Original(barMetrics),
            identifier: .setBackgroundImageForPositionMetrics,
            action: { [weak self] va, vb, vc in self?.__setBackgroundImage(va, forToolbarPosition: vb, barMetrics: vc) },
            category: "UIToolBar.position:\(position.rawValue).metrics:\(barMetrics.rawValue)"
        )
    }
    
    @objc func swizzled_setShadowImage(_ shadowImage: UIImage?, forToolbarPosition position: UIBarPosition) {
        cache(
            firstParam: Callable.Appearanced(shadowImage),
            secondParam: Callable.Original(position),
            identifier: .setShadowImageFor,
            action: { [weak self] va, vb in self?.__setShadowImage(va, forToolbarPosition: vb) },
            category: "UIToolBar.position:\(position.rawValue)"
        )
    }
}

#endif
