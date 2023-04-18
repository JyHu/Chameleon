//
//  File.swift
//  
//
//  Created by Jo on 2023/4/11.
//

#if os(iOS)

import UIKit

private extension AppearanceCallableIdentifier {
    static let attributedTitle = "UIRefreshControl.__setAttributedTitle(_:)"
}

public extension UIRefreshControl {
    var app_attributedTitle: NSAttributedString? {
        get { attributedTitle }
        set {
            if __USING_APPEARANCED_SWIZZLING__ {
                self.attributedTitle = newValue
            } else {
                swizzled_setAttributedTitle(newValue)
            }
        }
    }
}

internal extension UIRefreshControl {
    static func silenceExchangeRefreshControlImplementation() {
        app_swizzling(
            originalSelector: #selector(setter: attributedTitle),
            newSelector: #selector(swizzled_setAttributedTitle(_:))
        )
    }
}


private extension UIRefreshControl {
    func __setAttributedTitle(_ attributedTitle: NSAttributedString?) {
        if __USING_APPEARANCED_SWIZZLING__ {
            swizzled_setAttributedTitle(attributedTitle)
        } else {
            self.attributedTitle = attributedTitle
        }
    }
    
    @objc func swizzled_setAttributedTitle(_ attributedTitle: NSAttributedString?) {
        cache(
            firstParam: Callable.Attributed(attributedTitle),
            identifier: .attributedTitle,
            action: { [weak self] va in self?.__setAttributedTitle(va) }
        )
    }
}

#endif
