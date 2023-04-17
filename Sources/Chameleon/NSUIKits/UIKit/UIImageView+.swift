//
//  File.swift
//  
//
//  Created by Jo on 2023/4/11.
//

#if os(iOS)

import UIKit

private extension AppearanceCallableIdentifier {
    static let image = "UIImageView.__setImage(_:)"
    static let highlightedImage = "UIImageView.__setHighlightedImage(_:)"
    static let animationImages = "UIImageView.__setAnimationImages(_:)"
    static let highlightedAnimationImages = "UIImageView.__setHighlightedAnimationImages(_:)"
    static let animationDuration = "UIImageView.__setAnimationDuration(_:)"
    static let animationRepeatCount = "UIImageView.__setAnimationRepeatCount(_:)"
}

public extension UIImageView {
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
    
    var app_highlightedImage: UIImage? {
        get { highlightedImage }
        set {
            if __USING_APPEARANCED_SWIZZING__ {
                self.highlightedImage = newValue
            } else {
                swizzled_setHighlightedImage(newValue)
            }
        }
    }
    
    var app_animationImages: [UIImage]? {
        get { animationImages }
        set {
            if __USING_APPEARANCED_SWIZZING__ {
                self.animationImages = newValue
            } else {
                swizzled_setAnimationImages(newValue)
            }
        }
    }
    
    var app_highlightedAnimationImages: [UIImage]? {
        get { highlightedAnimationImages }
        set {
            if __USING_APPEARANCED_SWIZZING__ {
                self.highlightedAnimationImages = newValue
            } else {
                swizzled_setHighlightedAnimationImages(newValue)
            }
        }
    }
    
    func setAnimationDuration(_ animationDuration: TimeInterval, identifier: String) {
        cache(
            firstParam: Callable.Appearanced(animationDuration, identifier: identifier),
            identifier: .animationDuration,
            action: { [weak self] va in self?.__setAnimationDuration(va) }
        )
    }
    
    func setAnimationRepeatCount(_ animationRepeatCount: Int, identifier: String) {
        cache(
            firstParam: Callable.Appearanced(animationRepeatCount, identifier: identifier),
            identifier: .animationRepeatCount,
            action: { [weak self] va in self?.__setAnimationRepeatCount(va) }
        )
    }
}

internal extension UIImageView {
    static func silenceExchangeImageViewImplementation() {
        app_swizzing(
            originalSelector: #selector(setter: image),
            newSelector: #selector(swizzled_setImage(_:))
        )
        
        app_swizzing(
            originalSelector: #selector(setter: highlightedImage),
            newSelector: #selector(swizzled_setHighlightedImage(_:))
        )
        
        app_swizzing(
            originalSelector: #selector(setter: animationImages),
            newSelector: #selector(swizzled_setAnimationImages(_:))
        )
        
        app_swizzing(
            originalSelector: #selector(setter: highlightedAnimationImages),
            newSelector: #selector(swizzled_setHighlightedAnimationImages(_:))
        )
    }
}

private extension UIImageView {
    func __setImage(_ image: UIImage?) {
        if __USING_APPEARANCED_SWIZZING__ {
            swizzled_setImage(image)
        } else {
            self.image = image
        }
    }
    
    func __setHighlightedImage(_ highlightedImage: UIImage?) {
        if __USING_APPEARANCED_SWIZZING__ {
            swizzled_setHighlightedImage(highlightedImage)
        } else {
            self.highlightedImage = highlightedImage
        }
    }
    
    func __setAnimationImages(_ animationImages: [UIImage]?) {
        if __USING_APPEARANCED_SWIZZING__ {
            swizzled_setAnimationImages(animationImages)
        } else {
            self.animationImages = animationImages
        }
    }
    
    func __setHighlightedAnimationImages(_ highlightedAnimationImages: [UIImage]?) {
        if __USING_APPEARANCED_SWIZZING__ {
            swizzled_setHighlightedAnimationImages(highlightedAnimationImages)
        } else {
            self.highlightedAnimationImages = highlightedAnimationImages
        }
    }
    
    func __setAnimationDuration(_ animationDuration: TimeInterval) {
        self.animationDuration = animationDuration
    }
    
    func __setAnimationRepeatCount(_ animationRepeatCount: Int) {
        self.animationRepeatCount = animationRepeatCount
    }
    
    @objc func swizzled_setImage(_ image: UIImage?) {
        cache(
            firstParam: Callable.Appearanced(image),
            identifier: .image,
            action: { [weak self] va in self?.__setImage(va) }
        )
    }
    
    @objc func swizzled_setHighlightedImage(_ highlightedImage: UIImage?) {
        cache(
            firstParam: Callable.Appearanced(highlightedImage),
            identifier: .highlightedImage,
            action: { [weak self] va in self?.__setHighlightedImage(va) }
        )
    }
    
    @objc func swizzled_setAnimationImages(_ animationImages: [UIImage]?) {
        cache(
            firstParam: Callable.Collection(animationImages),
            identifier: .animationImages,
            action: { [weak self] va in self?.__setAnimationImages(va) }
        )
    }
    
    @objc func swizzled_setHighlightedAnimationImages(_ highlightedAnimationImages: [UIImage]?) {
        cache(
            firstParam: Callable.Collection(highlightedAnimationImages),
            identifier: .highlightedAnimationImages,
            action: { [weak self] va in self?.__setHighlightedAnimationImages(va) }
        )
    }
}

#endif
