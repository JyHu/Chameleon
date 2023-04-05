//
//  TestColors.swift
//  macos
//
//  Created by Jo on 2023/4/4.
//

import Cocoa
import Chameleon

extension NSColor {
    static let C001 = NSColor.colorWith(hexAString: "F7ACBC")
        .withAppearanceIdentifier("color/text/C001")
    static let C002 = NSColor.colorWith(hexAString: "DEAB8A")
        .withAppearanceIdentifier("color/text/C002")
    static let C003 = NSColor.colorWith(hexAString: "B17936")
        .withAppearanceIdentifier("color/text/C003")
    static let C004 = NSColor.colorWith(hexAString: "444693")
        .withAppearanceIdentifier("color/text/C004")
    static let C005 = NSColor.colorWith(hexAString: "EF5B9C")
        .withAppearanceIdentifier("color/text/C005")
    static let C006 = NSColor.colorWith(hexAString: "FEDCBD")
        .withAppearanceIdentifier("color/text/C006")
    static let C007 = NSColor.colorWith(hexAString: "7F7522")
        .withAppearanceIdentifier("color/text/C007")
    static let C008 = NSColor.colorWith(hexAString: "2B4490")
        .withAppearanceIdentifier("color/text/C008")
    
    
    static let C101 = NSColor.colorWith(hexAString: "FEEEED")
        .withAppearanceIdentifier("color/background/C101")
    static let C102 = NSColor.colorWith(hexAString: "747920")
        .withAppearanceIdentifier("color/background/C102")
    static let C103 = NSColor.colorWith(hexAString: "80752C")
        .withAppearanceIdentifier("color/background/C103")
    static let C104 = NSColor.colorWith(hexAString: "2A5CAA")
        .withAppearanceIdentifier("color/background/C104")
    static let C105 = NSColor.colorWith(hexAString: "F05B72")
        .withAppearanceIdentifier("color/background/C105")
    static let C106 = NSColor.colorWith(hexAString: "905A3D")
        .withAppearanceIdentifier("color/background/C106")
    static let C107 = NSColor.colorWith(hexAString: "87843B")
        .withAppearanceIdentifier("color/background/C107")
    static let C108 = NSColor.colorWith(hexAString: "224B8F")
        .withAppearanceIdentifier("color/background/C108")
    
    
    
    
    
    static func colorWith(hexAString: String) -> NSColor {
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
    
    private static func colorWith(hexString: String) -> NSColor {
        var hexValue: UInt = 0
        let scanner = Scanner(string: hexString)
        scanner.scanInt(&hexValue)
        
        return NSColor(red: CGFloat((hexValue & 0xFF0000) >> 16) / 255, green: CGFloat((hexValue & 0xFF00) >> 8) / 255, blue: CGFloat(hexValue & 0xFF) / 255, alpha: 1)
    }
}
