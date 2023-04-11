//
//  File.swift
//  
//
//  Created by Jo on 2023/4/11.
//

#if os(iOS)

import UIKit

public extension UIProgressView {
    var app_progressTintColor: UIColor? {
        get { progressTintColor }
        set {
            
        }
    }
    
    var app_trackTintColor: UIColor? {
        get { trackTintColor }
        set {
            
        }
    }
    
    var app_progressImage: UIImage? {
        get { progressImage }
        set {
            
        }
    }
    
    var app_trackImage: UIImage? {
        get { trackImage }
        set {
            
        }
    }
}

internal extension UIProgressView {
    static func silenceExchangeProgressViewImplementation() {
        
    }
}

private extension UIProgressView {
    
}

#endif
