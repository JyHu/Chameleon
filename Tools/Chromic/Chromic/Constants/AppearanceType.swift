//
//  AppearanceType.swift
//  Chromic
//
//  Created by hujinyou on 2025/7/19.
//

import SwiftUI

enum AppearanceType: String, Identifiable, CaseIterable {
    case image
    case color
    
    var id: String { rawValue }
}
