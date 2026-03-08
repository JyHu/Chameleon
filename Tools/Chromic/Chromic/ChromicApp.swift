//
//  ChromicApp.swift
//  Chromic
//
//  Created by hujinyou on 2025/7/17.
//

import SwiftUI

@main
struct ChromicApp: App {    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(GlobalViewModel.shared.generateResVM())
        }
        .windowToolbarStyle(.unifiedCompact)
        .restorationBehavior(.disabled)
    }
}
