//
//  File.swift
//  
//
//  Created by Jo on 2023/4/11.
//

#if os(iOS)

import UIKit

public extension UITableView {
    var app_sectionIndexColor: UIColor? {
        get { sectionIndexColor }
        set {
            
        }
    }
    
    var app_sectionIndexBackgroundColor: UIColor? {
        get { sectionIndexBackgroundColor }
        set {
            
        }
    }
    
    var app_sectionIndexTrackingBackgroundColor: UIColor? {
        get { sectionIndexTrackingBackgroundColor }
        set {
            
        }
    }
    
    var app_separatorColor: UIColor? {
        get { separatorColor }
        set {
            
        }
    }
}

internal extension UITableView {
    static func silenceExchangeTableViewImplementation() {
        
    }
}

private extension UITableView {
    
}

#endif
