//
//  File.swift
//  
//
//  Created by Jo on 2023/4/11.
//

#if os(macOS)

import Cocoa

public extension NSLevelIndicator {
    var app_fillColor: NSColor {
        get { fillColor }
        set {
            
        }
    }
    
    var app_warningFillColor: NSColor {
        get { warningFillColor }
        set {
            
        }
    }
    
    var app_criticalFillColor: NSColor {
        get { criticalFillColor }
        set {
            
        }
    }
    
    var app_ratingImage: NSImage? {
        get { ratingImage }
        set {
            
        }
    }
    
    var app_ratingPlaceholderImage: NSImage? {
        get { ratingPlaceholderImage }
        set {
            
        }
    }
}

indirect extension NSLevelIndicator {
    
}

private extension NSLevelIndicator {
    
}

#endif
