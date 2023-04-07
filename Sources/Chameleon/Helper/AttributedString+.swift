//
//  File.swift
//  
//
//  Created by Jo on 2023/4/7.
//

import Foundation

public extension NSAttributedString {
    struct ColorElement {
        let color: NSUIAppearanceColor
        let identifier: AppearanceCallableIdentifier
        let range: NSRange
    }
    
    func colorAppearancedElements() -> [ColorElement]? {
        var elements: [ColorElement] = []
        
        enumerateAttribute(.foregroundColor, in: NSMakeRange(0, length)) { color, range, stop in
            guard let color = color as? NSUIAppearanceColor else { return }
            guard let appearanceIdentifier = color.appearanceIdentifier else { return }
            elements.append(ColorElement(color: color, identifier: appearanceIdentifier, range: range))
        }
        
        return elements.count == 0 ? nil : elements
    }
    
    func updateAppearancedValues(_ elements: Any?) -> NSAttributedString {
        guard let elements = elements as? [ColorElement] else { return self }
        
        func getMutableAttributedString() -> NSMutableAttributedString {
            if let target = self as? NSMutableAttributedString {
                return target
            }
            
            return NSMutableAttributedString(attributedString: self)
        }
        
        let mutableAttributedString = getMutableAttributedString()
        
        for element in elements {
            guard element.range.upperBound < self.length else { continue }
            let color = NSUIAppearanceColor.colorWith(appearanceIdentifier: element.identifier) ?? element.color
            mutableAttributedString.addAttributes([.foregroundColor: color], range: element.range)
        }
        
        return self
    }
}
