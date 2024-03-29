//
//  File.swift
//  
//
//  Created by Jo on 2023/4/11.
//

#if os(iOS)

import UIKit

private extension AppearanceCallableIdentifier {
    static let setBackgroundImageForState = "UIStepper.__setBackgroundImage(_:for:)"
    static let setDividerImageForLeftRightState = "UIStepper.__setDividerImage(_:forLeftSegmentState:rightSegmentState:)"
    static let setIncrementImageForState = "UIStepper.__setIncrementImage(_:for:)"
    static let setDecrementImageForState = "UIStepper.__setDecrementImage(_:for:)"
}

public extension UIStepper {
    func app_setBackgroundImage(_ image: UIImage?, for state: UIControl.State) {
        if __USING_APPEARANCED_SWIZZLING__ {
            setBackgroundImage(image, for: state)
        } else {
            swizzled_setBackgroundImage(image, for: state)
        }
    }

    func app_setDividerImage(_ image: UIImage?, forLeftSegmentState leftState: UIControl.State, rightSegmentState rightState: UIControl.State) {
        if __USING_APPEARANCED_SWIZZLING__ {
            setDividerImage(image, forLeftSegmentState: leftState, rightSegmentState: rightState)
        } else {
            swizzled_setDividerImage(image, forLeftSegmentState: leftState, rightSegmentState: rightState)
        }
    }

    func app_setIncrementImage(_ image: UIImage?, for state: UIControl.State) {
        if __USING_APPEARANCED_SWIZZLING__ {
            setIncrementImage(image, for: state)
        } else {
            swizzled_setIncrementImage(image, for: state)
        }
    }
    
    func app_setDecrementImage(_ image: UIImage?, for state: UIControl.State) {
        if __USING_APPEARANCED_SWIZZLING__ {
            setDecrementImage(image, for: state)
        } else {
            swizzled_setDecrementImage(image, for: state)
        }
    }
}

internal extension UIStepper {
    static func silenceExchangeStepperImplementation() {
        app_swizzling(
            originalSelector: #selector(setBackgroundImage(_:for:)),
            newSelector: #selector(swizzled_setBackgroundImage(_:for:))
        )
        
        app_swizzling(
            originalSelector: #selector(setDividerImage(_:forLeftSegmentState:rightSegmentState:)),
            newSelector: #selector(swizzled_setDividerImage(_:forLeftSegmentState:rightSegmentState:))
        )
        
        app_swizzling(
            originalSelector: #selector(setIncrementImage(_:for:)),
            newSelector: #selector(swizzled_setIncrementImage(_:for:))
        )
        
        app_swizzling(
            originalSelector: #selector(setDecrementImage(_:for:)),
            newSelector: #selector(swizzled_setDecrementImage(_:for:))
        )
    }
}

private extension UIStepper {
    func __setBackgroundImage(_ image: UIImage?, for state: UIControl.State) {
        if __USING_APPEARANCED_SWIZZLING__ {
            swizzled_setBackgroundImage(image, for: state)
        } else {
            setBackgroundImage(image, for: state)
        }
    }

    func __setDividerImage(_ image: UIImage?, forLeftSegmentState leftState: UIControl.State, rightSegmentState rightState: UIControl.State) {
        if __USING_APPEARANCED_SWIZZLING__ {
            swizzled_setDividerImage(image, forLeftSegmentState: leftState, rightSegmentState: rightState)
        } else {
            setDividerImage(image, forLeftSegmentState: leftState, rightSegmentState: rightState)
        }
    }

    func __setIncrementImage(_ image: UIImage?, for state: UIControl.State) {
        if __USING_APPEARANCED_SWIZZLING__ {
            swizzled_setIncrementImage(image, for: state)
        } else {
            setIncrementImage(image, for: state)
        }
    }
    
    func __setDecrementImage(_ image: UIImage?, for state: UIControl.State) {
        if __USING_APPEARANCED_SWIZZLING__ {
            swizzled_setDecrementImage(image, for: state)
        } else {
            setDecrementImage(image, for: state)
        }
    }
    
    @objc func swizzled_setBackgroundImage(_ image: UIImage?, for state: UIControl.State) {
        cache(
            firstParam: Callable.Appearanced(image),
            secondParam: Callable.Original(state),
            identifier: .setBackgroundImageForState,
            action: { [weak self] va, vb in self?.__setBackgroundImage(va, for: vb) },
            category: "UIStepper.state:\(state.rawValue)"
        )
    }

    @objc func swizzled_setDividerImage(_ image: UIImage?, forLeftSegmentState leftState: UIControl.State, rightSegmentState rightState: UIControl.State) {
        cache(
            firstParam: Callable.Appearanced(image),
            secondParam: Callable.Original(leftState),
            thirdParam: Callable.Original(rightState),
            identifier: .setDividerImageForLeftRightState,
            action: { [weak self] va, vb, vc in self?.__setDividerImage(va, forLeftSegmentState: vb, rightSegmentState: vc) },
            category: "UIStepper.left:\(leftState.rawValue).right:\(rightState.rawValue)"
        )
    }

    @objc func swizzled_setIncrementImage(_ image: UIImage?, for state: UIControl.State) {
        cache(
            firstParam: Callable.Appearanced(image),
            secondParam: Callable.Original(state),
            identifier: .setIncrementImageForState,
            action: { [weak self] va, vb in self?.__setIncrementImage(va, for: vb) },
            category: "UIStepper.state:\(state.rawValue)"
        )
    }
    
    @objc func swizzled_setDecrementImage(_ image: UIImage?, for state: UIControl.State) {
        cache(
            firstParam: Callable.Appearanced(image),
            secondParam: Callable.Original(state),
            identifier: .setDecrementImageForState,
            action: { [weak self] va, vb in self?.__setDecrementImage(va, for: vb) },
            category: "UIStepper.state:\(state.rawValue)"
        )
    }
}

#endif
