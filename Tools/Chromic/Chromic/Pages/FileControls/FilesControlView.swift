//
//  FilesControlView.swift
//  Chromic
//
//  Created by hujinyou on 2025/7/17.
//

import SwiftUI
import Cocoa

private enum _ControlTab: String, Identifiable, CaseIterable {
    case appearanceFiles = "Appearance Files"
    case imageLocations = "Image Locations"
    case imageCode = "Image Code"
    case colorCode = "Color Code"
    
    var id: String { rawValue }
}

struct FilesControlView: View {
    @EnvironmentObject private var resVM: ResourcesViewModel
    @State private var selectedTab: _ControlTab = .appearanceFiles
    @State private var showAlert = false
    
    var body: some View {
        if resVM.projectFolder == nil {
            VStack {
                Text("No project, please chooice first")
                    .foregroundStyle(.secondary)
                
                ImportView(allowedContentTypes: [.folder]) { urls in
                    if let url = urls.first {
                        if GlobalViewModel.shared.checkHadOpen(at: url) {
                            showAlert = true
                        } else {
                            resVM.projectFolder = urls.first
                        }
                    }
                }
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .alert("Alert", isPresented: $showAlert, actions: { }) {
                Text("当前目录下存在已经打开的项目，请重新选择")
            }
        } else {
            VStack {
                HStack {
                    Picker("", selection: $selectedTab) {
                        ForEach(_ControlTab.allCases) { tab in
                            Text(tab.rawValue).tag(tab)
                        }
                    }
                    .pickerStyle(.segmented)
                    .labelsHidden()
                    .fixedSize()
                    
                    Spacer()
                    
                    switch selectedTab {
                    case .appearanceFiles:  AppearanceFilesView.Actions()
                    case .imageLocations:   ImageLocationsView.Actions()
                    case .imageCode:        ImageCodeView.Actions()
                    case .colorCode:        ColorCodeView.Actions()
                    }
                }
                .padding(.top, 8)
                .padding(.horizontal, 10)
                
                switch selectedTab {
                case .appearanceFiles:  AppearanceFilesView()
                case .imageLocations:   ImageLocationsView()
                case .imageCode:        ImageCodeView()
                case .colorCode:        ColorCodeView()
                }
            }
        }
    }
}
