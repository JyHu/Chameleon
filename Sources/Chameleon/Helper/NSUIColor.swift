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


public extension NSUIAppearanceColor {
    static func colorWith(appearanceIdentifier: AppearanceCallableIdentifier) -> NSUIAppearanceColor? {
        return Chameleon.shared.color(with: appearanceIdentifier)
    }
    
    static func colorWith(appearancedValue: String) -> NSUIAppearanceColor? {
        if appearancedValue == "random" {
            return app_random()
        }
        
        if appearancedValue.hasPrefix("rgba") {
            guard let rgbaStr = appearancedValue.app_substringWithPattern("(?<=<).*?(?=>)"), rgbaStr.count > 0 else { return nil }
            let components = rgbaStr.replacingOccurrences(of: " ", with: "").components(separatedBy: ",")
            guard components.count == 4 else { return nil }
            guard let red = Double(components[0]),
                  let green = Double(components[1]),
                  let blue = Double(components[2]),
                  let alpha = Double(components[3]) else { return nil }
            
            return app_colorWith(red: red, green: green, blue: blue, alpha: alpha)
        }
        
        if appearancedValue.hasPrefix("hex") {
            guard let hexString = appearancedValue.app_substringWithPattern("(?<=<).*?(?=>)"), hexString.count > 0 else { return nil }
            return app_colorWith(hexAString: hexString)
        }
        
        return app_colorWith(hexAString: appearancedValue)
    }
}

internal extension NSUIAppearanceColor {
    static func app_random() -> NSUIAppearanceColor {
        return app_colorWith(
            red: CGFloat(arc4random_uniform(256)),
            green: CGFloat(arc4random_uniform(256)),
            blue: CGFloat(arc4random_uniform(256))
        )
    }
    
    static func app_colorWith(hexAString: String) -> NSUIAppearanceColor? {
        let components = hexAString.components(separatedBy: " ")
        if components.count <= 1 {
            return app_colorWith(hexString: hexAString)
        }
        
        guard let hexString = components.first,
              let alphaString = components.last,
              let color = app_colorWith(hexString: hexString),
              let alpha = Double(alphaString) else {
            return nil
        }
        
        if alpha == 1 {
            return color
        }
        
        if alpha == 0 {
            return .clear
        }
        
        return color.withAlphaComponent(alpha)
    }
    
    static func app_colorWith(hexString: String) -> NSUIAppearanceColor? {
        if hexString.isEmpty { return nil }
        var hexValue: UInt64 = 0
        let scanner = Scanner(string: hexString)
        scanner.scanHexInt64(&hexValue)
        return app_colorWith(hexValue: hexValue)
    }
    
    static func app_colorWith(hexValue: UInt64) -> NSUIAppearanceColor {
        return app_colorWith(
            red: CGFloat((hexValue & 0xFF0000) >> 16),
            green: CGFloat((hexValue & 0xFF00) >> 8),
            blue: CGFloat(hexValue & 0xFF)
        )
    }
    
    static func app_colorWith(red: CGFloat, green: CGFloat, blue: CGFloat, alpha: CGFloat = 1) -> NSUIAppearanceColor {
        return NSUIAppearanceColor(red: red / 255, green: green / 255, blue: blue / 255, alpha: alpha)
    }
}
