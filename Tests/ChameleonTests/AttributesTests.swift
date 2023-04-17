//
//  File.swift
//  
//
//  Created by Jo on 2023/4/16.
//

import Foundation
import XCTest
#if os(macOS)
import Cocoa
#else
import UIKit
#endif
import Chameleon

extension Dictionary where Key == NSAttributedString.Key {
    func attributes(equalTo dict2Block: @autoclosure () -> [Key: Any]) -> Bool {
        let dict2 = dict2Block()
        
        guard self.count == dict2.count else { return false }
        
        for (key, value) in self {
            guard let value2 = dict2[key] else { return false }
        
            if key == .foregroundColor || key == .backgroundColor {
                guard let color1 = value as? NSUIAppearanceColor,
                      let color2 = value2 as? NSUIAppearanceColor else { return false }
                guard color1 == color2 else { return false }
            }
        }
        
        return true
    }
}
