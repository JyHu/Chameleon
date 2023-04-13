//
//  File.swift
//  
//
//  Created by Jo on 2023/4/11.
//

#if os(iOS)

import UIKit

private extension AppearanceCallableIdentifier {
    static let progressTintColor = "UIProgressView.__setProgressTintColor(_:)"
    static let trackTintColor = "UIProgressView.__setTrackTintColor(_:)"
    static let progressImage = "UIProgressView.__setProgressImage(_:)"
    static let trackImage = "UIProgressView.__setTrackImage(_:)"
}

public extension UIProgressView {
    var app_progressTintColor: UIColor? {
        get { progressTintColor }
        set {
            if __USING_APPEARANCED_SWIZZING__ {
                self.progressTintColor = newValue
            } else {
                swizzled_setProgressTintColor(newValue)
            }
        }
    }
    
    var app_trackTintColor: UIColor? {
        get { trackTintColor }
        set {
            if __USING_APPEARANCED_SWIZZING__ {
                self.trackTintColor = newValue
            } else {
                swizzled_setTrackTintColor(newValue)
            }
        }
    }
    
    var app_progressImage: UIImage? {
        get { progressImage }
        set {
            if __USING_APPEARANCED_SWIZZING__ {
                self.progressImage = newValue
            } else {
                swizzled_setProgressImage(newValue)
            }
        }
    }
    
    var app_trackImage: UIImage? {
        get { trackImage }
        set {
            if __USING_APPEARANCED_SWIZZING__ {
                self.trackImage = newValue
            } else {
                swizzled_setTrackImage(newValue)
            }
        }
    }
}

internal extension UIProgressView {
    static func silenceExchangeProgressViewImplementation() {
        app_swizzing(
            originalSelector: #selector(setter: progressTintColor),
            newSelector: #selector(swizzled_setProgressTintColor(_:))
        )
        
        app_swizzing(
            originalSelector: #selector(setter: trackTintColor),
            newSelector: #selector(swizzled_setTrackTintColor(_:))
        )
        
        app_swizzing(
            originalSelector: #selector(setter: progressImage),
            newSelector: #selector(swizzled_setProgressImage(_:))
        )
        
        app_swizzing(
            originalSelector: #selector(setter: trackImage),
            newSelector: #selector(swizzled_setTrackImage(_:))
        )
    }
}

private extension UIProgressView {
    func __setProgressTintColor(_ progressTintColor: UIColor?) {
        if __USING_APPEARANCED_SWIZZING__ {
            swizzled_setProgressTintColor(progressTintColor)
        } else {
            self.progressTintColor = progressTintColor
        }
    }
    
    func __setTrackTintColor(_ trackTintColor: UIColor?) {
        if __USING_APPEARANCED_SWIZZING__ {
            swizzled_setTrackTintColor(trackTintColor)
        } else {
            self.trackTintColor = trackTintColor
        }
    }
    
    func __setProgressImage(_ progressImage: UIImage?) {
        if __USING_APPEARANCED_SWIZZING__ {
            swizzled_setProgressImage(progressImage)
        } else {
            self.progressImage = progressImage
        }
    }
    
    func __setTrackImage(_ trackImage: UIImage?) {
        if __USING_APPEARANCED_SWIZZING__ {
            swizzled_setTrackImage(trackImage)
        } else {
            self.trackImage = trackImage
        }
    }
    
    
    @objc func swizzled_setProgressTintColor(_ progressTintColor: UIColor?) {
        cache(
            firstParam: Callable.Appearanced(progressTintColor),
            identifier: .progressTintColor,
            action: { [weak self] va in self?.__setProgressTintColor(va) }
        )
    }
    
    @objc func swizzled_setTrackTintColor(_ trackTintColor: UIColor?) {
        cache(
            firstParam: Callable.Appearanced(trackTintColor),
            identifier: .trackTintColor,
            action: { [weak self] va in self?.__setTrackTintColor(va) }
        )
    }
    
    @objc func swizzled_setProgressImage(_ progressImage: UIImage?) {
        cache(
            firstParam: Callable.Appearanced(progressImage),
            identifier: .progressImage,
            action: { [weak self] va in self?.__setProgressImage(va) }
        )
    }
    
    @objc func swizzled_setTrackImage(_ trackImage: UIImage?) {
        cache(
            firstParam: Callable.Appearanced(trackImage),
            identifier: .trackImage,
            action: { [weak self] va in self?.__setTrackImage(va) }
        )
    }
}

#endif
