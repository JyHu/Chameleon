//
//  File.swift
//  
//
//  Created by Jo on 2023/4/11.
//

#if os(iOS)

import UIKit

private extension AppearanceCallableIdentifier {
    static let tintColor = "UINavigationBar.__setTintColor(_:)"
    static let barTintColor = "UINavigationBar.__setBarTintColor(_:)"
    static let shadowImage = "UINavigationBar.__setShadowImage(_:)"
    static let titleTextAttributes = "UINavigationBar.__setTitleTextAttributes(_:)"
    static let largeTitleTextAttributes = "UINavigationBar.__setLargeTitleTextAttributes(_:)"
    static let backIndicatorImage = "UINavigationBar.__setBackIndicatorImage(_:)"
    static let backIndicatorTransitionMaskImage = "UINavigationBar.__setBackIndicatorTransitionMaskImage(_:)"
    static let setBackgroundImageForBarPositionBarMetrics = "UINavigationBar.__setBackgroundImage(_:for:barMetrics:)"
    static let setBackgroundImageForBarMetrics = "UINavigationBar.__setBackgroundImage(_:for:)"
}

public extension UINavigationBar {
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
    
    var app_titleTextAttributes: [NSAttributedString.Key: Any]? {
        get { titleTextAttributes }
        set {
            if __USING_APPEARANCED_SWIZZING__ {
                self.titleTextAttributes = newValue
            } else {
                swizzled_setTitleTextAttributes(newValue)
            }
        }
    }
    
    var app_largeTitleTextAttributes: [NSAttributedString.Key: Any]? {
        get { largeTitleTextAttributes }
        set {
            if __USING_APPEARANCED_SWIZZING__ {
                self.largeTitleTextAttributes = newValue
            } else {
                swizzled_setLargeTitleTextAttributes(newValue)
            }
        }
    }
    
    var app_backIndicatorImage: UIImage? {
        get { backIndicatorImage }
        set {
            if __USING_APPEARANCED_SWIZZING__ {
                self.backIndicatorImage = newValue
            } else {
                swizzled_setBackIndicatorImage(newValue)
            }
        }
    }
    
    var app_backIndicatorTransitionMaskImage: UIImage? {
        get { backIndicatorTransitionMaskImage }
        set {
            if __USING_APPEARANCED_SWIZZING__ {
                self.backIndicatorTransitionMaskImage = newValue
            } else {
                swizzled_setBackIndicatorTransitionMaskImage(newValue)
            }
        }
    }
    
    func app_setBackgroundImage(_ backgroundImage: UIImage?, for barPosition: UIBarPosition, barMetrics: UIBarMetrics) {
        if __USING_APPEARANCED_SWIZZING__ {
            setBackgroundImage(backgroundImage, for: barPosition, barMetrics: barMetrics)
        } else {
            swizzled_setBackgroundImage(backgroundImage, for: barPosition, barMetrics: barMetrics)
        }
    }
    
    func app_setBackgroundImage(_ backgroundImage: UIImage?, for barMetrics: UIBarMetrics) {
        if __USING_APPEARANCED_SWIZZING__ {
            setBackgroundImage(backgroundImage, for: barMetrics)
        } else {
            swizzled_setBackgroundImage(backgroundImage, for: barMetrics)
        }
    }
}

internal extension UINavigationBar {
    static func silenceExchangeNavigationBarImplementation() {
        app_swizzing(
            originalSelector: #selector(setter: tintColor),
            newSelector: #selector(swizzled_setTintColor(_:))
        )
        
        app_swizzing(
            originalSelector: #selector(setter: barTintColor),
            newSelector: #selector(swizzled_setBarTintColor(_:))
        )
        
        app_swizzing(
            originalSelector: #selector(setter: shadowImage),
            newSelector: #selector(swizzled_setShadowImage(_:))
        )
        
        app_swizzing(
            originalSelector: #selector(setter: titleTextAttributes),
            newSelector: #selector(swizzled_setTitleTextAttributes(_:))
        )
        
        app_swizzing(
            originalSelector: #selector(setter: largeTitleTextAttributes),
            newSelector: #selector(swizzled_setLargeTitleTextAttributes(_:))
        )
        
        app_swizzing(
            originalSelector: #selector(setter: backIndicatorImage),
            newSelector: #selector(swizzled_setBackIndicatorImage(_:))
        )
        
        app_swizzing(
            originalSelector: #selector(setter: backIndicatorTransitionMaskImage),
            newSelector: #selector(swizzled_setBackIndicatorTransitionMaskImage(_:))
        )
        
        app_swizzing(
            originalSelector: #selector(setBackgroundImage(_:for:barMetrics:)),
            newSelector: #selector(swizzled_setBackgroundImage(_:for:barMetrics:))
        )
        
        app_swizzing(
            originalSelector: #selector(setBackgroundImage(_:for:)),
            newSelector: #selector(swizzled_setBackgroundImage(_:for:))
        )
    }
}

private extension UINavigationBar {
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
    
    func __setShadowImage(_ shadowImage: UIImage?) {
        if __USING_APPEARANCED_SWIZZING__ {
            swizzled_setShadowImage(shadowImage)
        } else {
            self.shadowImage = shadowImage
        }
    }
    
    func __setTitleTextAttributes(_ titleTextAttributes: [NSAttributedString.Key: Any]?) {
        if __USING_APPEARANCED_SWIZZING__ {
            swizzled_setTitleTextAttributes(titleTextAttributes)
        } else {
            self.titleTextAttributes = titleTextAttributes
        }
    }
    
    func __setLargeTitleTextAttributes(_ largeTitleTextAttributes: [NSAttributedString.Key: Any]?) {
        if __USING_APPEARANCED_SWIZZING__ {
            swizzled_setLargeTitleTextAttributes(largeTitleTextAttributes)
        } else {
            self.largeTitleTextAttributes = largeTitleTextAttributes
        }
    }
    
    func __setBackIndicatorImage(_ backIndicatorImage: UIImage?) {
        if __USING_APPEARANCED_SWIZZING__ {
            swizzled_setBackIndicatorImage(backIndicatorImage)
        } else {
            self.backIndicatorImage = backIndicatorImage
        }
    }
    
    func __setBackIndicatorTransitionMaskImage(_ backIndicatorTransitionMaskImage: UIImage?) {
        if __USING_APPEARANCED_SWIZZING__ {
            swizzled_setBackIndicatorTransitionMaskImage(backIndicatorTransitionMaskImage)
        } else {
            self.backIndicatorTransitionMaskImage = backIndicatorTransitionMaskImage
        }
    }
    
    func __setBackgroundImage(_ backgroundImage: UIImage?, for barPosition: UIBarPosition, barMetrics: UIBarMetrics) {
        if __USING_APPEARANCED_SWIZZING__ {
            swizzled_setBackgroundImage(backgroundImage, for: barPosition, barMetrics: barMetrics)
        } else {
            self.setBackgroundImage(backgroundImage, for: barPosition, barMetrics: barMetrics)
        }
    }
    
    func __setBackgroundImage(_ backgroundImage: UIImage?, for barMetrics: UIBarMetrics) {
        if __USING_APPEARANCED_SWIZZING__ {
            swizzled_setBackgroundImage(backgroundImage, for: barMetrics)
        } else {
            self.setBackgroundImage(backgroundImage, for: barMetrics)
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
    
    @objc func swizzled_setShadowImage(_ shadowImage: UIImage?) {
        cache(
            firstParam: Callable.Appearanced(shadowImage),
            identifier: .shadowImage,
            action: __setShadowImage(_:)
        )
    }
    
    @objc func swizzled_setTitleTextAttributes(_ titleTextAttributes: [NSAttributedString.Key: Any]?) {
        cache(
            firstParam: Callable.Collection(titleTextAttributes),
            identifier: .titleTextAttributes,
            action: __setTitleTextAttributes(_:)
        )
    }
    
    @objc func swizzled_setLargeTitleTextAttributes(_ largeTitleTextAttributes: [NSAttributedString.Key: Any]?) {
        cache(
            firstParam: Callable.Collection(largeTitleTextAttributes),
            identifier: .largeTitleTextAttributes,
            action: __setLargeTitleTextAttributes(_:)
        )
    }
    
    @objc func swizzled_setBackIndicatorImage(_ backIndicatorImage: UIImage?) {
        cache(
            firstParam: Callable.Appearanced(backIndicatorImage),
            identifier: .backIndicatorImage,
            action: __setBackIndicatorImage(_:)
        )
    }
    
    @objc func swizzled_setBackIndicatorTransitionMaskImage(_ backIndicatorTransitionMaskImage: UIImage?) {
        cache(
            firstParam: Callable.Appearanced(backIndicatorTransitionMaskImage),
            identifier: .backIndicatorTransitionMaskImage,
            action: __setBackIndicatorTransitionMaskImage(_:)
        )
    }
    
    @objc func swizzled_setBackgroundImage(_ backgroundImage: UIImage?, for barPosition: UIBarPosition, barMetrics: UIBarMetrics) {
        let category = "UINavigationBar.barPosition:\(barPosition.rawValue).barMetrics:\(barMetrics.rawValue)"
        
        cache(
            firstParam: Callable.Appearanced(backgroundImage),
            secondParam: Callable.Original(barPosition),
            thirdParam: Callable.Original(barMetrics),
            identifier: .setBackgroundImageForBarPositionBarMetrics,
            action: __setBackgroundImage(_:for:barMetrics:),
            category: category
        )
    }
    
    @objc func swizzled_setBackgroundImage(_ backgroundImage: UIImage?, for barMetrics: UIBarMetrics) {
        let category = "UINavigationBar.barMetrics:\(barMetrics.rawValue)"
        
        cache(
            firstParam: Callable.Appearanced(backgroundImage),
            secondParam: Callable.Original(barMetrics),
            identifier: .setBackgroundImageForBarMetrics,
            action: __setBackgroundImage(_:for:),
            category: category
        )
    }
}

#endif
