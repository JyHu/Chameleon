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
        get { trackFillColor }
        set {
            if __USING_APPEARANCED_SWIZZLING__ {
                trackFillColor = newValue
            } else {
                swizzled_setTrackFillColor(newValue)
            }
        }
    }
}

internal extension NSSlider {
    static func silenceExchangeSliderImplementation() {
        app_swizzling(
            originalSelector: #selector(setter: trackFillColor),
            newSelector: #selector(swizzled_setTrackFillColor(_:))
        )
    }
}

private extension NSSlider {
    func __setTrackFillColor(_ trackFillColor: NSColor?) {
        if __USING_APPEARANCED_SWIZZLING__ {
            swizzled_setTrackFillColor(trackFillColor)
        } else {
            self.trackFillColor = trackFillColor
        }
    }
    
    
    @objc func swizzled_setTrackFillColor(_ trackFillColor: NSColor?) {
        cache(
            firstParam: Callable.Appearanced(trackFillColor),
            identifier: .trackFillColor,
            action: { [weak self] va in self?.__setTrackFillColor(va) }
        )
    }
}

#endif
