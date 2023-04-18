//
//  File.swift
//  
//
//  Created by Jo on 2023/4/11.
//

#if os(iOS)

import UIKit

private extension AppearanceCallableIdentifier {
    static let minimumValueImage = "UISlider.__setMinimumValueImage(_:)"
    static let maximumValueImage = "UISlider.__setMaximumValueImage(_:)"
    static let minimumTrackTintColor = "UISlider.__setMinimumTrackTintColor(_:)"
    static let maximumTrackTintColor = "UISlider.__setMaximumTrackTintColor(_:)"
    static let thumbTintColor = "UISlider.__setThumbTintColor(_:)"
    static let setThumbImageFor = "UISlider.__setThumbImage(_:for:)"
    static let setMinimumTrackImageFor = "UISlider.__setMinimumTrackImage(_:for:)"
    static let setMaximumTrackImageFor = "UISlider.__setMaximumTrackImage(_:for:)"
}

public extension UISlider {
    var app_minimumValueImage: UIImage? {
        get { minimumValueImage }
        set {
            if __USING_APPEARANCED_SWIZZLING__ {
                self.minimumValueImage = newValue
            } else {
                swizzled_setMinimumValueImage(newValue)
            }
        }
    }
    
    var app_maximumValueImage: UIImage? {
        get { maximumValueImage }
        set {
            if __USING_APPEARANCED_SWIZZLING__ {
                self.maximumValueImage = newValue
            } else {
                swizzled_setMaximumValueImage(newValue)
            }
        }
    }
    
    var app_minimumTrackTintColor: UIColor? {
        get { minimumTrackTintColor }
        set {
            if __USING_APPEARANCED_SWIZZLING__ {
                self.minimumTrackTintColor = newValue
            } else {
                swizzled_setMinimumTrackTintColor(newValue)
            }
        }
    }
    
    var app_maximumTrackTintColor: UIColor? {
        get { maximumTrackTintColor }
        set {
            if __USING_APPEARANCED_SWIZZLING__ {
                self.maximumTrackTintColor = newValue
            } else {
                swizzled_setMaximumTrackTintColor(newValue)
            }
        }
    }
    
    var app_thumbTintColor: UIColor? {
        get { thumbTintColor }
        set {
            if __USING_APPEARANCED_SWIZZLING__ {
                self.thumbTintColor = newValue
            } else {
                swizzled_setThumbTintColor(newValue)
            }
        }
    }
    
    func app_setThumbImage(_ image: UIImage?, for state: UIControl.State) {
        if __USING_APPEARANCED_SWIZZLING__ {
            setThumbImage(image, for: state)
        } else {
            swizzled_setThumbImage(image, for: state)
        }
    }

    func app_setMinimumTrackImage(_ image: UIImage?, for state: UIControl.State) {
        if __USING_APPEARANCED_SWIZZLING__ {
            setMinimumTrackImage(image, for: state)
        } else {
            swizzled_setMinimumTrackImage(image, for: state)
        }
    }

    func app_setMaximumTrackImage(_ image: UIImage?, for state: UIControl.State) {
        if __USING_APPEARANCED_SWIZZLING__ {
            setMaximumTrackImage(image, for: state)
        } else {
            swizzled_setMaximumTrackImage(image, for: state)
        }
    }
    
}

internal extension UISlider {
    static func silenceExchangeSliderImplementation() {
        app_swizzling(
            originalSelector: #selector(setter: minimumValueImage),
            newSelector: #selector(swizzled_setMinimumValueImage(_:))
        )
        
        app_swizzling(
            originalSelector: #selector(setter: maximumValueImage),
            newSelector: #selector(swizzled_setMaximumValueImage(_:))
        )
        
        app_swizzling(
            originalSelector: #selector(setter: minimumTrackTintColor),
            newSelector: #selector(swizzled_setMinimumTrackTintColor(_:))
        )
        
        app_swizzling(
            originalSelector: #selector(setter: maximumTrackTintColor),
            newSelector: #selector(swizzled_setMaximumTrackTintColor(_:))
        )
        
        app_swizzling(
            originalSelector: #selector(setter: thumbTintColor),
            newSelector: #selector(swizzled_setThumbTintColor(_:))
        )
        
        app_swizzling(
            originalSelector: #selector(setThumbImage(_:for:)),
            newSelector: #selector(swizzled_setThumbImage(_:for:))
        )
        
        app_swizzling(
            originalSelector: #selector(setMinimumTrackImage(_:for:)),
            newSelector: #selector(swizzled_setMinimumTrackImage(_:for:))
        )
        
        app_swizzling(
            originalSelector: #selector(setMaximumTrackImage(_:for:)),
            newSelector: #selector(swizzled_setMaximumTrackImage(_:for:))
        )
    }
}

private extension UISlider {
    func __setMinimumValueImage(_ minimumValueImage: UIImage?) {
        if __USING_APPEARANCED_SWIZZLING__ {
            swizzled_setMinimumValueImage(minimumValueImage)
        } else {
            self.minimumValueImage = minimumValueImage
        }
    }
    
    func __setMaximumValueImage(_ maximumValueImage: UIImage?) {
        if __USING_APPEARANCED_SWIZZLING__ {
            swizzled_setMaximumValueImage(maximumValueImage)
        } else {
            self.maximumValueImage = maximumValueImage
        }
    }
    
    func __setMinimumTrackTintColor(_ minimumTrackTintColor: UIColor?) {
        if __USING_APPEARANCED_SWIZZLING__ {
            swizzled_setMinimumTrackTintColor(minimumTrackTintColor)
        } else {
            self.minimumTrackTintColor = minimumTrackTintColor
        }
    }
    
    func __setMaximumTrackTintColor(_ maximumTrackTintColor: UIColor?) {
        if __USING_APPEARANCED_SWIZZLING__ {
            swizzled_setMaximumTrackTintColor(maximumTrackTintColor)
        } else {
            self.maximumTrackTintColor = maximumTrackTintColor
        }
    }
    
    func __setThumbTintColor(_ thumbTintColor: UIColor?) {
        if __USING_APPEARANCED_SWIZZLING__ {
            swizzled_setThumbTintColor(thumbTintColor)
        } else {
            self.thumbTintColor = thumbTintColor
        }
    }
    
    func __setThumbImage(_ image: UIImage?, for state: UIControl.State) {
        if __USING_APPEARANCED_SWIZZLING__ {
            swizzled_setThumbImage(image, for: state)
        } else {
            setThumbImage(image, for: state)
        }
    }

    func __setMinimumTrackImage(_ image: UIImage?, for state: UIControl.State) {
        if __USING_APPEARANCED_SWIZZLING__ {
            swizzled_setMinimumTrackImage(image, for: state)
        } else {
            setMinimumTrackImage(image, for: state)
        }
    }

    func __setMaximumTrackImage(_ image: UIImage?, for state: UIControl.State) {
        if __USING_APPEARANCED_SWIZZLING__ {
            swizzled_setMaximumTrackImage(image, for: state)
        } else {
            setMaximumTrackImage(image, for: state)
        }
    }
    
    
    
    
    
    
    @objc func swizzled_setMinimumValueImage(_ minimumValueImage: UIImage?) {
        cache(
            firstParam: Callable.Appearanced(minimumValueImage),
            identifier: .minimumValueImage,
            action: { [weak self] va in self?.__setMinimumValueImage(va) }
        )
    }
    
    @objc func swizzled_setMaximumValueImage(_ maximumValueImage: UIImage?) {
        cache(
            firstParam: Callable.Appearanced(maximumValueImage),
            identifier: .maximumValueImage,
            action: { [weak self] va in self?.__setMaximumValueImage(va) }
        )
    }
    
    @objc func swizzled_setMinimumTrackTintColor(_ minimumTrackTintColor: UIColor?) {
        cache(
            firstParam: Callable.Appearanced(minimumTrackTintColor),
            identifier: .minimumTrackTintColor,
            action: { [weak self] va in self?.__setMinimumTrackTintColor(va) }
        )
    }
    
    @objc func swizzled_setMaximumTrackTintColor(_ maximumTrackTintColor: UIColor?) {
        cache(
            firstParam: Callable.Appearanced(maximumTrackTintColor),
            identifier: .maximumTrackTintColor,
            action: { [weak self] va in self?.__setMaximumTrackTintColor(va) }
        )
    }
    
    @objc func swizzled_setThumbTintColor(_ thumbTintColor: UIColor?) {
        cache(
            firstParam: Callable.Appearanced(thumbTintColor),
            identifier: .thumbTintColor,
            action: { [weak self] va in self?.__setThumbTintColor(va) }
        )
    }
    
    @objc func swizzled_setThumbImage(_ image: UIImage?, for state: UIControl.State) {
        cache(
            firstParam: Callable.Appearanced(image),
            secondParam: Callable.Original(state),
            identifier: .setThumbImageFor,
            action: { [weak self] va, vb in self?.__setThumbImage(va, for: vb) },
            category: "UISlider.state:\(state.rawValue)"
        )
    }

    @objc func swizzled_setMinimumTrackImage(_ image: UIImage?, for state: UIControl.State) {
        cache(
            firstParam: Callable.Appearanced(image),
            secondParam: Callable.Original(state),
            identifier: .setMinimumTrackImageFor,
            action: { [weak self] va, vb in self?.__setMaximumTrackImage(va, for: vb) },
            category: "UISlider.state:\(state.rawValue)"
        )
    }

    @objc func swizzled_setMaximumTrackImage(_ image: UIImage?, for state: UIControl.State) {
        cache(
            firstParam: Callable.Appearanced(image),
            secondParam: Callable.Original(state),
            identifier: .setMaximumTrackImageFor,
            action: { [weak self] va, vb in self?.__setMaximumTrackImage(va, for: vb) },
            category: "UISlider.state:\(state.rawValue)"
        )
    }
}

#endif
