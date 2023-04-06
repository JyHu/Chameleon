//
//  File.swift
//  
//
//  Created by Jo on 2023/4/6.
//

#if os(macOS)

import Cocoa

private extension AppearanceCallableIdentifier {
    static let trackFillColor = "NSSlider."
}

public extension NSSlider {
    var app_trackFillColor: NSColor? {
        set {
            if __USING_APPEARANCED_SWIZZING__ || newValue?.appearanceIdentifier == nil {
                trackFillColor = newValue
            } else {
                if let newValue {
                    cache(
                        valA: newValue,
                        identifier: .trackFillColor,
                        action: __setTrackFillColor(_:)
                    )
                } else {
                    __setTrackFillColor(nil)
                }
            }
        }
        get {
            trackFillColor
        }
    }
}

internal extension NSSlider {
    static func silenceExchangeImplementation() {
        app_swizzing(
            originalSelector: #selector(setter: trackFillColor),
            newSelector: #selector(swizzled_setTrackFillColor(_:))
        )
    }
}

private extension NSSlider {
    func __setTrackFillColor(_ trackFillColor: NSColor?) {
        if __USING_APPEARANCED_SWIZZING__ {
            swizzled_setTrackFillColor(trackFillColor)
        } else {
            self.trackFillColor = trackFillColor
        }
    }
    
    
    @objc func swizzled_setTrackFillColor(_ trackFillColor: NSColor?) {
        if let trackFillColor, trackFillColor.appearanceIdentifier != nil {
            cache(
                valA: trackFillColor,
                identifier: .trackFillColor,
                action: __setTrackFillColor(_:)
            )
        } else {
            swizzled_setTrackFillColor(trackFillColor)
        }
    }
}

#endif