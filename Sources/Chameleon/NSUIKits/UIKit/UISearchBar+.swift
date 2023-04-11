//
//  File.swift
//  
//
//  Created by Jo on 2023/4/11.
//

#if os(iOS)

import UIKit

public extension UISearchBar {
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
    
    var app_backgroundImage: UIImage? {
        get { backgroundImage }
        set {
            
        }
    }
    
    var app_scopeBarBackgroundImage: UIImage? {
        get { scopeBarBackgroundImage }
        set {
            
        }
    }
    
    func app_setBackgroundImage(_ backgroundImage: UIImage?, for barPosition: UIBarPosition, barMetrics: UIBarMetrics) {
        
    }
    
    func app_setSearchFieldBackgroundImage(_ backgroundImage: UIImage?, for state: UIControl.State) {
        
    }
    
    func app_setImage(_ image: UIImage?, for icon: Icon, state: UIControl.State) {
        
    }
    
    func app_setScopeBarButtonBackgroundImage(_ backgroundImage: UIImage?, for state: UIControl.State) {
        
    }
    
    func app_setScopeBarButtonDividerImage(_ dividerImage: UIImage?, forLeftSegmentState leftSegmentState: UIControl.State, rightSegmentState: UIControl.State) {
        
    }
    
    func app_setScopeBarButtonTitleTextAttributes(_ attributes: [NSAttributedString.Key: Any]?, for state: UIControl.State) {
        
    }
}

internal extension UISearchBar {
    static func silenceExchangeSearchBarImplementation() {
        
    }
}

private extension UISearchBar {
    
}

#endif
