//
//  TestColors.swift
//  macos
//
//  Created by Jo on 2023/4/4.
//

#if os(macOS)
import Cocoa
#else
import UIKit
#endif

import Chameleon

extension NSUIAppearanceColor {
    static let C001 = NSUIAppearanceColor.colorWith(hexAString: "F7ACBC")
        .withAppearanceIdentifier("color/text/C001")
    static let C002 = NSUIAppearanceColor.colorWith(hexAString: "DEAB8A")
        .withAppearanceIdentifier("color/text/C002")
    static let C003 = NSUIAppearanceColor.colorWith(hexAString: "B17936")
        .withAppearanceIdentifier("color/text/C003")
    static let C004 = NSUIAppearanceColor.colorWith(hexAString: "444693")
        .withAppearanceIdentifier("color/text/C004")
    static let C005 = NSUIAppearanceColor.colorWith(hexAString: "EF5B9C")
        .withAppearanceIdentifier("color/text/C005")
    static let C006 = NSUIAppearanceColor.colorWith(hexAString: "FEDCBD")
        .withAppearanceIdentifier("color/text/C006")
    static let C007 = NSUIAppearanceColor.colorWith(hexAString: "7F7522")
        .withAppearanceIdentifier("color/text/C007")
    static let C008 = NSUIAppearanceColor.colorWith(hexAString: "2B4490")
        .withAppearanceIdentifier("color/text/C008")
    
    
    static let C101 = NSUIAppearanceColor.colorWith(hexAString: "FEEEED")
        .withAppearanceIdentifier("color/background/C101")
    static let C102 = NSUIAppearanceColor.colorWith(hexAString: "747920")
        .withAppearanceIdentifier("color/background/C102")
    static let C103 = NSUIAppearanceColor.colorWith(hexAString: "80752C")
        .withAppearanceIdentifier("color/background/C103")
    static let C104 = NSUIAppearanceColor.colorWith(hexAString: "2A5CAA")
        .withAppearanceIdentifier("color/background/C104")
    static let C105 = NSUIAppearanceColor.colorWith(hexAString: "F05B72")
        .withAppearanceIdentifier("color/background/C105")
    static let C106 = NSUIAppearanceColor.colorWith(hexAString: "905A3D")
        .withAppearanceIdentifier("color/background/C106")
    static let C107 = NSUIAppearanceColor.colorWith(hexAString: "87843B")
        .withAppearanceIdentifier("color/background/C107")
    static let C108 = NSUIAppearanceColor.colorWith(hexAString: "224B8F")
        .withAppearanceIdentifier("color/background/C108")
    
    
    
    
    
    static func colorWith(hexAString: String) -> NSUIAppearanceColor {
        let components = hexAString.components(separatedBy: " ")
        if components.count <= 1 {
            return colorWith(hexString: hexAString)
        }
        
        guard let hexString = components.first,
              let alphaString = components.last,
              let alpha = Double(alphaString) else {
            return .clear
        }
        
        let color = colorWith(hexString: hexString)
        
        if alpha == 1 {
            return color
        }
        
        if alpha == 0 {
            return .clear
        }
        
        return color.withAlphaComponent(alpha)
    }
    
    private static func colorWith(hexString: String) -> NSUIAppearanceColor {
        var hexValue: UInt = 0
        let scanner = Scanner(string: hexString)
        scanner.scanInt(&hexValue)
        
        return NSUIAppearanceColor(red: CGFloat((hexValue & 0xFF0000) >> 16) / 255, green: CGFloat((hexValue & 0xFF00) >> 8) / 255, blue: CGFloat(hexValue & 0xFF) / 255, alpha: 1)
    }
}
