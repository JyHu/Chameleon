//
//  File.swift
//  
//
//  Created by Jo on 2023/4/4.
//

#if os(macOS)

import Cocoa

public extension NSView {
    var app_layerBackgroundColor: NSColor? {
        set {
            cache(
                valA: .optional(newValue),
                identifier: "NSView.__setLayerBackgroundColor(_:)",
                action: __setLayerBackgroundColor(_:)
            )
        }
        get {
            if let cgColor = layer?.backgroundColor {
                return NSColor(cgColor: cgColor)
            }
            
            return nil
        }
    }
    
    var app_layerBorderColor: NSColor? {
        set {
            cache(
                valA: .optional(newValue),
                identifier: "NSView.__setLayerBorderColor(_:)",
                action: __setLayerBorderColor(_:)
            )
        }
        get {
            if let cgColor = layer?.borderColor {
                return NSColor(cgColor: cgColor)
            }
            
            return nil
        }
    }
}

private extension NSView {
    func __setLayerBackgroundColor(_ layerBackgroundColor: Callable.Param<NSColor>) {
        if !self.wantsLayer {
            self.wantsLayer = true
        }
        
        self.layer?.backgroundColor = layerBackgroundColor.optionalValue?.cgColor
    }
    
    func __setLayerBorderColor(_ layerBorderColor: Callable.Param<NSColor>) {
        if !self.wantsLayer {
            self.wantsLayer = true
        }
        
        self.layer?.borderColor = layerBorderColor.optionalValue?.cgColor
    }
}

#endif
