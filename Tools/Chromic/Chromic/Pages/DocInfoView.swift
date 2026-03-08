//
//  DocInfoView.swift
//  Chromic
//
//  Created by hujinyou on 2025/7/17.
//

import SwiftUI

struct DocInfoView: View {
    @EnvironmentObject var resVM: ResourcesViewModel
    
    var body: some View {
        HStack {
            if let url = resVM.projectFolder {
                Button {
                    NSWorkspace.shared.activateFileViewerSelecting([url])
                } label: {
                    Text(url.absoluteString)
                        .foregroundStyle(Color.accentColor)
                }
                .buttonStyle(.borderless)
            }
            
            Spacer()
            
            Button {
                resVM.showFiles.toggle()
            } label: {
                Image(systemName: "inset.filled.tophalf.rectangle")
            }
        }
    }
}
