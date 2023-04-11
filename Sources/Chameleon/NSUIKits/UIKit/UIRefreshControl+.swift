//
//  File.swift
//  
//
//  Created by Jo on 2023/4/11.
//

#if os(iOS)

import UIKit

public extension UIRefreshControl {
    var app_tintColor: UIColor {
        get { tintColor }
        set {
            
        }
    }
    
    var app_attributedTitle: NSAttributedString? {
        get { attributedTitle }
        set {
            
        }
    }
}

internal extension UIRefreshControl {
    static func silenceExchangeRefreshControlImplementation() {
        
    }
}

private extension UIRefreshControl {
    
}

#endif
