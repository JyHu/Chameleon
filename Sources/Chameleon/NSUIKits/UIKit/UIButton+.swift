//
//  File.swift
//  
//
//  Created by Jo on 2023/4/6.
//

#if canImport(UIKit)

import UIKit

private extension AppearanceCallableIdentifier {
    static let setTitleColorForControlState = "UIButton.__setTitleColor(_:for:)"
}

private extension UIControl.State {
    var appearancedCategory: String {
        return "\(rawValue)"
    }
}

public extension UIButton {
    func app_setTitleColor(_ titleColor: UIColor?, for controlState: State) {
        if __USING_APPEARANCED_SWIZZING__ || titleColor?.appearanceIdentifier == nil {
            setTitleColor(titleColor, for: controlState)
        } else {
            if let titleColor {
                cache(
                    valA: titleColor,
                    valB: controlState,
                    identifier: .setTitleColorForControlState,
                    action: __setTitleColor(_:for:),
                    category: controlState.appearancedCategory
                )
            } else {
                __setTitleColor(nil, for: controlState)
            }
        }
    }
}

internal extension UIButton {
    static func silenceExchangeButtonImplementation() {
        app_swizzing(
            originalSelector: #selector(setTitleColor(_:for:)),
            newSelector: #selector(swizzled_setTitleColor(_:for:))
        )
    }
}

private extension UIButton {
    func __setTitleColor(_ titleColor: UIColor?, for controlState: State) {
        if __USING_APPEARANCED_SWIZZING__ {
            swizzled_setTitleColor(titleColor, for: controlState)
        } else {
            setTitleColor(titleColor, for: controlState)
        }
    }
    
    @objc func swizzled_setTitleColor(_ titleColor: UIColor?, for controlState: State) {
        if let titleColor, titleColor.appearanceIdentifier != nil {
            cache(
                valA: titleColor,
                valB: controlState,
                identifier: .setTitleColorForControlState,
                action: __setTitleColor(_:for:),
                category: controlState.appearancedCategory
            )
        } else {
            swizzled_setTitleColor(titleColor, for: controlState)
        }
    }
}

#endif
