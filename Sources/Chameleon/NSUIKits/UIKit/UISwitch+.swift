//
//  File.swift
//  
//
//  Created by Jo on 2023/4/11.
//

#if os(iOS)

import UIKit

public extension UISwitch {
    var app_onTintColor: UIColor? {
        get { onTintColor }
        set {
            
        }
    }
    
    var app_thumbTintColor: UIColor? {
        get { thumbTintColor }
        set {
            
        }
    }
    
    var app_onImage: UIImage? {
        get { onImage }
        set {
            
        }
    }
    
    var app_offImage: UIImage? {
        get { offImage }
        set {
            
        }
    }
}

internal extension UISwitch {
    static func silenceExchangeSwitchImplementation() {
        
    }
}

private extension UISwitch {
    
}

#endif
