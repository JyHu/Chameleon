//
//  File.swift
//  
//
//  Created by Jo on 2023/4/11.
//

#if os(macOS)

import UIKit

public extension UINavigationBar {
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
    
    var app_shadowImage: UIImage? {
        get { shadowImage }
        set {
            
        }
    }
    
    var app_titleTextAttributes: [NSAttributedString.Key: Any]? {
        get { titleTextAttributes }
        set {
            
        }
    }
    
    var app_largeTitleTextAttributes: [NSAttributedString.Key: Any]? {
        get { largeTitleTextAttributes }
        set {
            
        }
    }
    
    var app_backIndicatorImage: UIImage? {
        get { backIndicatorImage }
        set {
            
        }
    }
    
    var app_backIndicatorTransitionMaskImage: UIImage? {
        get { backIndicatorTransitionMaskImage }
        set {
            
        }
    }
    
    func app_setBackgroundImage(_ backgroundImage: UIImage?, for barPosition: UIBarPosition, barMetrics: UIBarMetrics) {
        
    }
    
    func app_setBackgroundImage(_ backgroundImage: UIImage?, for barMetrics: UIBarMetrics) {
        
    }
}

internal extension UINavigationBar {
    static func silenceExchangeNavigationBarImplementation() {
        
    }
}

private extension UINavigationBar {
    
}

#endif
