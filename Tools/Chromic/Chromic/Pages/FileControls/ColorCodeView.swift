//
//  ColorCodeView.swift
//  Chromic
//
//  Created by hujinyou on 2025/7/18.
//

import SwiftUI

struct ColorCodeView: View {
    @EnvironmentObject var resVM: ResourcesViewModel
    
    var body: some View {
        VStack {
            if let urlItem = resVM.colorCodeFile {
                HStack {
                    Button {
                        NSWorkspace.shared.activateFileViewerSelecting([urlItem.url])
                    } label: {
                        Label(urlItem.relativePath, sfname: .link)
                            .foregroundStyle(Color.accentColor)
                    }
                    .buttonStyle(.borderless)
                    
                    Spacer()
                }
                .padding(.horizontal, 10)
            }
            
            TextEditor(text: $resVM.colorCodeModule)
        }
    }
}

extension ColorCodeView {
    struct Actions: View {
        @EnvironmentObject var resVM: ResourcesViewModel

        var body: some View {
            ImportView(allowedContentTypes: [.swiftSource, .objectiveCSource]) { urls in
                if let url = urls.first {
                    resVM.update(colorCodeFile: url)
                }
            } label: {
                if let url = resVM.colorCodeFile {
                    Text(url.relativePath)
                } else {
                    Image(systemName: "plus")
                }
            }
        }
    }
}
