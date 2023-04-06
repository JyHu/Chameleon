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
        set {
            if __USING_APPEARANCED_SWIZZING__ || newValue.appearanceIdentifier == nil {
                backgroundColor = newValue
            } else {
                cache(
                    valA: newValue,
                    identifier: .backgroundColor,
                    action: __setBackgroundColor(_:)
                )
            }
        }
        get {
            backgroundColor
        }
    }
    
    var app_gridColor: NSColor {
        set {
            if __USING_APPEARANCED_SWIZZING__ || newValue.appearanceIdentifier == nil {
                gridColor = newValue
            } else {
                cache(
                    valA: newValue,
                    identifier: .gridColor,
                    action: __setGridColor(_:)
                )
            }
        }
        get {
            gridColor
        }
    }
    
    func app_setIndicatorImage(_ image: NSImage, in tableColumn: NSTableColumn) {
        if __USING_APPEARANCED_SWIZZING__ || image.appearanceIdentifier == nil {
            setIndicatorImage(image, in: tableColumn)
        } else {
            cache(
                valA: image,
                valB: tableColumn,
                identifier: .setIndicatorImageInTableColumn,
                action: __setIndicatorImage(_:in:)
            )
        }
    }
}

internal extension NSTableView {
    static func silenceExchangeTableViewImplementation() {
        app_swizzing(
            originalSelector: #selector(setter: backgroundColor),
            newSelector: #selector(swizzled_setBackgroundColor(_:))
        )
        
        app_swizzing(
            originalSelector: #selector(setter: gridColor),
            newSelector: #selector(swizzled_setGridColor(_:))
        )
        
        app_swizzing(
            originalSelector: #selector(setIndicatorImage(_:in:)),
            newSelector: #selector(swizzled_setIndicatorImage(_:in:))
        )
    }
}

private extension NSTableView {
    func __setBackgroundColor(_ backgroundColor: NSColor) {
        if __USING_APPEARANCED_SWIZZING__ {
            swizzled_setBackgroundColor(backgroundColor)
        } else {
            self.backgroundColor = backgroundColor
        }
    }
    
    func __setGridColor(_ gridColor: NSColor) {
        if __USING_APPEARANCED_SWIZZING__ {
            swizzled_setGridColor(gridColor)
        } else {
            self.gridColor = gridColor
        }
    }
    
    func __setIndicatorImage(_ image: NSImage, in tableColumn: NSTableColumn) {
        if __USING_APPEARANCED_SWIZZING__ {
            swizzled_setIndicatorImage(image, in: tableColumn)
        } else {
            setIndicatorImage(image, in: tableColumn)
        }
    }
    
    
    @objc func swizzled_setBackgroundColor(_ backgroundColor: NSColor) {
        if backgroundColor.appearanceIdentifier != nil {
            cache(
                valA: backgroundColor,
                identifier: .backgroundColor,
                action: __setBackgroundColor(_:)
            )
        } else {
            swizzled_setBackgroundColor(backgroundColor)
        }
    }
    
    @objc func swizzled_setGridColor(_ gridColor: NSColor) {
        if gridColor.appearanceIdentifier != nil {
            cache(
                valA: gridColor,
                identifier: .gridColor,
                action: __setGridColor(_:)
            )
        } else {
            swizzled_setGridColor(gridColor)
        }
    }
    
    @objc func swizzled_setIndicatorImage(_ image: NSImage, in tableColumn: NSTableColumn) {
        if image.appearanceIdentifier != nil {
            cache(
                valA: image,
                valB: tableColumn,
                identifier: .setIndicatorImageInTableColumn,
                action: __setIndicatorImage(_:in:)
            )
        } else {
            swizzled_setIndicatorImage(image, in: tableColumn)
        }
    }
}

#endif
