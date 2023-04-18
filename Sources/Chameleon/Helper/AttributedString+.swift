//
//  File.swift
//  
//
//  Created by Jo on 2023/4/7.
//

import Foundation

public extension NSAttributedString {
    /// 缓存颜色属性的位置信息
    struct ColorElement {
        /// 颜色值
        let color: NSUIAppearanceColor
        /// 换肤的颜色属性标识
        let identifier: AppearanceCallableIdentifier
        /// 颜色属性的位置
        let range: NSRange
    }
    
    /// 获取当前富文本的所有颜色属性的位置信息
    func colorAppearancedElements() -> [ColorElement] {
        var elements: [ColorElement] = []
        
        func enumerate(_ key: NSAttributedString.Key) {
            enumerateAttribute(key, in: NSMakeRange(0, length)) { color, range, stop in
                guard let color = color as? NSUIAppearanceColor else { return }
                guard let appearanceIdentifier = color.appearanceIdentifier else { return }
                elements.append(ColorElement(color: color, identifier: appearanceIdentifier, range: range))
            }
        }
        
        enumerate(.foregroundColor)
        enumerate(.backgroundColor)
        enumerate(.strokeColor)
        enumerate(.underlineColor)
        enumerate(.strikethroughColor)
        
        return elements
    }
    
    /// 使用缓存的颜色属性位置信息来更新富文本
    func updateAppearancedValues(_ elements: [ColorElement]) -> NSAttributedString {        
        func getMutableAttributedString() -> NSMutableAttributedString {
            if let target = self as? NSMutableAttributedString {
                return target
            }
            
            return NSMutableAttributedString(attributedString: self)
        }
        
        let mutableAttributedString = getMutableAttributedString()
        
        /// 遍历所有的缓存信息，用换肤资源中有效的值来替换
        for element in elements {
            guard element.range.upperBound <= self.length else { continue }
            let color = NSUIAppearanceColor.colorWith(appearanceIdentifier: element.identifier) ?? element.color
            mutableAttributedString.addAttributes([.foregroundColor: color], range: element.range)
        }
        
        return mutableAttributedString
    }
}
