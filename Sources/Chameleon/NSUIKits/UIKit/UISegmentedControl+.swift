//
//  File.swift
//  
//
//  Created by Jo on 2023/4/11.
//

#if os(iOS)

import UIKit

private extension AppearanceCallableIdentifier {
    static let setImageForSegmentAt = "UISegmentedControl.__setImage(_:forSegmentAt:)"
    static let setBackgroundImageForBarMetrics = "UISegmentedControl.__setBackgroundImage(_:for:barMetrics:)"
    static let setDividerImageForLeftRightBarMetrics = "UISegmentedControl.__setDividerImage(_:forLeftSegmentState:rightSegmentState:barMetrics:)"
    static let setTitleAttributesFor = "UISegmentedControl.__setTitleTextAttributes(_:for:)"
}

public extension UISegmentedControl {
    func app_setImage(_ image: UIImage?, forSegmentAt index: Int) {
        if __USING_APPEARANCED_SWIZZING__ {
            setImage(image, forSegmentAt: index)
        } else {
            swizzled_setImage(image, forSegmentAt: index)
        }
    }
    
    func app_setBackgroundImage(_ backgroundImage: UIImage?, for state: UIControl.State, barMetrics: UIBarMetrics) {
        if __USING_APPEARANCED_SWIZZING__ {
            setBackgroundImage(backgroundImage, for: state, barMetrics: barMetrics)
        } else {
            swizzled_setBackgroundImage(backgroundImage, for: state, barMetrics: barMetrics)
        }
    }
    
    func app_setDividerImage(_ dividerImage: UIImage?, forLeftSegmentState leftSegmentState: UIControl.State, rightSegmentState: UIControl.State, barMetrics: UIBarMetrics) {
        if __USING_APPEARANCED_SWIZZING__ {
            setDividerImage(dividerImage, forLeftSegmentState: leftSegmentState, rightSegmentState: rightSegmentState, barMetrics: barMetrics)
        } else {
            swizzled_setDividerImage(dividerImage, forLeftSegmentState: leftSegmentState, rightSegmentState: rightSegmentState, barMetrics: barMetrics)
        }
    }
    
    func app_setTitleTextAttributes(_ attributes: [NSAttributedString.Key: Any]?, for state: UIControl.State) {
        if __USING_APPEARANCED_SWIZZING__ {
            setTitleTextAttributes(attributes, for: state)
        } else {
            swizzled_setTitleTextAttributes(attributes, for: state)
        }
    }
}

internal extension UISegmentedControl {
    static func silenceExchangeSegmentedControlImplementation() {
        app_swizzing(
            originalSelector: #selector(setImage(_:forSegmentAt:)),
            newSelector: #selector(swizzled_setImage(_:forSegmentAt:))
        )
        
        app_swizzing(
            originalSelector: #selector(setBackgroundImage(_:for:barMetrics:)),
            newSelector: #selector(swizzled_setBackgroundImage(_:for:barMetrics:))
        )
        
        app_swizzing(
            originalSelector: #selector(setDividerImage(_:forLeftSegmentState:rightSegmentState:barMetrics:)),
            newSelector: #selector(swizzled_setDividerImage(_:forLeftSegmentState:rightSegmentState:barMetrics:))
        )
        
        app_swizzing(
            originalSelector: #selector(setTitleTextAttributes(_:for:)),
            newSelector: #selector(swizzled_setTitleTextAttributes(_:for:))
        )
    }
}

private extension UISegmentedControl {
    func __setImage(_ image: UIImage?, forSegmentAt index: Int) {
        if __USING_APPEARANCED_SWIZZING__ {
            swizzled_setImage(image, forSegmentAt: index)
        } else {
            setImage(image, forSegmentAt: index)
        }
    }
    
    func __setBackgroundImage(_ backgroundImage: UIImage?, for state: UIControl.State, barMetrics: UIBarMetrics) {
        if __USING_APPEARANCED_SWIZZING__ {
            swizzled_setBackgroundImage(backgroundImage, for: state, barMetrics: barMetrics)
        } else {
            setBackgroundImage(backgroundImage, for: state, barMetrics: barMetrics)
        }
    }
    
    func __setDividerImage(_ dividerImage: UIImage?, forLeftSegmentState leftSegmentState: UIControl.State, rightSegmentState: UIControl.State, barMetrics: UIBarMetrics) {
        if __USING_APPEARANCED_SWIZZING__ {
            swizzled_setDividerImage(dividerImage, forLeftSegmentState: leftSegmentState, rightSegmentState: rightSegmentState, barMetrics: barMetrics)
        } else {
            setDividerImage(dividerImage, forLeftSegmentState: leftSegmentState, rightSegmentState: rightSegmentState, barMetrics: barMetrics)
        }
    }
    
    func __setTitleTextAttributes(_ attributes: [NSAttributedString.Key: Any]?, for state: UIControl.State) {
        if __USING_APPEARANCED_SWIZZING__ {
            swizzled_setTitleTextAttributes(attributes, for: state)
        } else {
            setTitleTextAttributes(attributes, for: state)
        }
    }
    
    @objc func swizzled_setImage(_ image: UIImage?, forSegmentAt index: Int) {
        cache(
            firstParam: Callable.Appearanced(image),
            secondParam: Callable.Original(index),
            identifier: .setImageForSegmentAt,
            action: { [weak self] va, vb in self?.__setImage(va, forSegmentAt: vb) },
            category: "UISegmentedControl.index:\(index)"
        )
    }
    
    @objc func swizzled_setBackgroundImage(_ backgroundImage: UIImage?, for state: UIControl.State, barMetrics: UIBarMetrics) {
        cache(
            firstParam: Callable.Appearanced(backgroundImage),
            secondParam: Callable.Original(state),
            thirdParam: Callable.Original(barMetrics),
            identifier: .setBackgroundImageForBarMetrics,
            action: { [weak self] va, vb, vc in self?.__setBackgroundImage(va, for: vb, barMetrics: vc) },
            category: "UISegmentedControl.state:\(state.rawValue).metrics:\(barMetrics.rawValue)"
        )
    }
    
    @objc func swizzled_setDividerImage(_ dividerImage: UIImage?, forLeftSegmentState leftSegmentState: UIControl.State, rightSegmentState: UIControl.State, barMetrics: UIBarMetrics) {
        cache(
            firstParam: Callable.Appearanced(dividerImage),
            secondParam: Callable.Original(leftSegmentState),
            thirdParam: Callable.Original(rightSegmentState),
            fourthParam: Callable.Original(barMetrics),
            identifier: .setDividerImageForLeftRightBarMetrics,
            action: { [weak self] va, vb, vc, vd in self?.__setDividerImage(va, forLeftSegmentState: vb, rightSegmentState: vc, barMetrics: vd) },
            category: "UISegmentedControl.left:\(leftSegmentState.rawValue).right:\(rightSegmentState.rawValue).metrics:\(barMetrics.rawValue)"
        )
    }
    
    @objc func swizzled_setTitleTextAttributes(_ attributes: [NSAttributedString.Key: Any]?, for state: UIControl.State) {
        cache(
            firstParam: Callable.Collection(attributes),
            secondParam: Callable.Original(state),
            identifier: .setTitleAttributesFor,
            action: { [weak self] va, vb in self?.__setTitleTextAttributes(va, for: vb) },
            category: "UISegmentedControl.state:\(state.rawValue)"
        )
    }
}

#endif
