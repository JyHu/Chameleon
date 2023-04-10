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
    
    func customized(color1: NSColor, color2: NSColor?) {
        cache(appearanceCallable:
                Callable.Two(
                    firstParam: Callable.Customized(color1, identifier: color1.appearanceIdentifier, converter: __colorConverter(_:)),
                    secondParam: Callable.Customized(color2, identifier: color2?.appearanceIdentifier, converter: __colorConverter(_:)),
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
    
    func __customized(color1: NSColor, color2: NSColor?) {
        print("--> \(color1), \(String(describing: color2))")
    }
    
    func __colorConverter(_ appearanceInfo: Any?) -> NSColor? {
        let callable = findCallable(with: "NSBox.__customized(color1:color2:)") as? Callable.Two<Callable.Customized<NSColor>, Callable.Customized<NSColor?>>
        let p1 = callable?.firstParam.original
        let p2 = callable?.secondParam.original
        print("--> \(String(describing: appearanceInfo)) \(String(describing: p1)) \(String(describing: p2))")
        return nil
    }
}
