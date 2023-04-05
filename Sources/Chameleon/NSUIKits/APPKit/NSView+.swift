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
            if let newValue {
                cache(
                    valA: newValue,
                    identifier: "NSView.__setLayerBackgroundColor(_:)",
                    action: __setLayerBackgroundColor(_:)
                )
            } else {
                __setLayerBackgroundColor(nil)
            }
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
            if let newValue {
                cache(
                    valA: newValue,
                    identifier: "NSView.__setLayerBorderColor(_:)",
                    action: __setLayerBorderColor(_:)
                )
            } else {
                __setLayerBorderColor(nil)
            }
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
    func __setLayerBackgroundColor(_ layerBackgroundColor: NSColor?) {
        if !self.wantsLayer {
            self.wantsLayer = true
        }
        
        self.layer?.backgroundColor = layerBackgroundColor?.cgColor
    }
    
    func __setLayerBorderColor(_ layerBorderColor: NSColor?) {
        if !self.wantsLayer {
            self.wantsLayer = true
        }
        
        self.layer?.borderColor = layerBorderColor?.cgColor
    }
}

#endif
