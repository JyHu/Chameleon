//
//  File.swift
//  
//
//  Created by Jo on 2023/4/5.
//

#if canImport(Cocoa)
import Cocoa
public typealias NSUIAppearanceColor = NSColor
public typealias NSUIAppearanceImage = NSImage
#elseif canImport(UIKit)
import UIKit
public typealias NSUIAppearanceColor = UIColor
public typealias NSUIAppearanceImage = UIImage
#endif

public typealias AppearanceCallableCategory = String
public typealias AppearanceCallableIdentifier = String

