//
//  File.swift
//  
//
//  Created by Jo on 2023/4/11.
//

#if os(iOS)

import UIKit

public extension UITextField {
    var app_attributedText: NSAttributedString? {
        get { attributedText }
        set {
            
        }
    }
    
    var app_textColor: UIColor? {
        get { textColor }
        set {
            
        }
    }
    
    var app_defaultTextAttributes: [NSAttributedString.Key: Any] {
        get { defaultTextAttributes }
        set {
            
        }
    }
    
    var app_attributedPlaceholder: NSAttributedString? {
        get { attributedPlaceholder }
        set {
            
        }
    }
    
    var app_background: UIImage? {
        get { background }
        set {
            
        }
    }
    
    var app_disabledBackground: UIImage? {
        get { disabledBackground }
        set {
            
        }
    }
    
    var app_typingAttributes: [NSAttributedString.Key: Any]? {
        get { typingAttributes }
        set {
            
        }
    }
}

internal extension UITextField {
    static func silenceExchangeTextFieldImplementation() {
        
    }
}

private extension UITextField {
    
}

#endif
