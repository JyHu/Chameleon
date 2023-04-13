//
//  File.swift
//  
//
//  Created by Jo on 2023/4/12.
//

#if os(macOS)
import Cocoa
#else
import UIKit
#endif
import Chameleon

protocol TestThemeInfosProtocol {
    static var C001: NSUIAppearanceColor { get }
    static var C002: NSUIAppearanceColor { get }
    static var C003: NSUIAppearanceColor { get }
    static var C004: NSUIAppearanceColor { get }
    static var C005: NSUIAppearanceColor { get }
    static var C006: NSUIAppearanceColor { get }
    static var C007: NSUIAppearanceColor { get }
    static var C008: NSUIAppearanceColor { get }
    
#if os(macOS)
    static var image01: NSUIAppearanceImage? { get }
    static var image02: NSUIAppearanceImage? { get }
    static var image03: NSUIAppearanceImage? { get }
    static var appearancedImage01: NSUIAppearanceImage? { get }
    static var appearancedImage02: NSUIAppearanceImage? { get }
    static var appearancedImage03: NSUIAppearanceImage? { get }
#endif
}

struct ThemeInfos {
    struct Theme0: TestThemeInfosProtocol {
        static let C001 = NSUIAppearanceColor(hex: 0xF7ACBC).withAppearanceIdentifier("color/text/C001")
        static let C002 = NSUIAppearanceColor(hex: 0xEF5B9C).withAppearanceIdentifier("color/text/C002")
        static let C003 = NSUIAppearanceColor(hex: 0xFEEEED).withAppearanceIdentifier("color/text/C003")
        static let C004 = NSUIAppearanceColor(hex: 0xF05B72).withAppearanceIdentifier("color/text/C004")
        static let C005 = NSUIAppearanceColor(hex: 0xFAA755).withAppearanceIdentifier("color/text/C005")
        static let C006 = NSUIAppearanceColor(hex: 0xD71345).withAppearanceIdentifier("color/text/C006")
        static let C007 = NSUIAppearanceColor(hex: 0x905D1D).withAppearanceIdentifier("color/text/C007")
        static let C008 = NSUIAppearanceColor(hex: 0x1D953F).withAppearanceIdentifier("color/text/C008")
        
#if os(macOS)
        static let image01 = Bundle.module.image(forResource: "bullseye_icon_252137")
        static let image02 = Bundle.module.image(forResource: "dinosaur_icon_252012")
        static let image03 = Bundle.module.image(forResource: "heart_love_icon_251954")
        static let appearancedImage01 = image01?.withAppearanceIdentifier("image/no01")
        static let appearancedImage02 = image02?.withAppearanceIdentifier("image/no02")
        static let appearancedImage03 = image03?.withAppearanceIdentifier("image/no03")
#endif
    }
    
    struct Theme1: TestThemeInfosProtocol {
        static let C001 = NSUIAppearanceColor(hex: 0xB17936, alpha: 0.9).withAppearanceIdentifier("color/text/C001")
        static let C002 = NSUIAppearanceColor(hex: 0xFEDCBD, alpha: 0.9).withAppearanceIdentifier("color/text/C002")
        static let C003 = NSUIAppearanceColor(hex: 0xF47920, alpha: 0.9).withAppearanceIdentifier("color/text/C003")
        static let C004 = NSUIAppearanceColor(hex: 0x905A3D, alpha: 0.9).withAppearanceIdentifier("color/text/C004")
        static let C005 = NSUIAppearanceColor(hex: 0xB2D235, alpha: 0.9).withAppearanceIdentifier("color/text/C005")
        static let C006 = NSUIAppearanceColor(hex: 0x5C7A29, alpha: 0.9).withAppearanceIdentifier("color/text/C006")
        static let C007 = NSUIAppearanceColor(hex: 0xA3CF62, alpha: 0.9).withAppearanceIdentifier("color/text/C007")
        static let C008 = NSUIAppearanceColor(hex: 0x694D9F, alpha: 0.9).withAppearanceIdentifier("color/text/C008")
        
#if os(macOS)
        static let image01 = Bundle.module.image(forResource: "home_house_icon_251952")
        static let image02 = Bundle.module.image(forResource: "human_handsup_icon_251948")
        static let image03 = Bundle.module.image(forResource: "mood_happy_icon_251870")
        static let appearancedImage01 = image01?.withAppearanceIdentifier("image/no01")
        static let appearancedImage02 = image02?.withAppearanceIdentifier("image/no02")
        static let appearancedImage03 = image03?.withAppearanceIdentifier("image/no03")
#endif
    }
    
    struct Theme2: TestThemeInfosProtocol {
        static let C001 = NSUIAppearanceColor(hex: 0x444693, alpha: 0.8).withAppearanceIdentifier("color/text/C001")
        static let C002 = NSUIAppearanceColor(hex: 0x2B4490, alpha: 0.8).withAppearanceIdentifier("color/text/C002")
        static let C003 = NSUIAppearanceColor(hex: 0x2A5CAA, alpha: 0.8).withAppearanceIdentifier("color/text/C003")
        static let C004 = NSUIAppearanceColor(hex: 0x102B6A, alpha: 0.8).withAppearanceIdentifier("color/text/C004")
        static let C005 = NSUIAppearanceColor(hex: 0x1A2933, alpha: 0.8).withAppearanceIdentifier("color/text/C005")
        static let C006 = NSUIAppearanceColor(hex: 0x6A6DA9, alpha: 0.8).withAppearanceIdentifier("color/text/C006")
        static let C007 = NSUIAppearanceColor(hex: 0x494E8F, alpha: 0.8).withAppearanceIdentifier("color/text/C007")
        static let C008 = NSUIAppearanceColor(hex: 0xFCAF17, alpha: 0.8).withAppearanceIdentifier("color/text/C008")
        
#if os(macOS)
        static let image01 = Bundle.module.image(forResource: "trash_delete_remove_icon_251766")
        static let image02 = Bundle.module.image(forResource: "visible_eye_icon_251745")
        static let image03 = Bundle.module.image(forResource: "zap_icon_251733")
        static let appearancedImage01 = image01?.withAppearanceIdentifier("image/no01")
        static let appearancedImage02 = image02?.withAppearanceIdentifier("image/no02")
        static let appearancedImage03 = image03?.withAppearanceIdentifier("image/no03")
#endif
    }
}

fileprivate extension NSUIAppearanceColor {
    convenience init(hex: UInt, alpha: CGFloat = 1) {
        let r = hex >> 16
        let g = (hex >> 8) & 0xFF
        let b = hex & 0xFF
        
        self.init(red: CGFloat(r) / 255, green: CGFloat(g) / 255, blue: CGFloat(b) / 255, alpha: alpha)
    }
}
