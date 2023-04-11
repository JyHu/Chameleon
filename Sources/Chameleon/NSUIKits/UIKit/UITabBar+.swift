//
//  File.swift
//  
//
//  Created by Jo on 2023/4/11.
//

#if os(iOS)

import UIKit

public extension UITabBar {
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
    
    var app_unselectedItemTintColor: UIColor? {
        get { unselectedItemTintColor }
        set {
            
        }
    }
    
    var app_backgroundImage: UIImage? {
        get { backgroundImage }
        set {
            
        }
    }
    
    var app_selectionIndicatorImage: UIImage? {
        get { selectionIndicatorImage }
        set {
            
        }
    }
    
    var app_shadowImage: UIImage? {
        get { shadowImage }
        set {
            
        }
    }
}

internal extension UITabBar {
    static func silenceExchangeTabBarImplementation() {
        
    }
}

private extension UITabBar {
    
}

#endif
