//
//  File.swift
//  
//
//  Created by Jo on 2023/4/9.
//

#if os(macOS)

import Cocoa

private extension AppearanceCallableIdentifier {
    static let backgroundColors = "NSCollectionView.__setBackgroundColors(_:)"
}

public extension NSCollectionView {
    var app_backgroundColors: [NSColor] {
        get { backgroundColors }
        set {
            if __USING_APPEARANCED_SWIZZING__ {
                backgroundColors = newValue
            } else {
                swizzled_setBackgroundColors(newValue)
            }
        }
    }
}

internal extension NSCollectionView {
    static func silenceExchangeCollectionViewImplementation() {
        app_swizzing(
            originalSelector: #selector(setter: backgroundColors),
            newSelector: #selector(swizzled_setBackgroundColors(_:)))
    }
}

private extension NSCollectionView {
    func __setBackgroundColors(_ backgroundColors: [NSColor]) {
        if __USING_APPEARANCED_SWIZZING__ {
            swizzled_setBackgroundColors(backgroundColors)
        } else {
            self.backgroundColors = backgroundColors
        }
    }
    
    @objc func swizzled_setBackgroundColors(_ backgroundColors: [NSColor]) {
        cache(
            firstParam: Callable.Collection(backgroundColors),
            identifier: .backgroundColors,
            action: { [weak self] va in self?.__setBackgroundColors(va) }
        )
    }
}

#endif
