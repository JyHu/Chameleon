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
        set {
            if __USING_APPEARANCED_SWIZZING__, newValue?.appearanceIdentifier == nil {
                image = newValue
            } else {
                if let newValue {
                    cache(
                        valA: newValue,
                        identifier: .image,
                        action: __setImage(_:)
                    )
                } else {
                    __setImage(nil)
                }
            }
        }
        get {
            image
        }
    }
}

internal extension NSImageView {
    static func silenceExchangeImageViewImplementation() {
        app_swizzing(
            originalSelector: #selector(setter: image),
            newSelector: #selector(swizzled_setImage(_:))
        )
    }
}

private extension NSImageView {
    func __setImage(_ image: NSImage?) {
        if __USING_APPEARANCED_SWIZZING__ {
            swizzled_setImage(image)
        } else {
            self.image = image
        }
    }
    
    
    @objc func swizzled_setImage(_ image: NSImage?) {
        if let image, image.appearanceIdentifier != nil {
            cache(
                valA: image,
                identifier: .image,
                action: __setImage(_:)
            )
        }
    }
}

#endif
