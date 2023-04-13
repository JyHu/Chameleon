//
//  File.swift
//  
//
//  Created by Jo on 2023/4/11.
//

#if os(iOS)

import UIKit

private extension AppearanceCallableIdentifier {
    static let sectionIndexColor = "UITableView.__setSectionIndexColor(_:)"
    static let sectionIndexBackgroundColor = "UITableView.__setSectionIndexBackgroundColor(_:)"
    static let sectionIndexTrackingBackgroundColor = "UITableView.__setSectionIndexTrackingBackgroundColor(_:)"
    static let separatorColor = "UITableView.__setSeparatorColor(_:)"
}

public extension UITableView {
    var app_sectionIndexColor: UIColor? {
        get { sectionIndexColor }
        set {
            if __USING_APPEARANCED_SWIZZING__ {
                self.sectionIndexColor = newValue
            } else {
                swizzled_setSectionIndexColor(newValue)
            }
        }
    }
    
    var app_sectionIndexBackgroundColor: UIColor? {
        get { sectionIndexBackgroundColor }
        set {
            if __USING_APPEARANCED_SWIZZING__ {
                self.sectionIndexBackgroundColor = newValue
            } else {
                swizzled_setSectionIndexBackgroundColor(newValue)
            }
        }
    }
    
    var app_sectionIndexTrackingBackgroundColor: UIColor? {
        get { sectionIndexTrackingBackgroundColor }
        set {
            if __USING_APPEARANCED_SWIZZING__ {
                self.sectionIndexTrackingBackgroundColor = newValue
            } else {
                swizzled_setSectionIndexTrackingBackgroundColor(newValue)
            }
        }
    }
    
    var app_separatorColor: UIColor? {
        get { separatorColor }
        set {
            if __USING_APPEARANCED_SWIZZING__ {
                self.separatorColor = newValue
            } else {
                swizzled_setSeparatorColor(newValue)
            }
        }
    }
}

internal extension UITableView {
    static func silenceExchangeTableViewImplementation() {
        app_swizzing(
            originalSelector: #selector(setter: sectionIndexColor),
            newSelector: #selector(swizzled_setSectionIndexColor)
        )
        
        app_swizzing(
            originalSelector: #selector(setter: sectionIndexBackgroundColor),
            newSelector: #selector(swizzled_setSectionIndexBackgroundColor)
        )
        
        app_swizzing(
            originalSelector: #selector(setter: sectionIndexTrackingBackgroundColor),
            newSelector: #selector(swizzled_setSectionIndexTrackingBackgroundColor)
        )
        
        app_swizzing(
            originalSelector: #selector(setter: separatorColor),
            newSelector: #selector(swizzled_setSeparatorColor)
        )
    }
}

private extension UITableView {
    func __setSectionIndexColor(_ sectionIndexColor: UIColor?) {
        if __USING_APPEARANCED_SWIZZING__ {
            swizzled_setSectionIndexColor(sectionIndexColor)
        } else {
            self.sectionIndexColor = sectionIndexColor
        }
    }
    
    func __setSectionIndexBackgroundColor(_ sectionIndexBackgroundColor: UIColor?) {
        if __USING_APPEARANCED_SWIZZING__ {
            swizzled_setSectionIndexBackgroundColor(sectionIndexBackgroundColor)
        } else {
            self.sectionIndexBackgroundColor = sectionIndexBackgroundColor
        }
    }
    
    func __setSectionIndexTrackingBackgroundColor(_ sectionIndexTrackingBackgroundColor: UIColor?) {
        if __USING_APPEARANCED_SWIZZING__ {
            swizzled_setSectionIndexTrackingBackgroundColor(sectionIndexTrackingBackgroundColor)
        } else {
            self.sectionIndexTrackingBackgroundColor = sectionIndexTrackingBackgroundColor
        }
    }
    
    func __setSeparatorColor(_ separatorColor: UIColor?) {
        if __USING_APPEARANCED_SWIZZING__ {
            swizzled_setSeparatorColor(separatorColor)
        } else {
            self.separatorColor = separatorColor
        }
    }
    
    
    @objc func swizzled_setSectionIndexColor(_ sectionIndexColor: UIColor?) {
        cache(
            firstParam: Callable.Appearanced(sectionIndexColor),
            identifier: .sectionIndexColor,
            action: { [weak self] va in self?.__setSectionIndexColor(va) }
        )
    }
    
    @objc func swizzled_setSectionIndexBackgroundColor(_ sectionIndexBackgroundColor: UIColor?) {
        cache(
            firstParam: Callable.Appearanced(sectionIndexBackgroundColor),
            identifier: .sectionIndexBackgroundColor,
            action: { [weak self] va in self?.__setSectionIndexBackgroundColor(va) }
        )
    }
    
    @objc func swizzled_setSectionIndexTrackingBackgroundColor(_ sectionIndexTrackingBackgroundColor: UIColor?) {
        cache(
            firstParam: Callable.Appearanced(sectionIndexTrackingBackgroundColor),
            identifier: .sectionIndexTrackingBackgroundColor,
            action: { [weak self] va in self?.__setSectionIndexTrackingBackgroundColor(va) }
        )
    }
    
    @objc func swizzled_setSeparatorColor(_ separatorColor: UIColor?) {
        cache(
            firstParam: Callable.Appearanced(separatorColor),
            identifier: .separatorColor,
            action: { [weak self] va in self?.__setSeparatorColor(va) }
        )
    }
    
    
}

#endif
