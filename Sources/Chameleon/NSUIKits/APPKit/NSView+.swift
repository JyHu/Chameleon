//
//  File.swift
//  
//
//  Created by Jo on 2023/4/4.
//

#if os(macOS)

import Cocoa

private extension AppearanceCallableIdentifier {
    static let layerBackgroundColor = "NSView.__setLayerBackgroundColor(_:)"
    static let layerBorderColor = "NSView.__setLayerBorderColor(_:)"
}

public extension NSView {
    var app_layerBackgroundColor: NSColor? {
        set {
            cache(
                firstParam: Callable.Appearanced(newValue),
                identifier: .layerBackgroundColor,
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
                firstParam: Callable.Appearanced(newValue),
                identifier: .layerBorderColor,
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
