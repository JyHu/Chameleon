//
//  NSButton+.swift
//  
//
//  Created by Jo on 2023/4/6.
//

#if os(macOS)

import Cocoa

private extension AppearanceCallableIdentifier {
    static let bezelColor = "NSButton.__setBezelColor(_:)"
    static let contentTintColor = "NSButton.__setContentTintColor(_:)"
    static let image = "NSButton.__setImage(_:)"
    static let alternateImage = "NSButton.__setAlternateImage(_:)"
    static let attributedTitle = "NSButton.__setAttributedTitle(_:)"
    static let attributedAlternateTitle = "NSButton.__setAttributedAlternateTitle(_:)"
}

public extension NSButton {
    var app_bezelColor: NSColor? {
        get { bezelColor }
        set {
            if __USING_APPEARANCED_SWIZZING__ {
                bezelColor = newValue
            } else {
                swizzled_setBezelColor(newValue)
            }
        }
    }
    
    var app_contentTintColor: NSColor? {
        get { contentTintColor }
        set {
            if __USING_APPEARANCED_SWIZZING__ {
                contentTintColor = newValue
            } else {
                swizzled_setContentTintColor(newValue)
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
    
    var app_alternateImage: NSImage? {
        get { alternateImage }
        set {
            if __USING_APPEARANCED_SWIZZING__ {
                alternateImage = newValue
            } else {
                swizzled_setAlternateImage(newValue)
            }
        }
    }
    
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
    
    var app_attributedAlternateTitle: NSAttributedString {
        get { attributedAlternateTitle }
        set {
            if __USING_APPEARANCED_SWIZZING__ {
                attributedAlternateTitle = newValue
            } else {
                swizzled_setAttributedAlternateTitle(newValue)
            }
        }
    }
}

internal extension NSButton {
    static func silenceExchangeButtonImplementation() {
        app_swizzing(
            originalSelector: #selector(setter: bezelColor),
            newSelector: #selector(swizzled_setBezelColor(_:))
        )
        
        app_swizzing(
            originalSelector: #selector(setter: contentTintColor),
            newSelector: #selector(swizzled_setContentTintColor(_:))
        )
        
        app_swizzing(
            originalSelector: #selector(setter: image),
            newSelector: #selector(swizzled_setImage(_:))
        )
        
        app_swizzing(
            originalSelector: #selector(setter: alternateImage),
            newSelector: #selector(swizzled_setAlternateImage(_:))
        )
        
        app_swizzing(
            originalSelector: #selector(setter: attributedTitle),
            newSelector: #selector(swizzled_setAttributedTitle(_:))
        )
        
        app_swizzing(
            originalSelector: #selector(setter: attributedAlternateTitle),
            newSelector: #selector(swizzled_setAttributedAlternateTitle(_:))
        )
    }
}

private extension NSButton {
    func __setBezelColor(_ bezelColor: NSColor?) {
        if __USING_APPEARANCED_SWIZZING__ {
            swizzled_setBezelColor(bezelColor)
        } else {
            self.bezelColor = bezelColor
        }
    }
    
    func __setContentTintColor(_ contentTintColor: NSColor?) {
        if __USING_APPEARANCED_SWIZZING__ {
            swizzled_setContentTintColor(contentTintColor)
        } else {
            self.contentTintColor = contentTintColor
        }
    }
    
    func __setImage(_ image: NSImage?) {
        if __USING_APPEARANCED_SWIZZING__ {
            swizzled_setImage(image)
        } else {
            self.image = image
        }
    }
    
    func __setAlternateImage(_ alternateImage: NSImage?) {
        if __USING_APPEARANCED_SWIZZING__ {
            swizzled_setAlternateImage(alternateImage)
        } else {
            self.alternateImage = alternateImage
        }
    }
    
    func __setAttributedTitle(_ attributedTitle: NSAttributedString) {
        if __USING_APPEARANCED_SWIZZING__ {
            swizzled_setAttributedTitle(attributedTitle)
        } else {
            self.attributedTitle = attributedTitle
        }
    }
    
    func __setAttributedAlternateTitle(_ attributedAlternateTitle: NSAttributedString) {
        if __USING_APPEARANCED_SWIZZING__ {
            swizzled_setAttributedAlternateTitle(attributedAlternateTitle)
        } else {
            self.attributedAlternateTitle = attributedAlternateTitle
        }
    }
    
    @objc func swizzled_setBezelColor(_ bezelColor: NSColor?) {
        cache(
            valA: bezelColor,
            identifier: .bezelColor,
            action: __setBezelColor(_:)
        )
    }
    
    @objc func swizzled_setContentTintColor(_ contentTintColor: NSColor?) {
        cache(
            valA: contentTintColor,
            identifier: .contentTintColor,
            action: __setContentTintColor(_:)
        )
    }
    
    @objc func swizzled_setImage(_ image: NSImage?) {
        cache(
            valA: image,
            identifier: .image,
            action: __setImage(_:)
        )
    }
    
    @objc func swizzled_setAlternateImage(_ alternateImage: NSImage?) {
        cache(
            valA: alternateImage,
            identifier: .alternateImage,
            action: __setAlternateImage(_:)
        )
    }
    
    @objc func swizzled_setAttributedTitle(_ attributedTitle: NSAttributedString) {
        cache(
            valA: attributedTitle,
            identifier: .attributedTitle,
            action: __setAttributedTitle(_:)
        )
    }
    
    @objc func swizzled_setAttributedAlternateTitle(_ attributedAlternateTitle: NSAttributedString) {
        cache(
            valA: attributedAlternateTitle,
            identifier: .attributedAlternateTitle,
            action: __setAttributedAlternateTitle(_:)
        )
    }
}

#endif
