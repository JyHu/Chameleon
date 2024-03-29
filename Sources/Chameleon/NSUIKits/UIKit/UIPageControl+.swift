//
//  File.swift
//  
//
//  Created by Jo on 2023/4/11.
//

#if os(iOS)

import UIKit

private extension AppearanceCallableIdentifier {
    static let pageIndicatorTintColor = "__setPageIndicatorTintColor(_:)"
    static let currentPageIndicatorTintColor = "__setCurrentPageIndicatorTintColor(_:)"
    static let preferredIndicatorImage = "__setPreferredIndicatorImage(_:)"
    static let preferredCurrentPageIndicatorImage = "__setPreferredCurrentPageIndicatorImage(_:)"
    static let setIndicatorImageForPage = "__setIndicatorImage(_:forPage:)"
    static let setCurrentPageIndicatorImageForPage = "__setCurrentPageIndicatorImage(_:forPage:)"
}

public extension UIPageControl {
    var app_pageIndicatorTintColor: UIColor? {
        get { pageIndicatorTintColor }
        set {
            if __USING_APPEARANCED_SWIZZLING__ {
                self.pageIndicatorTintColor = newValue
            } else {
                swizzled_setPageIndicatorTintColor(newValue)
            }
        }
    }
    
    var app_currentPageIndicatorTintColor: UIColor? {
        get { currentPageIndicatorTintColor }
        set {
            if __USING_APPEARANCED_SWIZZLING__ {
                self.currentPageIndicatorTintColor = newValue
            } else {
                swizzled_setCurrentPageIndicatorTintColor(newValue)
            }
        }
    }
    
    @available(iOS 14.0, *)
    var app_preferredIndicatorImage: UIImage? {
        get { preferredIndicatorImage }
        set {
            if __USING_APPEARANCED_SWIZZLING__ {
                self.preferredIndicatorImage = newValue
            } else {
                swizzled_setPreferredIndicatorImage(newValue)
            }
        }
    }
    
    @available(iOS 16.0, *)
    var app_preferredCurrentPageIndicatorImage: UIImage? {
        get { preferredCurrentPageIndicatorImage }
        set {
            if __USING_APPEARANCED_SWIZZLING__ {
                self.preferredCurrentPageIndicatorImage = newValue
            } else {
                swizzled_setPreferredCurrentPageIndicatorImage(newValue)
            }
        }
    }
    
    @available(iOS 14.0, *)
    func app_setIndicatorImage(_ indicatorImage: UIImage?, forPage page: Int) {
        if __USING_APPEARANCED_SWIZZLING__ {
            self.setIndicatorImage(indicatorImage, forPage: page)
        } else {
            swizzled_setIndicatorImage(indicatorImage, forPage: page)
        }
    }
    
    @available(iOS 16.0, *)
    func app_setCurrentPageIndicatorImage(_ indicatorImage: UIImage?, forPage page: Int) {
        if __USING_APPEARANCED_SWIZZLING__ {
            self.setCurrentPageIndicatorImage(indicatorImage, forPage: page)
        } else {
            swizzled_setCurrentPageIndicatorImage(indicatorImage, forPage: page)
        }
    }
}

internal extension UIPageControl {
    static func silenceExchangePageControlImplementation() {
        app_swizzling(
            originalSelector: #selector(setter: pageIndicatorTintColor),
            newSelector: #selector(swizzled_setPageIndicatorTintColor(_:))
        )
        
        app_swizzling(
            originalSelector: #selector(setter: currentPageIndicatorTintColor),
            newSelector: #selector(swizzled_setCurrentPageIndicatorTintColor(_:))
        )
        
        if #available(iOS 14.0, *) {
            app_swizzling(
                originalSelector: #selector(setter: preferredIndicatorImage),
                newSelector: #selector(swizzled_setPreferredIndicatorImage(_:))
            )
            
            app_swizzling(
                originalSelector: #selector(setIndicatorImage(_:forPage:)),
                newSelector: #selector(swizzled_setIndicatorImage(_:forPage:))
            )
        }
        
        
        if #available(iOS 16.0, *) {
            app_swizzling(
                originalSelector: #selector(setter: preferredCurrentPageIndicatorImage),
                newSelector: #selector(swizzled_setPreferredCurrentPageIndicatorImage(_:))
            )
            
            app_swizzling(
                originalSelector: #selector(setCurrentPageIndicatorImage(_:forPage:)),
                newSelector: #selector(swizzled_setCurrentPageIndicatorImage(_:forPage:))
            )
        }
    }
}

private extension UIPageControl {
    func __setPageIndicatorTintColor(_ pageIndicatorTintColor: UIColor?) {
        if __USING_APPEARANCED_SWIZZLING__ {
            swizzled_setPageIndicatorTintColor(pageIndicatorTintColor)
        } else {
            self.pageIndicatorTintColor = pageIndicatorTintColor
        }
    }
    
    func __setCurrentPageIndicatorTintColor(_ currentPageIndicatorTintColor: UIColor?) {
        if __USING_APPEARANCED_SWIZZLING__ {
            swizzled_setCurrentPageIndicatorTintColor(currentPageIndicatorTintColor)
        } else {
            self.currentPageIndicatorTintColor = currentPageIndicatorTintColor
        }
    }
    
    @available(iOS 14.0, *)
    func __setPreferredIndicatorImage(_ preferredIndicatorImage: UIImage?) {
        if __USING_APPEARANCED_SWIZZLING__ {
            swizzled_setPreferredIndicatorImage(preferredIndicatorImage)
        } else {
            self.preferredIndicatorImage = preferredIndicatorImage
        }
    }
    
    @available(iOS 16.0, *)
    func __setPreferredCurrentPageIndicatorImage(_ preferredCurrentPageIndicatorImage: UIImage?) {
        if __USING_APPEARANCED_SWIZZLING__ {
            swizzled_setPreferredCurrentPageIndicatorImage(preferredCurrentPageIndicatorImage)
        } else {
            self.preferredCurrentPageIndicatorImage = preferredCurrentPageIndicatorImage
        }
    }
    
    @available(iOS 14.0, *)
    func __setIndicatorImage(_ indicatorImage: UIImage?, forPage page: Int) {
        if __USING_APPEARANCED_SWIZZLING__ {
            swizzled_setIndicatorImage(indicatorImage, forPage: page)
        } else {
            self.setIndicatorImage(indicatorImage, forPage: page)
        }
    }
    
    @available(iOS 16.0, *)
    func __setCurrentPageIndicatorImage(_ indicatorImage: UIImage?, forPage page: Int) {
        if __USING_APPEARANCED_SWIZZLING__ {
            swizzled_setCurrentPageIndicatorImage(indicatorImage, forPage: page)
        } else {
            self.setCurrentPageIndicatorImage(indicatorImage, forPage: page)
        }
    }
    
    @objc func swizzled_setPageIndicatorTintColor(_ pageIndicatorTintColor: UIColor?) {
        cache(
            firstParam: Callable.Appearanced(pageIndicatorTintColor),
            identifier: .pageIndicatorTintColor,
            action: { [weak self] va in self?.__setPageIndicatorTintColor(va) }
        )
    }
    
    @objc func swizzled_setCurrentPageIndicatorTintColor(_ currentPageIndicatorTintColor: UIColor?) {
        cache(
            firstParam: Callable.Appearanced(currentPageIndicatorTintColor),
            identifier: .currentPageIndicatorTintColor,
            action: { [weak self] va in self?.__setCurrentPageIndicatorTintColor(va) }
        )
    }
    
    @available(iOS 14.0, *)
    @objc func swizzled_setPreferredIndicatorImage(_ preferredIndicatorImage: UIImage?) {
        cache(
            firstParam: Callable.Appearanced(preferredIndicatorImage),
            identifier: .preferredIndicatorImage,
            action: { [weak self] va in self?.__setPreferredIndicatorImage(va) }
        )
    }
    
    @available(iOS 14.0, *)
    @objc func swizzled_setIndicatorImage(_ indicatorImage: UIImage?, forPage page: Int) {
        cache(
            firstParam: Callable.Appearanced(indicatorImage),
            secondParam: Callable.Original(page),
            identifier: .setIndicatorImageForPage,
            action: { [weak self] va, vb in self?.__setIndicatorImage(va, forPage: vb) }
        )
    }
    
    @available(iOS 16.0, *)
    @objc func swizzled_setPreferredCurrentPageIndicatorImage(_ preferredCurrentPageIndicatorImage: UIImage?) {
        cache(
            firstParam: Callable.Appearanced(preferredCurrentPageIndicatorImage),
            identifier: .preferredCurrentPageIndicatorImage,
            action: { [weak self] va in self?.__setPreferredCurrentPageIndicatorImage(va) }
        )
    }
    
    @available(iOS 16.0, *)
    @objc func swizzled_setCurrentPageIndicatorImage(_ indicatorImage: UIImage?, forPage page: Int) {
        cache(
            firstParam: Callable.Appearanced(indicatorImage),
            secondParam: Callable.Original(page),
            identifier: .setCurrentPageIndicatorImageForPage,
            action: { [weak self] va, vb in self?.__setCurrentPageIndicatorImage(va, forPage: vb) }
        )
    }
}

#endif
