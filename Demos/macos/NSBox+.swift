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
            cache(valA: .required(["width": newValue]), identifier: "NSBox.__setBorderWidth(_:)", action: __setBorderWidth(_:))
        }
        get {
            borderWidth
        }
    }
}

private extension NSBox {
    func __setBorderWidth(_ borderWidth: Callable.Param<[String: CGFloat]>) {
        
    }
}
