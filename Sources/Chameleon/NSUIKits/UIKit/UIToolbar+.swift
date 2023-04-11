//
//  File.swift
//  
//
//  Created by Jo on 2023/4/11.
//

#if os(iOS)

import UIKit

public extension UIToolbar {
    var app_tintColor: UIColor {
        get { tintColor }
        set {
            
        }
    }
    
    var app_barTintColor: UIColor? {
        get { barTintColor }
        set {
            
        }
    }
    
    func app_setBackgroundImage(_ backgroundImage: UIImage?, forToolbarPosition: UIBarPosition, barMetrics: UIBarMetrics) {
        
    }
    
    func app_setShadowImage(_ shadowImage: UIImage?, forToolbarPosition: UIBarPosition) {
        
    }
}

internal extension UIToolbar {
    static func silenceExchangeToolbarImplementation() {
        
    }
}

private extension UIToolbar {
    
}

#endif
