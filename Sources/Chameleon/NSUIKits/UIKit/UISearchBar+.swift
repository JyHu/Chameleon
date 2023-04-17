//
//  File.swift
//  
//
//  Created by Jo on 2023/4/11.
//

#if os(iOS)

import UIKit

private extension AppearanceCallableIdentifier {
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
    /// 不支持alpha通道，设置了也不生效，所以在做单元测试的时候需要注意
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
    
    @objc func swizzled_setBarTintColor(_ barTintColor: UIColor?) {
        cache(
            firstParam: Callable.Appearanced(barTintColor),
            identifier: .barTintColor,
            action: { [weak self] va in self?.__setBarTintColor(va) }
        )
    }
    
    @objc func swizzled_setBackgroundImage(_ backgroundImage: UIImage?) {
        cache(
            firstParam: Callable.Appearanced(backgroundImage),
            identifier: .backgroundImage,
            action: { [weak self] va in self?.__setBackgroundImage(va) }
        )
    }
    
    @objc func swizzled_setScopeBarBackgroundImage(_ scopeBarBackgroundImage: UIImage?) {
        cache(
            firstParam: Callable.Appearanced(scopeBarBackgroundImage),
            identifier: .scopeBarBackgroundImage,
            action: { [weak self] va in self?.__setScopeBarBackgroundImage(va) }
        )
    }
    
    @objc func swizzled_setBackgroundImage(_ backgroundImage: UIImage?, for barPosition: UIBarPosition, barMetrics: UIBarMetrics) {
        cache(
            firstParam: Callable.Appearanced(backgroundImage),
            secondParam: Callable.Original(barPosition),
            thirdParam: Callable.Original(barMetrics),
            identifier: .setBackgroundImageForBarPositionBarMetrics,
            action: { [weak self] va, vb, vc in self?.__setBackgroundImage(va, for: vb, barMetrics: vc) },
            category: "UISearchBar.position:\(barPosition.rawValue).metrics:\(barMetrics.rawValue)"
        )
    }
    
    @objc func swizzled_setSearchFieldBackgroundImage(_ backgroundImage: UIImage?, for state: UIControl.State) {
        cache(
            firstParam: Callable.Appearanced(backgroundImage),
            secondParam: Callable.Original(state),
            identifier: .setSearchFieldBackgroundImageForState,
            action: { [weak self] va, vb in self?.__setSearchFieldBackgroundImage(va, for: vb) },
            category: "UISearchBar.state:\(state.rawValue)"
        )
    }
    
    @objc func swizzled_setImage(_ image: UIImage?, for icon: Icon, state: UIControl.State) {
        let category = "UISearchBar.icon:\(icon.rawValue).state:\(state.rawValue)"
        
        cache(
            firstParam: Callable.Appearanced(image),
            secondParam: Callable.Original(icon),
            thirdParam: Callable.Original(state),
            identifier: .setImageForIconState,
            action: { [weak self] va, vb, vc in self?.__setImage(va, for: vb, state: vc) },
            category: category
        )
    }
    
    @objc func swizzled_setScopeBarButtonBackgroundImage(_ backgroundImage: UIImage?, for state: UIControl.State) {
        cache(
            firstParam: Callable.Appearanced(backgroundImage),
            secondParam: Callable.Original(state),
            identifier: .setScopeBarButtonBackgroundImageForState,
            action: { [weak self] va, vb in self?.__setScopeBarButtonBackgroundImage(va, for: vb) },
            category: "UISearchBar.state:\(state.rawValue)"
        )
    }
    
    @objc func swizzled_setScopeBarButtonDividerImage(_ dividerImage: UIImage?, forLeftSegmentState leftSegmentState: UIControl.State, rightSegmentState: UIControl.State) {
        cache(
            firstParam: Callable.Appearanced(dividerImage),
            secondParam: Callable.Original(leftSegmentState),
            thirdParam: Callable.Original(rightSegmentState),
            identifier: .setScopeBarButtonDividerImageForLeftRight,
            action: { [weak self] va, vb, vc in self?.__setScopeBarButtonDividerImage(va, forLeftSegmentState: vb, rightSegmentState: vc) },
            category: "UISearchBar.left:\(leftSegmentState.rawValue).right:\(rightSegmentState.rawValue)"
        )
    }
    
    @objc func swizzled_setScopeBarButtonTitleTextAttributes(_ attributes: [NSAttributedString.Key: Any]?, for state: UIControl.State) {
        cache(
            firstParam: Callable.Collection(attributes),
            secondParam: Callable.Original(state),
            identifier: .setScopeBarButtonTitleTextAttributesForState,
            action: { [weak self] va, vb in self?.__setScopeBarButtonTitleTextAttributes(va, for: vb) },
            category: "UISearchBar.state:\(state.rawValue)"
        )
    }
}

#endif
