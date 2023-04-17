//
//  File.swift
//  
//
//  Created by Jo on 2023/4/11.
//

#if os(iOS)

import UIKit

private extension AppearanceCallableIdentifier {
    static let barTintColor = "UITabBar.__setBarTintColor(_:)"
    static let unselectedItemTintColor = "UITabBar.__setUnselectedItemTintColor(_:)"
    static let backgroundImage = "UITabBar.__setBackgroundImage(_:)"
    static let selectionIndicatorImage = "UITabBar.__setSelectionIndicatorImage(_:)"
    static let shadowImage = "UITabBar.__setShadowImage(_:)"
}

public extension UITabBar {
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
    
    var app_unselectedItemTintColor: UIColor? {
        get { unselectedItemTintColor }
        set {
            if __USING_APPEARANCED_SWIZZING__ {
                self.unselectedItemTintColor = newValue
            } else {
                swizzled_setUnselectedItemTintColor(newValue)
            }
        }
    }
    
    var app_backgroundImage: UIImage? {
        get { backgroundImage }
        set {
            if __USING_APPEARANCED_SWIZZING__ {
                self.backgroundImage = newValue
            } else {
                swizzled_setBackgroundImage(newValue)
            }
        }
    }
    
    var app_selectionIndicatorImage: UIImage? {
        get { selectionIndicatorImage }
        set {
            if __USING_APPEARANCED_SWIZZING__ {
                self.selectionIndicatorImage = newValue
            } else {
                swizzled_setSelectionIndicatorImage(newValue)
            }
        }
    }
    
    var app_shadowImage: UIImage? {
        get { shadowImage }
        set {
            if __USING_APPEARANCED_SWIZZING__ {
                self.shadowImage = newValue
            } else {
                swizzled_setShadowImage(newValue)
            }
        }
    }
}

internal extension UITabBar {
    static func silenceExchangeTabBarImplementation() {
        app_swizzing(
            originalSelector: #selector(setter: barTintColor),
            newSelector: #selector(swizzled_setBarTintColor(_:))
        )
        
        app_swizzing(
            originalSelector: #selector(setter: unselectedItemTintColor),
            newSelector: #selector(swizzled_setUnselectedItemTintColor(_:))
        )
        
        app_swizzing(
            originalSelector: #selector(setter: backgroundImage),
            newSelector: #selector(swizzled_setBackgroundImage(_:))
        )
        
        app_swizzing(
            originalSelector: #selector(setter: selectionIndicatorImage),
            newSelector: #selector(swizzled_setSelectionIndicatorImage(_:))
        )
        
        app_swizzing(
            originalSelector: #selector(setter: shadowImage),
            newSelector: #selector(swizzled_setShadowImage(_:))
        )
    }
}

private extension UITabBar {
    func __setBarTintColor(_ barTintColor: UIColor?) {
        if __USING_APPEARANCED_SWIZZING__ {
            swizzled_setBarTintColor(barTintColor)
        } else {
            self.barTintColor = barTintColor
        }
    }
    
    func __setUnselectedItemTintColor(_ unselectedItemTintColor: UIColor?) {
        if __USING_APPEARANCED_SWIZZING__ {
            swizzled_setUnselectedItemTintColor(unselectedItemTintColor)
        } else {
            self.unselectedItemTintColor = unselectedItemTintColor
        }
    }
    
    func __setBackgroundImage(_ backgroundImage: UIImage?) {
        if __USING_APPEARANCED_SWIZZING__ {
            swizzled_setBackgroundImage(backgroundImage)
        } else {
            self.backgroundImage = backgroundImage
        }
    }
    
    func __setSelectionIndicatorImage(_ selectionIndicatorImage: UIImage?) {
        if __USING_APPEARANCED_SWIZZING__ {
            swizzled_setSelectionIndicatorImage(selectionIndicatorImage)
        } else {
            self.selectionIndicatorImage = selectionIndicatorImage
        }
    }
    
    func __setShadowImage(_ shadowImage: UIImage?) {
        if __USING_APPEARANCED_SWIZZING__ {
            swizzled_setShadowImage(shadowImage)
        } else {
            self.shadowImage = shadowImage
        }
    }

    @objc func swizzled_setBarTintColor(_ barTintColor: UIColor?) {
        cache(
            firstParam: Callable.Appearanced(barTintColor),
            identifier: .barTintColor,
            action: { [weak self] va in self?.__setBarTintColor(va) }
        )
    }
    
    @objc func swizzled_setUnselectedItemTintColor(_ unselectedItemTintColor: UIColor?) {
        cache(
            firstParam: Callable.Appearanced(unselectedItemTintColor),
            identifier: .unselectedItemTintColor,
            action: { [weak self] va in self?.__setUnselectedItemTintColor(va) }
        )
    }
    
    @objc func swizzled_setBackgroundImage(_ backgroundImage: UIImage?) {
        cache(
            firstParam: Callable.Appearanced(backgroundImage),
            identifier: .backgroundImage,
            action: { [weak self] va in self?.__setBackgroundImage(va) }
        )
    }
    
    @objc func swizzled_setSelectionIndicatorImage(_ selectionIndicatorImage: UIImage?) {
        cache(
            firstParam: Callable.Appearanced(selectionIndicatorImage),
            identifier: .selectionIndicatorImage,
            action: { [weak self] va in self?.__setSelectionIndicatorImage(va) }
        )
    }
    
    @objc func swizzled_setShadowImage(_ shadowImage: UIImage?) {
        cache(
            firstParam: Callable.Appearanced(shadowImage),
            identifier: .shadowImage,
            action: { [weak self] va in self?.__setShadowImage(va) }
        )
    }
}

#endif
