//
//  File.swift
//  
//
//  Created by Jo on 2023/4/11.
//

#if os(iOS)

import UIKit

public extension UITextView {
    var app_textColor: UIColor? {
        get { textColor }
        set {
            
        }
    }
    
    var app_attributedText: NSAttributedString {
        get { attributedText }
        set {
            
        }
    }
    
    var app_typingAttributes: [NSAttributedString.Key: Any] {
        get { typingAttributes }
        set {
            
        }
    }
    
    var app_linkTextAttributes: [NSAttributedString.Key: Any] {
        get { linkTextAttributes }
        set {
            
        }
    }
}

internal extension UITextView {
    static func silenceExchangeTextViewImplementation() {
        
    }
}

private extension UITextView {
    
}

#endif
