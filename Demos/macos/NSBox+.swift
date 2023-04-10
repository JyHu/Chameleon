//
//  NSBox+.swift
//  macos
//
//  Created by Jo on 2023/4/5.
//

import Cocoa
import Chameleon

extension NSBox {
    var app_borderWidth: CGFloat {
        set {
            cache(appearanceCallable: Callable.One(
                firstParam: Callable.Appearanced(newValue, identifier: "others/border/width"),
                identifier: "NSBox.__setBorderWidth(_:)",
                action: __setBorderWidth(_:))
            )
        }
        get {
            borderWidth
        }
    }
    
    func customized(color1: NSColor, color2: NSColor) {
        cache(appearanceCallable:
                Callable.Two(
                    firstParam: Callable.Appearanced(color1, identifier: color1.appearanceIdentifier, clsType: .other),
                    secondParam: Callable.Appearanced(color2, identifier: color2.appearanceIdentifier, clsType: .other),
                    identifier: "NSBox.__customized(color1:color2:)",
                    action: __customized(color1:color2:)
                )
        )
    }
}

private extension NSBox {
    func __setBorderWidth(_ borderWidth: CGFloat) {
        self.borderWidth = borderWidth
    }
    
    func __customized(color1: Any, color2: Any) {
        print("--> \(color1), \(color2)")
    }
}
