//
//  File.swift
//  
//
//  Created by Jo on 2023/4/11.
//

#if os(iOS)

import UIKit

public extension UISlider {
    var app_minimumValueImage: UIImage? {
        get { minimumValueImage }
        set {
            
        }
    }
    
    var app_maximumValueImage: UIImage? {
        get { maximumValueImage }
        set {
            
        }
    }
    
    var app_minimumTrackTintColor: UIColor? {
        get { minimumTrackTintColor }
        set {
            
        }
    }
    
    var app_maximumTrackTintColor: UIColor? {
        get { maximumTrackTintColor }
        set {
            
        }
    }
    
    var app_thumbTintColor: UIColor? {
        get { thumbTintColor }
        set {
            
        }
    }
    
    var app_currentThumbImage: UIImage? {
        get { currentThumbImage }
        set {
            
        }
    }
    
    var app_currentMinimumTrackImage: UIImage? {
        get { currentMinimumTrackImage }
        set {
            
        }
    }
    
    var app_currentMaximumTrackImage: UIImage? {
        get { currentMaximumTrackImage }
        set {
            
        }
    }
    
    func app_setThumbImage(_ image: UIImage?, for state: UIControl.State) {
        
    }

    func app_setMinimumTrackImage(_ image: UIImage?, for state: UIControl.State) {
        
    }

    func app_setMaximumTrackImage(_ image: UIImage?, for state: UIControl.State) {
        
    }
    
}

internal extension UISlider {
    static func silenceExchangeSliderImplementation() {
        
    }
}

private extension UISlider {
    
}

#endif
