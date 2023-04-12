//
//  File.swift
//  
//
//  Created by Jo on 2023/4/11.
//

#if os(iOS)

import UIKit

private extension AppearanceCallableIdentifier {
    static let tintColor = "UISearchBar.__setTintColor(_:)"
    static let barTintColor = "UISearchBar.__setBarTintColor(_:)"
    static let backgroundImage = "UISearchBar.__setBackgroundImage(_:)"
    static let scopeBarBackgroundImage = "UISearchBar.__setScopeBarBackgroundImage(_:)"
    static let setBackgroundImageForBarPositionBarMetrics = "UISearchBar.__setBackgroundImage(_:for:barMetrics:)"
    static let setSearchFieldBackgroundImageForState = "UISearchBar.__setSearchFieldBackgroundImage(_:for:)"
    static let setImageForIconState = "UISearchBar.__setImage(_:for:state:)"
    static let setScopeBarButtonBackgroundImageForState = "UISearchBar.__setScopeBarButtonBackgroundImage(_:for:)"
    static let setScopeBarButtonDividerImageForLeftRight = "UISearchBar.__setScopeBarButtonDividerImage(_:forLeftSegmentState:rightSegmentState:)"
    static let setScopeBarButtonTitleTextAttributesForState = "UISearchBar.__setScopeBarButtonTitleTextAttributes(_:for:)"
}

public extension UISearchBar {
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
    
    var app_scopeBarBackgroundImage: UIImage? {
        get { scopeBarBackgroundImage }
        set {
            if __USING_APPEARANCED_SWIZZING__ {
                self.scopeBarBackgroundImage = newValue
            } else {
                swizzled_setScopeBarBackgroundImage(newValue)
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
    
    func app_setSearchFieldBackgroundImage(_ backgroundImage: UIImage?, for state: UIControl.State) {
        if __USING_APPEARANCED_SWIZZING__ {
            setSearchFieldBackgroundImage(backgroundImage, for: state)
        } else {
            swizzled_setSearchFieldBackgroundImage(backgroundImage, for: state)
        }
    }
    
    func app_setImage(_ image: UIImage?, for icon: Icon, state: UIControl.State) {
        if __USING_APPEARANCED_SWIZZING__ {
            setImage(image, for: icon, state: state)
        } else {
            swizzled_setImage(image, for: icon, state: state)
        }
    }
    
    func app_setScopeBarButtonBackgroundImage(_ backgroundImage: UIImage?, for state: UIControl.State) {
        if __USING_APPEARANCED_SWIZZING__ {
            setScopeBarButtonBackgroundImage(backgroundImage, for: state)
        } else {
            swizzled_setScopeBarButtonBackgroundImage(backgroundImage, for: state)
        }
    }
    
    func app_setScopeBarButtonDividerImage(_ dividerImage: UIImage?, forLeftSegmentState leftSegmentState: UIControl.State, rightSegmentState: UIControl.State) {
        if __USING_APPEARANCED_SWIZZING__ {
            setScopeBarButtonDividerImage(dividerImage, forLeftSegmentState: leftSegmentState, rightSegmentState: rightSegmentState)
        } else {
            swizzled_setScopeBarButtonDividerImage(dividerImage, forLeftSegmentState: leftSegmentState, rightSegmentState: rightSegmentState)
        }
    }
    
    func app_setScopeBarButtonTitleTextAttributes(_ attributes: [NSAttributedString.Key: Any]?, for state: UIControl.State) {
        if __USING_APPEARANCED_SWIZZING__ {
            setScopeBarButtonTitleTextAttributes(attributes, for: state)
        } else {
            swizzled_setScopeBarButtonTitleTextAttributes(attributes, for: state)
        }
    }
}

internal extension UISearchBar {
    static func silenceExchangeSearchBarImplementation() {
        app_swizzing(
            originalSelector: #selector(setter: tintColor),
            newSelector: #selector(swizzled_setTintColor(_:))
        )
        
        app_swizzing(
            originalSelector: #selector(setter: barTintColor),
            newSelector: #selector(swizzled_setBarTintColor(_:))
        )
        
        app_swizzing(
            originalSelector: #selector(setter: backgroundImage),
            newSelector: #selector(swizzled_setBackgroundImage(_:))
        )
        
        app_swizzing(
            originalSelector: #selector(setter: scopeBarBackgroundImage),
            newSelector: #selector(swizzled_setScopeBarBackgroundImage(_:))
        )
        
        app_swizzing(
            originalSelector: #selector(setBackgroundImage(_:for:barMetrics:)),
            newSelector: #selector(swizzled_setBackgroundImage(_:for:barMetrics:))
        )
        
        app_swizzing(
            originalSelector: #selector(setSearchFieldBackgroundImage(_:for:)),
            newSelector: #selector(swizzled_setSearchFieldBackgroundImage(_:for:))
        )
        
        app_swizzing(
            originalSelector: #selector(setImage(_:for:state:)),
            newSelector: #selector(swizzled_setImage(_:for:state:))
        )
        
        app_swizzing(
            originalSelector: #selector(setScopeBarButtonBackgroundImage(_:for:)),
            newSelector: #selector(swizzled_setScopeBarButtonBackgroundImage(_:for:))
        )
        
        app_swizzing(
            originalSelector: #selector(setScopeBarButtonDividerImage(_:forLeftSegmentState:rightSegmentState:)),
            newSelector: #selector(swizzled_setScopeBarButtonDividerImage(_:forLeftSegmentState:rightSegmentState:))
        )
        
        app_swizzing(
            originalSelector: #selector(setScopeBarButtonTitleTextAttributes(_:for:)),
            newSelector: #selector(swizzled_setScopeBarButtonTitleTextAttributes(_:for:))
        )
    }
}

private extension UISearchBar {
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
    
    func __setBackgroundImage(_ backgroundImage: UIImage?) {
        if __USING_APPEARANCED_SWIZZING__ {
            swizzled_setBackgroundImage(backgroundImage)
        } else {
            self.backgroundImage = backgroundImage
        }
    }
    
    func __setScopeBarBackgroundImage(_ scopeBarBackgroundImage: UIImage?) {
        if __USING_APPEARANCED_SWIZZING__ {
            swizzled_setScopeBarBackgroundImage(scopeBarBackgroundImage)
        } else {
            self.scopeBarBackgroundImage = scopeBarBackgroundImage
        }
    }
    
    func __setBackgroundImage(_ backgroundImage: UIImage?, for barPosition: UIBarPosition, barMetrics: UIBarMetrics) {
        if __USING_APPEARANCED_SWIZZING__ {
            swizzled_setBackgroundImage(backgroundImage, for: barPosition, barMetrics: barMetrics)
        } else {
            setBackgroundImage(backgroundImage, for: barPosition, barMetrics: barMetrics)
        }
    }
    
    func __setSearchFieldBackgroundImage(_ backgroundImage: UIImage?, for state: UIControl.State) {
        if __USING_APPEARANCED_SWIZZING__ {
            swizzled_setSearchFieldBackgroundImage(backgroundImage, for: state)
        } else {
            setSearchFieldBackgroundImage(backgroundImage, for: state)
        }
    }
    
    func __setImage(_ image: UIImage?, for icon: Icon, state: UIControl.State) {
        if __USING_APPEARANCED_SWIZZING__ {
            swizzled_setImage(image, for: icon, state: state)
        } else {
            setImage(image, for: icon, state: state)
        }
    }
    
    func __setScopeBarButtonBackgroundImage(_ backgroundImage: UIImage?, for state: UIControl.State) {
        if __USING_APPEARANCED_SWIZZING__ {
            swizzled_setScopeBarButtonBackgroundImage(backgroundImage, for: state)
        } else {
            setScopeBarButtonBackgroundImage(backgroundImage, for: state)
        }
    }
    
    func __setScopeBarButtonDividerImage(_ dividerImage: UIImage?, forLeftSegmentState leftSegmentState: UIControl.State, rightSegmentState: UIControl.State) {
        if __USING_APPEARANCED_SWIZZING__ {
            swizzled_setScopeBarButtonDividerImage(dividerImage, forLeftSegmentState: leftSegmentState, rightSegmentState: rightSegmentState)
        } else {
            setScopeBarButtonDividerImage(dividerImage, forLeftSegmentState: leftSegmentState, rightSegmentState: rightSegmentState)
        }
    }
    
    func __setScopeBarButtonTitleTextAttributes(_ attributes: [NSAttributedString.Key: Any]?, for state: UIControl.State) {
        if __USING_APPEARANCED_SWIZZING__ {
            swizzled_setScopeBarButtonTitleTextAttributes(attributes, for: state)
        } else {
            setScopeBarButtonTitleTextAttributes(attributes, for: state)
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
    
    @objc func swizzled_setBackgroundImage(_ backgroundImage: UIImage?) {
        cache(
            firstParam: Callable.Appearanced(backgroundImage),
            identifier: .backgroundImage,
            action: __setBackgroundImage(_:)
        )
    }
    
    @objc func swizzled_setScopeBarBackgroundImage(_ scopeBarBackgroundImage: UIImage?) {
        cache(
            firstParam: Callable.Appearanced(scopeBarBackgroundImage),
            identifier: .scopeBarBackgroundImage,
            action: __setScopeBarBackgroundImage(_:)
        )
    }
    
    @objc func swizzled_setBackgroundImage(_ backgroundImage: UIImage?, for barPosition: UIBarPosition, barMetrics: UIBarMetrics) {
        cache(
            firstParam: Callable.Appearanced(backgroundImage),
            secondParam: Callable.Mediator(barPosition),
            thirdParam: Callable.Mediator(barMetrics),
            identifier: .setBackgroundImageForBarPositionBarMetrics,
            action: __setBackgroundImage(_:for:barMetrics:),
            category: "UISearchBar.position:\(barPosition.rawValue).metrics:\(barMetrics.rawValue)"
        )
    }
    
    @objc func swizzled_setSearchFieldBackgroundImage(_ backgroundImage: UIImage?, for state: UIControl.State) {
        cache(
            firstParam: Callable.Appearanced(backgroundImage),
            secondParam: Callable.Mediator(state),
            identifier: .setSearchFieldBackgroundImageForState,
            action: __setSearchFieldBackgroundImage(_:for:),
            category: "UISearchBar.state:\(state.rawValue)"
        )
    }
    
    @objc func swizzled_setImage(_ image: UIImage?, for icon: Icon, state: UIControl.State) {
        let category = "UISearchBar.icon:\(icon.rawValue).state:\(state.rawValue)"
        
        cache(
            firstParam: Callable.Appearanced(image),
            secondParam: Callable.Mediator(icon),
            thirdParam: Callable.Mediator(state),
            identifier: .setImageForIconState,
            action: __setImage(_:for:state:),
            category: category
        )
    }
    
    @objc func swizzled_setScopeBarButtonBackgroundImage(_ backgroundImage: UIImage?, for state: UIControl.State) {
        cache(
            firstParam: Callable.Appearanced(backgroundImage),
            secondParam: Callable.Mediator(state),
            identifier: .setScopeBarButtonBackgroundImageForState,
            action: __setScopeBarButtonBackgroundImage(_:for:),
            category: "UISearchBar.state:\(state.rawValue)"
        )
    }
    
    @objc func swizzled_setScopeBarButtonDividerImage(_ dividerImage: UIImage?, forLeftSegmentState leftSegmentState: UIControl.State, rightSegmentState: UIControl.State) {
        cache(
            firstParam: Callable.Appearanced(dividerImage),
            secondParam: Callable.Mediator(leftSegmentState),
            thirdParam: Callable.Mediator(rightSegmentState),
            identifier: .setScopeBarButtonDividerImageForLeftRight,
            action: __setScopeBarButtonDividerImage(_:forLeftSegmentState:rightSegmentState:),
            category: "UISearchBar.left:\(leftSegmentState.rawValue).right:\(rightSegmentState.rawValue)"
        )
    }
    
    @objc func swizzled_setScopeBarButtonTitleTextAttributes(_ attributes: [NSAttributedString.Key: Any]?, for state: UIControl.State) {
        cache(
            firstParam: Callable.Collection(attributes),
            secondParam: Callable.Mediator(state),
            identifier: .setScopeBarButtonTitleTextAttributesForState,
            action: __setScopeBarButtonTitleTextAttributes(_:for:),
            category: "UISearchBar.state:\(state.rawValue)"
        )
    }
}

#endif
