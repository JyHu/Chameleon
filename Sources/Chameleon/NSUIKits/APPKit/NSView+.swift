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
                action: { [weak self] va in self?.__setLayerBackgroundColor(va) }
            )
        }
        get {
            guard let cgColor = layer?.backgroundColor else { return nil }
            return NSColor(cgColor: cgColor)
        }
    }
    
    var app_layerBorderColor: NSColor? {
        set {
            cache(
                firstParam: Callable.Appearanced(newValue),
                identifier: .layerBorderColor,
                action: { [weak self] va in self?.__setLayerBorderColor(va) }
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
