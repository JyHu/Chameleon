//
//  File.swift
//  
//
//  Created by Jo on 2023/4/6.
//

#if os(macOS)

import Cocoa

private extension AppearanceCallableIdentifier {
    static let image = "NSImageView.__setImage(_:)"
}

public extension NSImageView {
    var app_image: NSImage? {
        get { image }
        set {
            if __USING_APPEARANCED_SWIZZLING__ {
                image = newValue
            } else {
                swizzled_setImage(newValue)
            }
        }
    }
}

internal extension NSImageView {
    static func silenceExchangeImageViewImplementation() {
        app_swizzling(
            originalSelector: #selector(setter: image),
            newSelector: #selector(swizzled_setImage(_:))
        )
    }
}

private extension NSImageView {
    func __setImage(_ image: NSImage?) {
        if __USING_APPEARANCED_SWIZZLING__ {
            swizzled_setImage(image)
        } else {
            self.image = image
        }
    }
    
    
    @objc func swizzled_setImage(_ image: NSImage?) {
        cache(
            firstParam: Callable.Appearanced(image),
            identifier: .image,
            action: { [weak self] va in self?.__setImage(va) }
        )
    }
}

#endif
