//
//  File.swift
//  
//
//  Created by Jo on 2023/4/10.
//


#if os(macOS)
import Cocoa

private extension AppearanceCallableIdentifier {
    static let image = "NSButtonTouchBarItem.__setImage(_:)"
    static let bezelColor = "NSButtonTouchBarItem.__setBezelColor(_:)"
}

public extension NSButtonTouchBarItem {
    var app_image: NSUIAppearanceImage? {
        get { image }
        set {
            if __USING_APPEARANCED_SWIZZING__ {
                image = newValue
            } else {
                swizzled_setImage(newValue)
            }
        }
    }
    
    var app_bezelColor: NSUIAppearanceColor? {
        get { bezelColor }
        set {
            if __USING_APPEARANCED_SWIZZING__ {
                bezelColor = newValue
            } else {
                swizzled_setBezelColor(newValue)
            }
        }
    }
}

internal extension NSButtonTouchBarItem {
    static func silenceExchangeButtonTouchBarItemImplementation() {
        app_swizzing(
            originalSelector: #selector(setter: image),
            newSelector: #selector(swizzled_setImage(_:))
        )
        
        app_swizzing(
            originalSelector: #selector(setter: bezelColor),
            newSelector: #selector(swizzled_setBezelColor(_:))
        )
    }
}

private extension NSButtonTouchBarItem {
    func __setImage(_ image: NSUIAppearanceImage?) {
        if __USING_APPEARANCED_SWIZZING__ {
            swizzled_setImage(image)
        } else {
            self.image = image
        }
    }
    
    func __setBezelColor(_ bezelColor: NSUIAppearanceColor?) {
        if __USING_APPEARANCED_SWIZZING__ {
            swizzled_setBezelColor(bezelColor)
        } else {
            self.bezelColor = bezelColor
        }
    }
    
    @objc func swizzled_setImage(_ image: NSUIAppearanceImage?) {
        cache(
            firstParam: Callable.Appearanced(image),
            identifier: .image,
            action: __setImage(_:)
        )
    }
    
    @objc func swizzled_setBezelColor(_ bezelColor: NSUIAppearanceColor?) {
        cache(
            firstParam: Callable.Appearanced(bezelColor),
            identifier: .bezelColor,
            action: __setBezelColor(_:)
        )
    }
}
#endif
