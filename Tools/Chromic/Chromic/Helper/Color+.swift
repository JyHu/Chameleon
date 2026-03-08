//
//  Color+.swift
//  Chromic
//
//  Created by hujinyou on 2025/7/20.
//

import SwiftUI

extension Color {
    /// Initialize a `Color` from a hex string with optional alpha.
    /// Examples of supported formats:
    /// - "#00AA00"
    /// - "00AA00"
    /// - "0x00AA00"
    /// - "00AA00 0.3"
    /// - "#00AA00 0.3"
    /// - "0x00AA00 0.3"
    init?(hexString: String) {
        let components = hexString.trimmingCharacters(in: .whitespacesAndNewlines).components(separatedBy: .whitespaces)
        guard let hex = components.first else { return nil }
        
        let alpha: Double = {
            if components.count > 1, let value = Double(components[1]) {
                return min(max(value, 0), 1)
            }
            return 1.0
        }()
        
        let hexString = hex
            .replacingOccurrences(of: "#", with: "")
            .replacingOccurrences(of: "0x", with: "")
            .replacingOccurrences(of: "0X", with: "")
        
        guard hexString.count == 6 else { return nil }
        
        let scanner = Scanner(string: hexString)
        var hexNumber: UInt64 = 0
        guard scanner.scanHexInt64(&hexNumber) else { return nil }
        
        let r = Double((hexNumber & 0xFF0000) >> 16) / 255.0
        let g = Double((hexNumber & 0x00FF00) >> 8) / 255.0
        let b = Double(hexNumber & 0x0000FF) / 255.0
        
        self.init(.sRGB, red: r, green: g, blue: b, opacity: alpha)
    }
}
