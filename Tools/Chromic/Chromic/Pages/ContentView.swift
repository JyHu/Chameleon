//
//  ContentView.swift
//  Chromic
//
//  Created by hujinyou on 2025/7/17.
//

import SwiftUI

enum SourceType: String, Identifiable, CaseIterable {
    case appearances
    case images
    
    var id: String { rawValue }
}

struct ContentView: View {
    @EnvironmentObject var resVM: ResourcesViewModel
    
    @State private var chooiceProjectFolder: Bool = false
    @State private var sourceType: SourceType = .appearances
    
    var body: some View {
        VSplitView {
            HSplitView {
                Group {
                    switch sourceType {
                    case .appearances:  AppearanceView()
                    case .images:       ImagesView()
                    }
                }
                .frame(minWidth: 200)
                
                if resVM.showDetail {
                    EditorView()
                        .frame(minWidth: 300)
                }
            }
            .frame(minHeight: 200)
            
            if resVM.showFiles {
                FilesControlView()
                    .frame(minHeight: 200)
            }
            
            DocInfoView()
                .frame(height: 30)
                .padding(.horizontal, 10)
        }
        .toolbar {
            ToolbarItem {
                Picker("", selection: $sourceType) {
                    ForEach(SourceType.allCases) {
                        Text($0.rawValue).tag($0)
                    }
                }
                .pickerStyle(.segmented)
                .labelsHidden()
            }
            
            ToolbarItem {
                Toggle(isOn: $resVM.showDetail) {
                    Image(sfname: .sidebarRight)
                }
            }
        }
        .disabled(resVM.isProcessing)
    }
}

#Preview {
    ContentView()
}
