//
//  File.swift
//  
//
//  Created by Jo on 2023/4/11.
//

#if os(macOS)

import Cocoa

public extension NSSegmentedControl {
    var app_selectedSegmentBezelColor: NSColor? {
        get { selectedSegmentBezelColor }
        set {
            
        }
    }
    
    func app_setImage(_ image: NSImage?, forSegment segment: Int) {
        
    }
}

internal extension NSSegmentedControl {
    static func silenceExchangeSegmentedControlImplementation() {
        
    }
}

private extension NSSegmentedControl {
    
}

#endif
