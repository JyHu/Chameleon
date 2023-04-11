//
//  File.swift
//  
//
//  Created by Jo on 2023/4/11.
//

#if os(iOS)

import UIKit

public extension UIPageControl {
    var app_pageIndicatorTintColor: UIColor? {
        get { pageIndicatorTintColor }
        set {
            
        }
    }
    
    var app_currentPageIndicatorTintColor: UIColor? {
        get { currentPageIndicatorTintColor }
        set {
            
        }
    }
    
    @available(iOS 14.0, *)
    var app_preferredIndicatorImage: UIImage? {
        get { preferredIndicatorImage }
        set {
            
        }
    }
    
    @available(iOS 16.0, *)
    var app_preferredCurrentPageIndicatorImage: UIImage? {
        get { preferredCurrentPageIndicatorImage }
        set {
            
        }
    }
    
    func app_setIndicatorImage(_ indicatorImage: UIImage?, forPage: Int) {
        
    }
    
    func app_setCurrentPageIndicatorImage(_ indicatorImage: UIImage?, forPage: Int) {
        
    }
}

internal extension UIPageControl {
    static func silenceExchangePageControlImplementation() {
        
    }
}

private extension UIPageControl {
    
}

#endif
