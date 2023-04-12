//
//  File.swift
//  
//
//  Created by Jo on 2023/4/11.
//

#if os(iOS)

import UIKit

private extension AppearanceCallableIdentifier {
    static let onTintColor = "UISwitch.__setOnTintColor(_:)"
    static let thumbTintColor = "UISwitch.__setThumbTintColor(_:)"
    static let onImage = "UISwitch.__setOnImage(_:)"
    static let offImage = "UISwitch.__setOffImage(_:)"
}

public extension UISwitch {
    var app_onTintColor: UIColor? {
        get { onTintColor }
        set {
            if __USING_APPEARANCED_SWIZZING__ {
                self.onTintColor = newValue
            } else {
                swizzled_setOnTintColor(newValue)
            }
        }
    }
    
    var app_thumbTintColor: UIColor? {
        get { thumbTintColor }
        set {
            if __USING_APPEARANCED_SWIZZING__ {
                self.thumbTintColor = newValue
            } else {
                swizzled_setThumbTintColor(newValue)
            }
        }
    }
    
    var app_onImage: UIImage? {
        get { onImage }
        set {
            if __USING_APPEARANCED_SWIZZING__ {
                self.onImage = newValue
            } else {
                swizzled_setOnImage(newValue)
            }
        }
    }
    
    var app_offImage: UIImage? {
        get { offImage }
        set {
            if __USING_APPEARANCED_SWIZZING__ {
                self.offImage = newValue
            } else {
                swizzled_setOffImage(newValue)
            }
        }
    }
}

internal extension UISwitch {
    static func silenceExchangeSwitchImplementation() {
        app_swizzing(
            originalSelector: #selector(setter: onTintColor),
            newSelector: #selector(swizzled_setOnTintColor(_:))
        )
        app_swizzing(
            originalSelector: #selector(setter: thumbTintColor),
            newSelector: #selector(swizzled_setThumbTintColor(_:))
        )
        app_swizzing(
            originalSelector: #selector(setter: onImage),
            newSelector: #selector(swizzled_setOnImage(_:))
        )
        app_swizzing(
            originalSelector: #selector(setter: offImage),
            newSelector: #selector(swizzled_setOffImage(_:))
        )
    }
}

private extension UISwitch {
    func __setOnTintColor(_ onTintColor: UIColor?) {
        if __USING_APPEARANCED_SWIZZING__ {
            swizzled_setOnTintColor(onTintColor)
        } else {
            self.onTintColor = onTintColor
        }
    }
    
    func __setThumbTintColor(_ thumbTintColor: UIColor?) {
        if __USING_APPEARANCED_SWIZZING__ {
            swizzled_setThumbTintColor(thumbTintColor)
        } else {
            self.thumbTintColor = thumbTintColor
        }
    }
    
    func __setOnImage(_ onImage: UIImage?) {
        if __USING_APPEARANCED_SWIZZING__ {
            swizzled_setOnImage(onImage)
        } else {
            self.onImage = onImage
        }
    }
    
    func __setOffImage(_ offImage: UIImage?) {
        if __USING_APPEARANCED_SWIZZING__ {
            swizzled_setOffImage(offImage)
        } else {
            self.offImage = offImage
        }
    }
    
    
    @objc func swizzled_setOnTintColor(_ onTintColor: UIColor?) {
        cache(
            firstParam: Callable.Appearanced(onTintColor),
            identifier: .onTintColor,
            action: __setOnTintColor(_:)
        )
    }
    
    @objc func swizzled_setThumbTintColor(_ thumbTintColor: UIColor?) {
        cache(
            firstParam: Callable.Appearanced(thumbTintColor),
            identifier: .thumbTintColor,
            action: __setThumbTintColor(_:)
        )
    }
    
    @objc func swizzled_setOnImage(_ onImage: UIImage?) {
        cache(
            firstParam: Callable.Appearanced(onImage),
            identifier: .onImage,
            action: __setOnImage(_:)
        )
    }
    
    @objc func swizzled_setOffImage(_ offImage: UIImage?) {
        cache(
            firstParam: Callable.Appearanced(offImage),
            identifier: .offImage,
            action: __setOffImage(_:)
        )
    }
}

#endif
