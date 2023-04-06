//
//  File.swift
//  
//
//  Created by Jo on 2023/4/3.
//

#if canImport(Cocoa)
import Cocoa
#elseif canImport(UIKit)
import UIKit
#endif

public extension NSUIAppearanceImage {
    static func imageWith(appearanceIdentifier: AppearanceCallableIdentifier) -> NSUIAppearanceImage? {
        return AppearanceManager.shared.image(with: appearanceIdentifier)
    }
    
    static func imageWith(appearancedValue: Any) throws -> NSUIAppearanceImage? {
        if let imageInfo = appearancedValue as? String {
            if imageInfo.hasPrefix("file://") {
                return app_imageWith(fileName: imageInfo.app_substringFrom(7))
            }
            
            return NSUIAppearanceImage(named: imageInfo)
        }
        
        guard let imageInfo = appearancedValue as? [String: Any] else {
            throw APPError.unknowImageAppearance(appearancedValue)
        }
        
        if let name = imageInfo["name"] as? String {
            return NSUIAppearanceImage(named: name)
        }
        
        if let file = imageInfo["file"] as? String {
            return app_imageWith(fileName: file)
        }
        
        if let hexString = imageInfo["color"] as? String,
            let color = NSUIAppearanceColor.app_colorWith(hexAString: hexString) {
            return NSUIAppearanceImage.app_imageWith(color: color)
        }
        
        return nil
    }
}

private extension NSUIAppearanceImage {
    static func app_imageWith(color: NSUIAppearanceColor, size: CGSize = CGSize(width: 1, height: 1)) -> NSUIAppearanceImage? {
#if os(macOS)
        return NSImage(size: size, flipped: true) { dstRect in
            color.setFill()
            dstRect.fill()
            return true
        }
#else
        let rect = CGRect(origin: .zero, size: size)
        UIGraphicsBeginImageContext(size)
        let context = UIGraphicsGetCurrentContext()
        
        context?.setFillColor(color.cgColor)
        context?.fill([rect])
        
        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        return image
#endif
    }
    
    static func app_imageWith(fileName: String?) -> NSUIAppearanceImage? {
        guard let themePath = AppearanceManager.shared.currentThemePath, let fileName = fileName else { return nil }
        let imagePath = NSString(string: themePath).appendingPathComponent(fileName)
        
        guard FileManager.default.fileExists(atPath: imagePath) else {
            return nil
        }
        
        return NSUIAppearanceImage(contentsOfFile: imagePath)
    }
}
