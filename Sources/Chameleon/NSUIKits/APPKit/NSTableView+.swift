//
//  File.swift
//  
//
//  Created by Jo on 2023/4/6.
//

#if os(macOS)

import Cocoa

private extension AppearanceCallableIdentifier {
    static let backgroundColor = "NSTableView.__setBackgroundColor(_:)"
    static let gridColor = "NSTableView.__setGridColor(_:)"
    static let setIndicatorImageInTableColumn = "NSTableView.__setIndicatorImage(_:in:)"
}

public extension NSTableView {
    var app_backgroundColor: NSColor {
        get { backgroundColor }
        set {
            if __USING_APPEARANCED_SWIZZLING__ {
                backgroundColor = newValue
            } else {
                swizzled_setBackgroundColor(newValue)
            }
        }
    }
    
    var app_gridColor: NSColor {
        get { gridColor }
        set {
            if __USING_APPEARANCED_SWIZZLING__ {
                gridColor = newValue
            } else {
                swizzled_setGridColor(newValue)
            }
        }
    }
    
    func app_setIndicatorImage(_ image: NSImage, in tableColumn: NSTableColumn) {
        if __USING_APPEARANCED_SWIZZLING__ {
            setIndicatorImage(image, in: tableColumn)
        } else {
            swizzled_setIndicatorImage(image, in: tableColumn)
        }
    }
}

internal extension NSTableView {
    static func silenceExchangeTableViewImplementation() {
        app_swizzling(
            originalSelector: #selector(setter: backgroundColor),
            newSelector: #selector(swizzled_setBackgroundColor(_:))
        )
        
        app_swizzling(
            originalSelector: #selector(setter: gridColor),
            newSelector: #selector(swizzled_setGridColor(_:))
        )
        
        app_swizzling(
            originalSelector: #selector(setIndicatorImage(_:in:)),
            newSelector: #selector(swizzled_setIndicatorImage(_:in:))
        )
    }
}

private extension NSTableView {
    func __setBackgroundColor(_ backgroundColor: NSColor) {
        if __USING_APPEARANCED_SWIZZLING__ {
            swizzled_setBackgroundColor(backgroundColor)
        } else {
            self.backgroundColor = backgroundColor
        }
    }
    
    func __setGridColor(_ gridColor: NSColor) {
        if __USING_APPEARANCED_SWIZZLING__ {
            swizzled_setGridColor(gridColor)
        } else {
            self.gridColor = gridColor
        }
    }
    
    func __setIndicatorImage(_ image: NSImage, in tableColumn: NSTableColumn) {
        if __USING_APPEARANCED_SWIZZLING__ {
            swizzled_setIndicatorImage(image, in: tableColumn)
        } else {
            setIndicatorImage(image, in: tableColumn)
        }
    }
    
    
    @objc func swizzled_setBackgroundColor(_ backgroundColor: NSColor) {
        cache(
            firstParam: Callable.Appearanced(backgroundColor),
            identifier: .backgroundColor,
            action: { [weak self] va in self?.__setBackgroundColor(va) }
        )
    }
    
    @objc func swizzled_setGridColor(_ gridColor: NSColor) {
        cache(
            firstParam: Callable.Appearanced(gridColor),
            identifier: .gridColor,
            action: { [weak self] va in self?.__setGridColor(va) }
        )
    }
    
    @objc func swizzled_setIndicatorImage(_ image: NSImage, in tableColumn: NSTableColumn) {
        cache(
            firstParam: Callable.Appearanced(image),
            secondParam: Callable.Original(tableColumn),
            identifier: .setIndicatorImageInTableColumn,
            action: { [weak self] va, vb in self?.__setIndicatorImage(va, in: vb) }
        )
    }
}

#endif
