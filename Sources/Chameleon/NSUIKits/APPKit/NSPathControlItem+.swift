//
//  File.swift
//  
//
//  Created by Jo on 2023/4/10.
//


#if os(macOS)

import Cocoa

private extension AppearanceCallableIdentifier {
    static let attributedTitle = "NSPathControlItem.__setAttributedTitle(_:)"
    static let image = "NSPathControlItem.__setImage(_:)"
}

public extension NSPathControlItem {
    var app_attributedTitle: NSAttributedString {
        get { attributedTitle }
        set {
            if __USING_APPEARANCED_SWIZZING__ {
                attributedTitle = newValue
            } else {
                swizzled_setAttributedTitle(newValue)
            }
        }
    }
    
    var app_image: NSImage? {
        get { image }
        set {
            if __USING_APPEARANCED_SWIZZING__ {
                image = newValue
            } else {
                swizzled_setImage(newValue)
            }
        }
    }
}

internal extension NSPathControlItem {
    static func silenceExchangePathControlItemImplementation() {
        app_swizzing(
            originalSelector: #selector(setter: attributedTitle),
            newSelector: #selector(swizzled_setAttributedTitle(_:))
        )
        
        app_swizzing(
            originalSelector: #selector(setter: image),
            newSelector: #selector(swizzled_setImage(_:))
        )
    }
}

private extension NSPathControlItem {
    func __setAttributedTitle(_ attributedTitle: NSAttributedString) {
        if __USING_APPEARANCED_SWIZZING__ {
            swizzled_setAttributedTitle(attributedTitle)
        } else {
            self.attributedTitle = attributedTitle
        }
    }
    
    func __setImage(_ image: NSImage?) {
        if __USING_APPEARANCED_SWIZZING__ {
            swizzled_setImage(image)
        } else {
            self.image = image
        }
    }
    
    @objc func swizzled_setAttributedTitle(_ attributedTitle: NSAttributedString) {
        cache(
            firstParam: Callable.Attributed(attributedTitle),
            identifier: .attributedTitle,
            action: { [weak self] va in self?.__setAttributedTitle(va) }
        )
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
