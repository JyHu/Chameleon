//
//  File.swift
//  
//
//  Created by Jo on 2023/4/10.
//

#if os(iOS)

import UIKit

private extension AppearanceCallableIdentifier {
    static let image = "UIBarItem.__setImage(_:)"
    static let landscapeImagePhone = "UIBarItem.__setLandscapeImagePhone(_:)"
    static let largeContentSizeImage = "UIBarItem.__setLargeContentSizeImage(_:)"
}

public extension UIBarItem {
    var app_image: UIImage? {
        get { image }
        set {
            if __USING_APPEARANCED_SWIZZING__ {
                self.image = newValue
            } else {
                swizzled_setImage(newValue)
            }
        }
    }
    
    var app_landscapeImagePhone: UIImage? {
        get { landscapeImagePhone }
        set {
            if __USING_APPEARANCED_SWIZZING__ {
                self.landscapeImagePhone = newValue
            } else {
                swizzled_setLandscapeImagePhone(newValue)
            }
        }
    }
    
    var app_largeContentSizeImage: UIImage? {
        get { largeContentSizeImage }
        set {
            if __USING_APPEARANCED_SWIZZING__ {
                self.largeContentSizeImage = newValue
            } else {
                swizzled_setLargeContentSizeImage(newValue)
            }
        }
    }
}

internal extension UIBarItem {
    static func silenceExchangeBarItemImplementation() {
        app_swizzing(
            originalSelector: #selector(setter: image),
            newSelector: #selector(swizzled_setImage(_:))
        )
        
        app_swizzing(
            originalSelector: #selector(setter: landscapeImagePhone),
            newSelector: #selector(swizzled_setLandscapeImagePhone(_:))
        )
        
        app_swizzing(
            originalSelector: #selector(setter: largeContentSizeImage),
            newSelector: #selector(swizzled_setLargeContentSizeImage(_:))
        )
    }
}

private extension UIBarItem {
    func __setImage(_ image: UIImage?) {
        if __USING_APPEARANCED_SWIZZING__ {
            swizzled_setImage(image)
        } else {
            self.image = image
        }
    }
    
    func __setLandscapeImagePhone(_ landscapeImagePhone: UIImage?) {
        if __USING_APPEARANCED_SWIZZING__ {
            swizzled_setLandscapeImagePhone(landscapeImagePhone)
        } else {
            self.landscapeImagePhone = landscapeImagePhone
        }
    }
    
    func __setLargeContentSizeImage(_ largeContentSizeImage: UIImage?) {
        if __USING_APPEARANCED_SWIZZING__ {
            swizzled_setLargeContentSizeImage(largeContentSizeImage)
        } else {
            self.largeContentSizeImage = largeContentSizeImage
        }
    }
    
    @objc func swizzled_setImage(_ image: UIImage?) {
        cache(
            firstParam: Callable.Appearanced(image),
            identifier: .image,
            action: __setImage(_:)
        )
    }
    
    @objc func swizzled_setLandscapeImagePhone(_ landscapeImagePhone: UIImage?) {
        cache(
            firstParam: Callable.Appearanced(landscapeImagePhone),
            identifier: .landscapeImagePhone,
            action: __setLandscapeImagePhone(_:)
        )
    }
    
    @objc func swizzled_setLargeContentSizeImage(_ largeContentSizeImage: UIImage?) {
        cache(
            firstParam: Callable.Appearanced(largeContentSizeImage),
            identifier: .largeContentSizeImage,
            action: __setLargeContentSizeImage(_:)
        )
    }
}

#endif
