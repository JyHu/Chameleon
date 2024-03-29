//
//  File.swift
//  
//
//  Created by Jo on 2023/4/11.
//

#if os(macOS)

import Cocoa

private extension AppearanceCallableIdentifier {
    static let selectedSegmentBezelColor = "NSSegmentedControl.__setSelectedSegmentBezelColor(_:)"
    static let setImageForSegment = "NSSegmentedControl.__setImage(_:forSegment:)"
}

public extension NSSegmentedControl {
    var app_selectedSegmentBezelColor: NSColor? {
        get { selectedSegmentBezelColor }
        set {
            if __USING_APPEARANCED_SWIZZLING__ {
                self.selectedSegmentBezelColor = newValue
            } else {
                swizzled_setSelectedSegmentBezelColor(newValue)
            }
        }
    }
    
    func app_setImage(_ image: NSImage?, forSegment segment: Int) {
        if __USING_APPEARANCED_SWIZZLING__ {
            setImage(image, forSegment: segment)
        } else {
            swizzled_setImage(image, forSegment: segment)
        }
    }
}

internal extension NSSegmentedControl {
    static func silenceExchangeSegmentedControlImplementation() {
        app_swizzling(
            originalSelector: #selector(setter: selectedSegmentBezelColor),
            newSelector: #selector(swizzled_setSelectedSegmentBezelColor(_:))
        )
        
        app_swizzling(
            originalSelector: #selector(setImage(_:forSegment:)),
            newSelector: #selector(swizzled_setImage(_:forSegment:))
        )
    }
}

private extension NSSegmentedControl {
    func __setSelectedSegmentBezelColor(_ selectedSegmentBezelColor: NSColor?) {
        if __USING_APPEARANCED_SWIZZLING__ {
            swizzled_setSelectedSegmentBezelColor(selectedSegmentBezelColor)
        } else {
            self.selectedSegmentBezelColor = selectedSegmentBezelColor
        }
    }
    
    func __setImage(_ image: NSImage?, forSegment segment: Int) {
        if __USING_APPEARANCED_SWIZZLING__ {
            swizzled_setImage(image, forSegment: segment)
        } else {
            setImage(image, forSegment: segment)
        }
    }
    
    @objc func swizzled_setSelectedSegmentBezelColor(_ selectedSegmentBezelColor: NSColor?) {
        cache(
            firstParam: Callable.Appearanced(selectedSegmentBezelColor),
            identifier: .selectedSegmentBezelColor,
            action: { [weak self] va in self?.__setSelectedSegmentBezelColor(va) }
        )
    }
    
    @objc func swizzled_setImage(_ image: NSImage?, forSegment segment: Int) {
        cache(
            firstParam: Callable.Appearanced(image),
            secondParam: Callable.Original(segment),
            identifier: .setImageForSegment,
            action: { [weak self] va, vb in self?.__setImage(va, forSegment: vb) }
        )
    }
}

#endif
