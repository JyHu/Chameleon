//
//  File.swift
//  
//
//  Created by Jo on 2023/4/3.
//

import Foundation

internal extension String {
    func app_substringWithPattern(_ pattern: String) -> String? {
        let nsstring = NSString(string: self)
        let range = nsstring.range(of: pattern, options: .regularExpression)
        if range.location == NSNotFound {
            return nil
        }
        
        return nsstring.substring(with: range).replacingOccurrences(of: " ", with: "")
    }
    
    func app_substringFrom(_ index: Int) -> String? {
        if index >= count || index < 0 {
            return nil
        }
        
        return NSString(string: self).substring(from: index)
    }
}
