//
//  File.swift
//  
//
//  Created by Jo on 2023/4/11.
//

#if os(macOS)

import Cocoa

private extension AppearanceCallableIdentifier {
    static let fillColor = "NSLevelIndicator.__setFillColor(_:)"
    static let warningFillColor = "NSLevelIndicator.__setWarningFillColor(_:)"
    static let criticalFillColor = "NSLevelIndicator.__setCriticalFillColor(_:)"
    static let ratingImage = "NSLevelIndicator.__setRatingImage(_:)"
    static let ratingPlaceholderImage = "NSLevelIndicator.__setRatingPlaceholderImage(_:)"
}

public extension NSLevelIndicator {
    var app_fillColor: NSColor {
        get { fillColor }
        set {
            if __USING_APPEARANCED_SWIZZING__ {
                self.fillColor = newValue
            } else {
                swizzled_setFillColor(newValue)
            }
        }
    }
    
    var app_warningFillColor: NSColor {
        get { warningFillColor }
        set {
            if __USING_APPEARANCED_SWIZZING__ {
                self.warningFillColor = newValue
            } else {
                swizzled_setWarningFillColor(newValue)
            }
        }
    }
    
    var app_criticalFillColor: NSColor {
        get { criticalFillColor }
        set {
            if __USING_APPEARANCED_SWIZZING__ {
                self.criticalFillColor = newValue
            } else {
                swizzled_setCriticalFillColor(newValue)
            }
        }
    }
    
    var app_ratingImage: NSImage? {
        get { ratingImage }
        set {
            if __USING_APPEARANCED_SWIZZING__ {
                self.ratingImage = newValue
            } else {
                swizzled_setRatingImage(newValue)
            }
        }
    }
    
    var app_ratingPlaceholderImage: NSImage? {
        get { ratingPlaceholderImage }
        set {
            if __USING_APPEARANCED_SWIZZING__ {
                self.ratingPlaceholderImage = newValue
            } else {
                swizzled_setRatingPlaceholderImage(newValue)
            }
        }
    }
}

internal extension NSLevelIndicator {
    static func silenceExchangeLevelIndicatorImplementation() {
        app_swizzing(
            originalSelector: #selector(setter: fillColor),
            newSelector: #selector(swizzled_setFillColor(_:))
        )
        
        app_swizzing(
            originalSelector: #selector(setter: warningFillColor),
            newSelector: #selector(swizzled_setWarningFillColor(_:))
        )
        
        app_swizzing(
            originalSelector: #selector(setter: criticalFillColor),
            newSelector: #selector(swizzled_setCriticalFillColor(_:))
        )
        
        app_swizzing(
            originalSelector: #selector(setter: ratingImage),
            newSelector: #selector(swizzled_setRatingImage(_:))
        )
        
        app_swizzing(
            originalSelector: #selector(setter: ratingPlaceholderImage),
            newSelector: #selector(swizzled_setRatingPlaceholderImage(_:))
        )
    }
}

private extension NSLevelIndicator {
    func __setFillColor(_ fillColor: NSColor) {
        if __USING_APPEARANCED_SWIZZING__ {
            swizzled_setFillColor(fillColor)
        } else {
            self.fillColor = fillColor
        }
    }
    
    func __setWarningFillColor(_ warningFillColor: NSColor) {
        if __USING_APPEARANCED_SWIZZING__ {
            swizzled_setWarningFillColor(warningFillColor)
        } else {
            self.warningFillColor = warningFillColor
        }
    }
    
    func __setCriticalFillColor(_ criticalFillColor: NSColor) {
        if __USING_APPEARANCED_SWIZZING__ {
            swizzled_setCriticalFillColor(criticalFillColor)
        } else {
            self.criticalFillColor = criticalFillColor
        }
    }
    
    func __setRatingImage(_ ratingImage: NSImage?) {
        if __USING_APPEARANCED_SWIZZING__ {
            swizzled_setRatingImage(ratingImage)
        } else {
            self.ratingImage = ratingImage
        }
    }
    
    func __setRatingPlaceholderImage(_ ratingPlaceholderImage: NSImage?) {
        if __USING_APPEARANCED_SWIZZING__ {
            swizzled_setRatingPlaceholderImage(ratingPlaceholderImage)
        } else {
            self.ratingPlaceholderImage = ratingPlaceholderImage
        }
    }
    
    
    
    @objc func swizzled_setFillColor(_ fillColor: NSColor) {
        cache(
            firstParam: Callable.Appearanced(fillColor),
            identifier: .fillColor,
            action: __setFillColor(_:)
        )
    }
    
    @objc func swizzled_setWarningFillColor(_ warningFillColor: NSColor) {
        cache(
            firstParam: Callable.Appearanced(warningFillColor),
            identifier: .warningFillColor,
            action: __setWarningFillColor(_:)
        )
    }
    
    @objc func swizzled_setCriticalFillColor(_ criticalFillColor: NSColor) {
        cache(
            firstParam: Callable.Appearanced(criticalFillColor),
            identifier: .criticalFillColor,
            action: __setCriticalFillColor(_:)
        )
    }
    
    @objc func swizzled_setRatingImage(_ ratingImage: NSImage?) {
        cache(
            firstParam: Callable.Appearanced(ratingImage),
            identifier: .ratingImage,
            action: __setRatingImage(_:)
        )
    }
    
    @objc func swizzled_setRatingPlaceholderImage(_ ratingPlaceholderImage: NSImage?) {
        cache(
            firstParam: Callable.Appearanced(ratingPlaceholderImage),
            identifier: .ratingPlaceholderImage,
            action: __setRatingPlaceholderImage(_:)
        )
    }
}

#endif
